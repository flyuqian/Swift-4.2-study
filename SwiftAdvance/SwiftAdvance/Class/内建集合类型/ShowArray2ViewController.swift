//
//  ShowArray2ViewController.swift
//  SwiftAdvance
//
//  Created by IOS3 on 2018/10/30.
//  Copyright © 2018 com.test. All rights reserved.
//

//
// 内见集合类型
// 

import UIKit

class ShowArray2ViewController: NormalBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
//        test1()
        test2()
        
        
        
        
        
    }
    
    
    
    
    
    /// 字典
    fileprivate func test2() {
        enum Setting {
            case text(String)
            case int(Int)
            case bool(Bool)
        }
        let defaultSettings: [String : Setting] = [
            "AirPlane Model" : .bool(false),
            "Name" : .text("My iPhone")
        ]
        print(defaultSettings["Name"] ?? "")
        
        var userSetting = defaultSettings
        userSetting.updateValue(.int(4), forKey: "value")
        print(userSetting)
        
        let overriddenSettings: [String : Setting] = ["Name" : .text("Jane iPhone")]
        userSetting.merge(overriddenSettings, uniquingKeysWith: {$1})
        print(userSetting)
    }
    
    
    

    /// 数组切片
    fileprivate func test1() {
        
        // 想要获取数组中除了首个元素的其他元素
        let fibs = [0, 1, 1, 2, 3, 5, 8]
        let slice = fibs[1...]
        print(type(of: slice))
        
        // 切片类型只是数组的一种表达方式, 背后的数据依旧是原来的数组, 只不过用切片的方式来表示
        // 这意味着原来的数组并不需要被复制, ArraySlice具有Array上定义的方法一致, 可以转换为数组
        
        // Swift数组可以桥街到OC中, NSArray只能持有对象, 所以对其不兼容的值(比如枚举)用一个不透明的box对象包装, 而Int, String等自动桥接为OC类型
    }

}
