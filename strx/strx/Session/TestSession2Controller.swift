//
//  TestSession2Controller.swift
//  strx
//
//  Created by IOS3 on 2018/12/6.
//  Copyright © 2018 IOS3. All rights reserved.
//

// 使用 ObjectMapper 转模型

import UIKit
import RxSwift
import RxCocoa
import ObjectMapper
import RxDataSources

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

class TestSession2Controller: BaseController {
    
    var tableView:UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView = UITableView(frame: view.frame, style: .plain)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        
        
        let urlString = "https://www.douban.com/j/app/radio/channels"
        if let url = URL(string: urlString) {
            let requset = URLRequest(url: url)
            
            let data = URLSession.shared.rx.json(request: requset)
                .mapObject(type: Douban.self)
                .map { $0.channels ?? [] }
            
            data.bind(to: tableView.rx.items){ tv, row, it in
                let cell = tv.dequeueReusableCell(withIdentifier: "cell")
                if let cell = cell {
                    cell.textLabel?.text = it.name
                    return cell
                }
                return UITableViewCell()
            }.disposed(by: disposeBag)
            
        }
        
        
    }
    

    
    func test1() {
        let urlString = "https://www.douban.com/j/app/radio/channels"
        if let url = URL(string: urlString) {
            let requset = URLRequest(url: url)
            
            URLSession.shared.rx.json(request: requset)
                .mapObject(type: Douban.self)
                .subscribe(onNext: { douban in
                    if let channels = douban.channels {
                        print("共\(channels.count)个频道")
                        for channel in channels {
                            if let name = channel.name,
                                let id = channel.channelId {
                                print("\(name) (id: \(id)")
                            }
                        }
                    }
                })
                .disposed(by: disposeBag)
        }
        
        
    }
  

}

// 数据映射错误
fileprivate enum RxObjectMapperError: Error {
    case parsingError
}

// 拓展 Observable, 增加模型映射方法
fileprivate extension Observable where Element: Any {
    // 将 json -> 对象
    func mapObject<T>(type: T.Type) -> Observable<T> where T: Mappable {
        let mapper = Mapper<T>()
        return self.map { element in
            guard let parsedElement = mapper.map(JSONObject: element) else {
                throw RxObjectMapperError.parsingError
            }
            return parsedElement
        }
    }
    
    // 将 json -> 数组
    func mapArray<T>(type: T.Type) -> Observable<[T]> where T: Mappable {
        let mapper = Mapper<T>()
        return self.map { element in
            guard let parsedArray = mapper.mapArray(JSONObject: element) else {
                throw RxObjectMapperError.parsingError
            }
            return parsedArray
        }
    }
}

