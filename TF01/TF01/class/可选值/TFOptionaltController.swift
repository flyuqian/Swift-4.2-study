//
//  TFOptionaltController.swift
//  TF01
//
//  Created by IOS3 on 2018/12/18.
//  Copyright © 2018 IOS3. All rights reserved.
//

import UIKit

class TFOptionaltController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "可选值"
        view.backgroundColor = .white
        
    }
    

    func test01() {
        let order = Order(orderNumber: 3, person: nil)
        // order.person?.address?.city
        // 可选连使用
        if let city = order.person?.address?.city {
            print("目标城市: " + city)
        }
        else {
            print("无法获取目标城市")
        }
    }
    
    // 可选值, 可以使用 iflet guardlet switch map flatMap 解决

    
}


//MARK: 可选链
fileprivate struct Order {
    let orderNumber: Int
    let person: Person?
}
fileprivate struct Person {
    let name: String
    let address: Address?
}
fileprivate struct Address {
    let streetName: String
    let city: String
    let state: String?
}
