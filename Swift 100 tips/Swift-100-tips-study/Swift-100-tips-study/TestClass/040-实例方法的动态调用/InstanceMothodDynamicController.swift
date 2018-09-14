//
//  InstanceMothodDynamicController.swift
//  Swift-100-tips-study
//
//  Created by 解向前 on 2018/9/14.
//  Copyright © 2018年 com.test. All rights reserved.
//

import UIKit

class InstanceMothodDynamicController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        class MyClass {
            func method(number: Int) -> Int {
                return number + 1
            }
        }
        
        let object = MyClass()
        let result = object.method(number: 1)
        print("result: \(result)")
        
        let f = MyClass.method
        let o1 = MyClass()
        let result2 = f(o1)(1)
        print("result2: \(result2)")
        
        // Swift 可以 直接使用 Type.instanceMethod 语法, 生成一个可以 柯里化的方法
        // 这种写法 只适用于实例方法, 属性的getter/setter无效
        
        class MyClass2 {
            func method(number: Int) -> Int {
                return number + 1
            }
            class func method(number: Int) -> Int {
                return number
            }
        }
        let o2 = MyClass2()
        let f1 = MyClass2.method
        let f2: (Int) -> Int = MyClass2.method
        let f3: (MyClass2) -> (Int) -> Int = MyClass2.method
        
        let r1 = f1(1)
        let r2 = f2(1)
        let r3 = f3(o2)(1)
        print("r1: \(r1), r2: \(r2), r3:\(r3)")
        // r1: 1, r2: 1, r3:2
    }

}
