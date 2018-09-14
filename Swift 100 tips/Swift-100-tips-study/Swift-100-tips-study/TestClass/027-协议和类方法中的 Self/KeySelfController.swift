//
//  KeySelfController.swift
//  Swift-100-tips-study
//
//  Created by 解向前 on 2018/9/14.
//  Copyright © 2018年 com.test. All rights reserved.
//

//
//
//    protocol IntervalType {
//        func clamp(intervalToClamp: Self) -> Self
//    }
//    这个方法, 接收实现该协议的自身的类型, 返回一个同样的类型
// 协议本身没有自己的上下文类型信息, Swift中也不能在协议中定义泛型进行限制
// Self不仅指代实现协议的类型本身, 也包括了这个类型的子类
// 注意: 确保本身和子类都能够正确的立意

import UIKit

class KeySelfController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

fileprivate protocol Copyable {
    func copy() -> Self
}

fileprivate class MyClass: Copyable {
    var num = 1
    func copy() -> Self {
//        let result = MyClass()
//        result.num - num
//        return result
//        编译报错
//        该方法要求返回一个抽象的, 表示当前类型的Self, 而我们返回了真实类型MyClass, 所以无法编译
        
//        let result = type(of: self).init()
//        result.num = num
//        return result
//        编译报错
//        现在的init方法无法保证当前类和子类都能响应
//        可以声明当前类为final / 在init方法上加required
        let result = type(of: self).init()
        result.num = num
        return result
    }
    required init() {
        
    }
}
