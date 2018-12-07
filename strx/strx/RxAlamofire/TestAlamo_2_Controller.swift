//
//  TestAlamo_2_Controller.swift
//  strx
//
//  Created by IOS3 on 2018/12/7.
//  Copyright © 2018 IOS3. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxAlamofire
import ObjectMapper

class TestAlamo_2_Controller: BaseController {

    
    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //创建表格视图
        tableView = UITableView(frame: view.frame, style:.plain)
        //创建一个重用的单元格
        tableView!.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView!)
        
        
        //创建URL对象
        let urlString = "https://www.douban.com/j/app/radio/channels"
        let url = URL(string:urlString)!
        
        let data = requestJSON(.get, url)
            .map { $1 }
            .mapObject(type: Douban.self)
            .map { $0.channels ?? [] }
//            .subscribe(onNext: { douban in
//                if let channels = douban.channels {
//                    print("共有 \(channels.count) 个频道")
//
//                }
//            })
        data.bind(to: tableView.rx.items){ tv, row, it in
            let cell = tv.dequeueReusableCell(withIdentifier: "Cell")
            cell?.textLabel?.text = "\(row): \(it.name)"
            return cell ?? UITableViewCell()
        }.disposed(by: disposeBag)
        
        
    }
    


}



//数据映射错误
fileprivate enum RxObjectMapperError: Error {
    case parsingError
}

//扩展Observable：增加模型映射方法
fileprivate extension Observable where Element:Any {
    
    //将JSON数据转成对象
    public func mapObject<T>(type:T.Type) -> Observable<T> where T:Mappable {
        let mapper = Mapper<T>()
        
        return self.map { (element) -> T in
            guard let parsedElement = mapper.map(JSONObject: element) else {
                throw RxObjectMapperError.parsingError
            }
            
            return parsedElement
        }
    }
    
    //将JSON数据转成数组
    public func mapArray< T>(type:T.Type) -> Observable<[T]> where T:Mappable {
        let mapper = Mapper<T>()
        
        return self.map { (element) -> [T] in
            guard let parsedArray = mapper.mapArray(JSONObject: element) else {
                throw RxObjectMapperError.parsingError
            }
            
            return parsedArray
        }
    }
}






//豆瓣接口模型
fileprivate class Douban: Mappable {
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

//频道模型
fileprivate class Channel: Mappable {
    var name: String?
    var nameEn:String?
    var channelId: String?
    var seqId: Int?
    var abbrEn: String?
    
    init(){
    }
    
    required init?(map: Map) {
    }
    
    // Mappable
    func mapping(map: Map) {
        name <- map["name"]
        nameEn <- map["name_en"]
        channelId <- map["channel_id"]
        seqId <- map["seq_id"]
        abbrEn <- map["abbr_en"]
    }
}
