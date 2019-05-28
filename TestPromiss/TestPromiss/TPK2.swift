//
//  TPK2.swift
//  TestPromiss
//
//  Created by IOS3 on 2019/5/9.
//  Copyright © 2019 IOS3. All rights reserved.
//

import UIKit
import PromiseKit
import PMKFoundation


class TPK2: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        title = "URLSession 扩展"
        
        test_02()
    }
 

}

fileprivate typealias Doc = TPK2
fileprivate typealias Test = TPK2


fileprivate extension Doc {
    
}

fileprivate extension Test {
    func test_01() {
        let urlstring = "https://httpbin.org/get?foo=bar"
        let url = URL(string: urlstring)
        guard url != nil else { fatalError() }
        let request = URLRequest(url: url!)
        
        _ = URLSession.shared.dataTask(.promise, with: request)
            .validate() //这个也是PromiseKit提供的扩展方法，比如自动将 404 转成错误
            .done({ (data, response) in
                let str = String(data: data, encoding: .utf8)
                print("--- 请求结果如下 ---")
                print(str ?? "")
            })
    }
    
    
    
    func test_02() {
        func fetchData(args: String) -> Promise<Any> {
            let urlstring = "https://httpbin.org/get?\(args)"
            let url = URL(string: urlstring)
            guard let url_ = url else { fatalError() }
            let request = URLRequest(url: url_)
            
            return URLSession.shared.dataTask(.promise, with: request)
                .validate()
                .map{ try JSONDecoder().decode(HttpBin.self, from: $0.data) }
        }
        
        fetchData(args: "foo=bar")
            .done { (data) in
                print("--- 请求结果如下 ---")
                print(data)
            }
            .catch { (error) in
                print("--- 请求失败 ---")
                print(error)
        }
    }
}


fileprivate struct HttpBin: Codable {
    var origin: String
    var url: String
}
