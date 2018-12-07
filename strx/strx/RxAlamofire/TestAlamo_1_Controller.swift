//
//  TestAlamo_1_Controller.swift
//  strx
//
//  Created by IOS3 on 2018/12/7.
//  Copyright © 2018 IOS3. All rights reserved.
//

import UIKit
import RxSwift
import Alamofire
import RxAlamofire


class TestAlamo_1_Controller: BaseController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        test4()
    }
    
    
    
    func test4() {
        
        let btn1 = UIButton(frame: CGRect(x: 0, y: 100, width: 100, height: 100))
        btn1.setTitle("发起请求", for: .normal)
        btn1.setTitleColor(.blue, for: .normal)
        view.addSubview(btn1)
        
        let btn2 = UIButton(frame: CGRect(x: 0, y: 240, width: 100, height: 100))
        btn2.setTitle("取消请求", for: .normal)
        btn2.setTitleColor(.blue, for: .normal)
        view.addSubview(btn2)
        
        
        let urlString = "https://www.douban.com/j/app/radio/channels"
        let url = URL(string:urlString)!
        
        btn1.rx.tap.asObservable()
            .flatMap {
                request(.get, url).responseString()
                    .takeUntil(btn2.rx.tap)
            }
            .subscribe(onNext: {
                response, data in
                print("请求成功, 返回的数据: ", data)
            }, onError: { error in
                print("请求失败, 错误原因: ", error)
                
            }).disposed(by: disposeBag)
    }
    
    
    
    
    func test3() {
        let urlString = "https://www.douban.com/j/app/radio/channels"
        let url = URL(string:urlString)!
        
        // requestString(<#T##method: HTTPMethod##HTTPMethod#>, <#T##url: URLConvertible##URLConvertible#>)
        request(.get, url)
            .responseString()
            .subscribe(onNext: { response, data in
                print("返回的数据是: ", data)
            }).disposed(by: disposeBag)
    }
    
    
    func test2() {
        let urlString = "https://www.douban.com/j/app/radio/channels"
        let url = URL(string:urlString)!
        
        requestData(.get, url).subscribe(onNext: { response, data in
            
            if 200 ..< 300 ~= response.statusCode {
                let str = String(data: data, encoding: .utf8)
                print("返回的数据是: ", str ?? " 空 ")
            }
            else {
                print("请求失败")
            }
            
        }).disposed(by: disposeBag)
    }


    func test1() {
        let urlString = "https://www.douban.com/j/app/radio/channels"
        let url = URL(string:urlString)!
        
        request(.get, url)
            .data()
            .subscribe(onNext: {
                data in
                let str = String(data: data, encoding: .utf8)
                print("返回的数据是: ", str ?? " 空 ")
            }, onError: { error in
                print("请求失败, 原因: ", error)
            }).disposed(by: disposeBag)
    }
}
