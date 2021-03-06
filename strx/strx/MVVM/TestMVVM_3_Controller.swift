//
//  TestMVVM_3_Controller.swift
//  strx
//
//  Created by IOS3 on 2018/12/11.
//  Copyright © 2018 IOS3. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Moya
import ObjectMapper
import Result
import RxAlamofire



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




// MARK: Service
fileprivate class GithubNetService {
    func searchRepositories(query: String) -> Driver<GithubRepositories> {
        return GithubProvider.rx.request(.repositories(query))
            .filterSuccessfulStatusCodes()
            .mapJSON().asObservable()
            .mapObject(type: GithubRepositories.self)
            .asDriver(onErrorDriveWith: Driver.empty())
    }
}



// MARK: ViewModel
fileprivate class ViewModel {
    let networkService = GithubNetService()
    
    fileprivate let searchAction: Driver<String>
    
    let searchResult: Driver<GithubRepositories>
    let repositories: Driver<[GithubRepository]>
    let cleanResult: Driver<Void>
    let navTitle: Driver<String>
    
    init(searchAction: Driver<String>) {
        self.searchAction = searchAction
        
        self.searchResult = searchAction
            .filter { !$0.isEmpty }
            .flatMapLatest(networkService.searchRepositories)
        self.cleanResult = searchAction.filter { $0.isEmpty }.map { _ in Void() }
        self.repositories = Driver.merge(
            searchResult.map { $0.items },
            cleanResult.map { [] }
        )
        self.navTitle = Driver.merge(
            searchResult.map { "共有 \($0.totalCount!) 个结果"},
            cleanResult.map { "hangge.com" }
        )
    }
}




class TestMVVM_3_Controller: BaseController {

    var tableView: UITableView!
    var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView(frame: view.frame, style: .plain)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        
        searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 56))
        tableView.tableHeaderView = searchBar
        
        let searchAction = searchBar.rx.text.orEmpty.asDriver()
            .throttle(0.5)
            .distinctUntilChanged()
        
        let viewModel = ViewModel(searchAction: searchAction)
        
        viewModel.navTitle.drive(self.navigationItem.rx.title).disposed(by: disposeBag)
        viewModel.repositories.drive(tableView.rx.items) { tv, row, it in
            var cell = tv.dequeueReusableCell(withIdentifier: "cell")
            if cell == .none {
                cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
            }
            cell?.textLabel?.text = it.name
            cell?.detailTextLabel?.text = it.htmlUrl
            return cell!
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
