//
//  TPromiseC.swift
//  strx
//
//  Created by IOS3 on 2019/3/7.
//  Copyright © 2019 IOS3. All rights reserved.
//

import UIKit
import PromiseKit


class TPromiseC: BaseController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        test1(a: true) { (b) -> Bool in
//            return b
//        }

        
    }

    
    // Promise 的简单实用
//    func test01() {
//        Promise<Data> { (fulfill, reject) in
//            URLSession.shared
//                .dataTask(with: URL(string: "https://httpbin.org/get?foo=bar")!) { (data, _, error) in
//                    if let data = data {
//                        fulfill(data)
//                    } else if let error = error {
//                        reject(error)
//                    }
//                }
//                .resume()
//            }
//            .then { (data) in
//                Promise<Any> { (fulfill, error) in
//                    do {
//                        let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
//                        fulfill(json)
//                    } catch {
//                        fulfill(error)
//                    }
//                }
//            }
//            .then { (json) in
//                print(json)
//        }
//    }

}
