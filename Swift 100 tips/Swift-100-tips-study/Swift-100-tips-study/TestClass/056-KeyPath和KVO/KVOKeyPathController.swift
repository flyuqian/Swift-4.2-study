
//
//  KVOKeyPathController.swift
//  Swift-100-tips-study
//
//  Created by 解向前 on 2018/9/19.
//  Copyright © 2018年 com.test. All rights reserved.
//

//
// KVO 仅限NSObject子类, 还需标记为 dynamic 和 @objc
import UIKit

class KVOKeyPathController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    var date = Class()
    var another = AnotherClass()
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        date.myObject.date = Date()
        another.myObject.date = Date()
    }
    
    
    class MyClass: NSObject {
        @objc dynamic var date = Date()
    }
    
    class Class: NSObject {
        var myObject: MyClass!
        
        override init() {
            super.init()
            myObject = MyClass()
            print("初始化 MyClass, 当前日期: \(myObject.date)")
            myObject.addObserver(self, forKeyPath: "date", options: .new, context: &myContext)
            
        }
        
        override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
            if let change = change,
                context == &myContext,
                let newDate = change[.newKey] as? Date {
                print("my Class 日期发生变化 \(newDate)")
            }
        }
    }
    
    // 新的 KVO
    class AnotherClass: NSObject {
        var myObject: MyClass!
        var observation: NSKeyValueObservation?
        override init() {
            super.init()
            myObject = MyClass()
            print("初始化 AnotherClass, 当前日期: \(myObject.date)")
            
            observation = myObject.observe(\MyClass.date, options: [.new], changeHandler: { (_, change) in
                if let newDate = change.newValue {
                    print("anotherClass date changed \(newDate)")
                }
            })
        }
    }
    // 好处: 观察和处理代码 放在一起
    //      得到类型安全的结果
    //      不需要使用context区别那个观察量变化
    //      observation, 可随AnotherClass释放结束
    
    // 缺点
    // dynamic 和 @objc 标注
    // Swift类没法用
}
private var myContext = 0
