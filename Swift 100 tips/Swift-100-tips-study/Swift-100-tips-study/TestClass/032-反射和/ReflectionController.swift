//
//  ReflectionController.swift
//  Swift-100-tips-study
//
//  Created by 解向前 on 2018/9/14.
//  Copyright © 2018年 com.test. All rights reserved.
//

//
// Swift不提供反射文档, 不提倡使用
// Swift都实现了 _Reflectable 的内部协议, 我们可以通过_reflect获取任意对象的一个镜像, 包含类型的基本信息, 2.0以移除
// 现在可以使用Mirror类
// Mirror 初始化, 得到的结果中包含的元素的描述都在children属性下
//        public typealias Child = (label: String?, value: Any)
//        public typealias Children = AnyCollection<Mirror.Type.Child>
// dump 函数可以获取一个对象的镜像并进行标准输出
// Mirror 为REPL环境和playground设计


import UIKit

class ReflectionController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        test()
    }

    func test() {
        struct Person {
            let name: String
            let age: Int
        }
        let xiaoming = Person(name: "xiaoming", age: 18)
        let r = Mirror(reflecting: xiaoming)
        
        print("xiaoming 是 \(r.displayStyle)")
        print("属性个数: \(r.children.count)")
        for child in r.children {
            print("属性名: \(String(describing: child.label)), 值: \(child.value)")
        }
        
        print("---------------------")
        
        dump(xiaoming)
        
        print("---------------------")
        
        func valueFrom(_ object: Any, key: String) -> Any? {
            let mirror = Mirror(reflecting: object)
            for child in mirror.children {
                let (targetKey, targetMirror) = (child.label, child.value)
                if key == targetKey {
                    return targetMirror
                }
            }
            return nil
        }
        if let name = valueFrom(xiaoming, key: "name") as? String {
            print("通过key得到的值: \(name)")
        }
    }
}
