//
//  TestMoya_1_Controller.swift
//  strx
//
//  Created by IOS3 on 2018/12/7.
//  Copyright © 2018 IOS3. All rights reserved.
//

import UIKit
import Moya
import RxMoya


// Moya 是一个基于 Alamofire 的更高层网络请求的封装抽象
// Moya 自身提供对 RxSwift 的拓展





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





class TestMoya_1_Controller: BaseController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        DoubanProvider.rx.request(.channels)
            .subscribe { event in
                switch event {
                case let .success(response):
                    let str = String(data: response.data, encoding: .utf8)
                    print("返回的数据是: \(str ?? "")")
                case let .error(error):
                    print("请求失败, 原因: ", error)
                }
        }.disposed(by: disposeBag)
        // 或者使用 subscribe(onSuccess: {}, onError:{}) 的方式处理
        
    }
    


}
