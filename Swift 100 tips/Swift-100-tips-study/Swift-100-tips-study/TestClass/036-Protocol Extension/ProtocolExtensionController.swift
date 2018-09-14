//
//  ProtocolExtensionController.swift
//  Swift-100-tips-study
//
//  Created by 解向前 on 2018/9/14.
//  Copyright © 2018年 com.test. All rights reserved.
//

//
// 我们可以对一个已有的protocol进行拓展, 拓展中实现的方法将作为实现拓展的类型的默认实现
// protocol extension 为方法提供了默认实现, 该方法便可认为是一个 可选协议方法
//
// 得到规则
//  如果类型推断得到的是实际类型
//      那么类型中的实现将被调用
//      如果类型中没有实现的话, 那么协议拓展中的默认实现将被使用
//  如果类型推断得到的是协议
//      并且方法在协议中进行了定义, 那么类型中的实现将被调用
//      如果类型中没有实现, 那么协议拓展中的默认实现被使用
//      否则(方法没有在协议中定义), 拓展中的默认实现将被调用

import UIKit

class ProtocolExtensionController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        MyStruct().method()
        MyStruct2().method()
        
        test()
    }
    
    struct MyStruct: MyProtocol {
        
    }
    struct MyStruct2: MyProtocol {
        func method() {
            print("called in struct")
        }
    }
    
    
    //MARK: 案例二 测试
    func test() {
        let b1 = B1()
        print("b1.method1(): \(b1.method1())")
        
        let a1: A1 = B1()
        print("b1.method1(): \(b1.method1())")
        
        let b2 = B2()
        print("b2.method1(): \(b2.method1())")
        print("b2.method2(): \(b2.method2())")
        
        let a2 = b2 as A2
        print("a2.method1(): \(a2.method1())")
        print("a2.method2(): \(a2.method2())")
        // 此时 b2 和 a2 是相同的对象, 但是调用 method2 却得到不同的结果
        // 避免 调用 拓展协议的方法, 可以将a2,转换为具体类型, 再调用方法
    }
}

fileprivate protocol MyProtocol {
    func method()
}
extension MyProtocol {
    func method() {
        print("called")
    }
}

// 案例
fileprivate protocol A1 {
    func method1() -> String
}
fileprivate struct B1: A1 {
    func method1() -> String {
        return "hello"
    }
}

fileprivate protocol A2 {
    func method1() -> String
}
extension A2 {
    func method1() -> String {
        return "Hi"
    }
    func method2() -> String {
        return "Hi"
    }
}
fileprivate struct B2: A2 {
    func method1() -> String {
        return "hello"
    }
    func method2() -> String {
        return "hello"
    }
}
