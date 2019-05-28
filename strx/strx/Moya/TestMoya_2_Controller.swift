//
//  TestMoya_2_Controller.swift
//  strx
//
//  Created by IOS3 on 2018/12/7.
//  Copyright © 2018 IOS3. All rights reserved.
//

import UIKit
//import RxMoya
import Moya
import ObjectMapper



class TestMoya_2_Controller: BaseController {
    
    var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // test01()

        
        tableView = UITableView(frame: view.frame, style: .plain)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        
        let data = DoubanProvider.rx.request(.channels)
            .mapJSON()
            .map { data -> [[String : Any]] in
                if let json = data as? [String : Any],
                    let channels = json["channels"] as? [[String :Any]] {
                    return channels
                }
                else {
                    return []
                }
            }.asObservable()
        
        data.bind(to: tableView.rx.items){ tv, row, it in
            let cell = tv.dequeueReusableCell(withIdentifier: "cell")
            cell?.textLabel?.text = "\(it["name"]!)"
            cell?.accessoryType = .disclosureIndicator
            return cell ?? UITableViewCell()
            
            }.disposed(by: disposeBag)
        
        tableView.rx.modelSelected([String: Any].self)
            .map { $0["channel_id"] as! String }
            .flatMap{ DoubanProvider.rx.request(.playList($0)) }
            .mapJSON()
//            .subscribe(onNext: { [weak self] data in
//                if let json = data as? [String : Any],
//                    let musics = json["song"] as? [[String : Any]] {
//                    let title = musics[0]["artist"]!
//                    print("\(title)")
//                }
        // 这边数据结构有些问题
                
//            }).disposed(by: disposeBag)
    }
    

    
    func test01() {
        // Moya 提供了 mapJSON方法
        // 一种使用为
        /*
         DouBanProvider.rx.request(.channels)
             .subscribe(onSuccess: { response in
                let json = try? response.mapJSON() as! [String: Any]
         */
        // 另一种
        DoubanProvider.rx.request(.channels)
            .mapJSON()
            .subscribe(onSuccess: { data in
                let json = data as! [String : Any]
                print("请求成功, 返回数据如下")
                print(json)
            }, onError: { error in
                print("请求失败, 错误为: ", error)
            })
            .disposed(by: disposeBag)
    }
    
}








// 网络请求层
fileprivate let DoubanProvider = MoyaProvider<DoubanAPi>()

/* 定义 豆瓣FM请求的 endpoints (供provider使用) */
// 请求分类
fileprivate enum DoubanAPi {
    /// 获取频道列表
    case channels
    /// 获取歌曲
    case playList(String)
}

extension DoubanAPi: TargetType {
    var baseURL: URL {
        switch self {
        case .channels:
            return URL(string: "https://www.douban.com")!
        case .playList(_):
            return URL(string: "https://douban.fm")!
        }
    }
    
    var path: String {
        switch self {
        case .channels:
            return "/j/app/radio/channels"
        case .playList(_):
            return "/j/mine/playlist"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    // 单元测试模拟的数据, 只会在单元测试文件中有作用
    var sampleData: Data {
        return "{}".data(using: .utf8)!
    }
    
    // 请求事件, 这里附带上参数
    var task: Task {
        switch self {
        case .playList(let channel):
            var params: [String : Any] = [:]
            params["channel"] = channel
            params["type"] = "n"
            params["from"] = "mainsite"
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
            
        default:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    
}




private class Douban: Mappable {
    //频道列表
    var channels: [Channel]?
    
    init(){
    }
    
    required init?(map: Map) {
    }
    
    // Mappable
    func mapping(map: Map) {
        channels <- map["channels"]
    }
}

private class Channel: Mappable {
    var name: String?
    var nameEn:String?
    var channelId: String?
    var seqId: Int?
    var abbrEn: String?
    
    init(){
    }
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        name <- map["name"]
        nameEn <- map["name_en"]
        channelId <- map["channel_id"]
        seqId <- map["seq_id"]
        abbrEn <- map["abbr_en"]
    }
}
