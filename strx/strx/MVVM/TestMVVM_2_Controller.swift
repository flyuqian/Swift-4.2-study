//
//  TestMVVM_2_Controller.swift
//  strx
//
//  Created by IOS3 on 2018/12/11.
//  Copyright © 2018 IOS3. All rights reserved.
//

//
// 案例需求
/*
 （1）当我们在表格上方的搜索框中输入文字时，会实时地去请求 GitHub 接口查询相匹配的资源库。
 （2）数据返回后，将查询结果数量显示在导航栏标题上，同时把匹配度最高的资源条目显示显示在表格中（这个是 GitHub 接口限制，由于数据太多，可能不会一次全部都返回）。
 （3）点击某个单元格，会弹出显示该资源的详细信息（全名和描述）
 （4）删除搜索框的文字后，表格内容同步清空，导航栏标题变成显示“hangge.com”
 */

import UIKit
import RxSwift
import RxMoya
import Moya
import ObjectMapper
import Result



// MARK: 网络请求层
fileprivate let GithubProvider = MoyaProvider<GithubAPI>()

fileprivate enum GithubAPI {
    /// 查询资源库
    case repositories(String)
}
extension GithubAPI: TargetType {
    /// 服务器地址
    var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }
    
    /// 请求路径
    var path: String {
        switch self {
        case .repositories:
            return "/search/repositories"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    //这个就是做单元测试模拟的数据，只会在单元测试文件中有作用
    var sampleData: Data {
        return "{}".data(using: .utf8)!
    }
    
    /// 请求任务事件 (这里附带上参数)
    var task: Task {
        print("发起请求")
        switch self {
        case .repositories(let query):
            var params: [String : Any] = [:]
            params["q"] = query
            params["sort"] = "stars"
            params["order"] = "desc"
            return .requestParameters(parameters: params, encoding: URLEncoding.default)

        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    
}



// MARK: 实例模型
//单个仓库模型
fileprivate struct GithubRepository: Mappable {
    var id: Int!
    var name: String!
    var fullName:String!
    var htmlUrl:String!
    var description:String!
    
    init?(map: Map) { }
    
    // Mappable
    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        fullName <- map["full_name"]
        htmlUrl <- map["html_url"]
        description <- map["description"]
    }
}
fileprivate struct GithubRepositories: Mappable {
    var totalCount: Int!
    var incompleteResults: Bool!
    var items: [GithubRepository]! //本次查询返回的所有仓库集合
    
    init() {
        print("init()")
        totalCount = 0
        incompleteResults = false
        items = []
    }
    
    init?(map: Map) { }
    
    // Mappable
    mutating func mapping(map: Map) {
        totalCount <- map["total_count"]
        incompleteResults <- map["incomplete_results"]
        items <- map["items"]
    }
}




// MARK: 映射
//数据映射错误
fileprivate enum RxObjectMapperError: Error {
    case parsingError
}

//扩展Observable：增加模型映射方法
fileprivate extension Observable where Element:Any {
    
    //将JSON数据转成对象
    fileprivate func mapObject<T>(type:T.Type) -> Observable<T> where T:Mappable {
        let mapper = Mapper<T>()
        
        return self.map { (element) -> T in
            guard let parsedElement = mapper.map(JSONObject: element) else {
                throw RxObjectMapperError.parsingError
            }
            
            return parsedElement
        }
    }
    
    //将JSON数据转成数组
    fileprivate func mapArray<T>(type:T.Type) -> Observable<[T]> where T:Mappable {
        let mapper = Mapper<T>()
        
        return self.map { (element) -> [T] in
            guard let parsedArray = mapper.mapArray(JSONObject: element) else {
                throw RxObjectMapperError.parsingError
            }
            
            return parsedArray
        }
    }
}






// MARK: ViewModel
fileprivate class ViewModel {
    
    /**** 输入部分 ***/
    let searchAction: Observable<String>
    
    /**** 输出部分 ***/
    // 所有查询结果
    let searchResult: Observable<GithubRepositories>
    // 查询结果里的资源列表
    let repositories: Observable<[GithubRepository]>
    // 清空结果动作
    let cleanResult: Observable<Void>
    // 导航栏标题
    let navigationTitle: Observable<String>
    
    // ViewModel 初始化(根据输入实现对应的输出)
    init(searchAction: Observable<String>) {
        self.searchAction = searchAction

        //生成查询结果序列
        self.searchResult = searchAction
            .filter { !$0.isEmpty } //如果输入为空则不发送请求了
            .flatMapLatest{  //也可考虑改用flatMapFirst
                GithubProvider.rx.request(.repositories($0))
                    .filterSuccessfulStatusCodes()
                    .mapJSON()
                    .asObservable()
                    .mapObject(type: GithubRepositories.self)
                    .asObservable()
                    .catchError({ error in
                        print("发生错误: ", error.localizedDescription)
                        return Observable<GithubRepositories>.empty()
                    })
            }.share(replay: 1) //让HTTP请求是被共享的

        self.cleanResult = searchAction.filter { $0.isEmpty }.map { _ in Void() }
        self.repositories = Observable.of(searchResult.map { $0.items }, cleanResult.map{ [] }).merge()
        self.navigationTitle = Observable.of(searchResult.map{ "共有 \($0.totalCount!) 个结果"}, cleanResult.map{ "hangge.com" }).merge()
    }
    
}


class TestMVVM_2_Controller: BaseController {
    
    var tableView: UITableView!
    var searchBar: UISearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView = UITableView(frame: view.frame, style: .plain)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        
        searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 56))
        tableView.tableHeaderView = searchBar
        
        
        let searchAction = searchBar.rx.text.orEmpty
            .throttle(0.5, scheduler: MainScheduler.instance) //只有间隔超过0.5k秒才发送
            .distinctUntilChanged()
            .asObservable()
        
        let viewModel = ViewModel(searchAction: searchAction)
        
        viewModel.navigationTitle.bind(to: navigationItem.rx.title).disposed(by: disposeBag)
        viewModel.repositories.bind(to: tableView.rx.items) { tv, row, it in
            let cell = tv.dequeueReusableCell(withIdentifier: "cell", for: IndexPath(item: row, section: 1))
            cell.textLabel?.text = it.name
            cell.detailTextLabel?.text = it.htmlUrl
            return cell
        }.disposed(by: disposeBag)
        tableView.rx.modelSelected(GithubRepository.self)
            .subscribe(onNext: { [weak self] item in
                self?.showAlert(title: item.fullName, message: item.description)
            }).disposed(by: disposeBag)
        
    }
    

    
    //显示消息
    func showAlert(title:String, message:String){
        let alertController = UIAlertController(title: title,
                                                message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    

}
