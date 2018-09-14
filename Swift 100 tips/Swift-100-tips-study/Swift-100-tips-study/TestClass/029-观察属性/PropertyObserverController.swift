//
//  PropertyObserverController.swift
//  Swift-100-tips-study
//
//  Created by 解向前 on 2018/9/14.
//  Copyright © 2018年 com.test. All rights reserved.
//

//
// willSet / didSet
// 初始化方法 不触发属性观察
// 在willSet和didSet中对属性的再次设定, 不会触发观察属性的再次调用
// 计算属性和观察属性不能同时存在, 即 同一个属性中不能同时出现 set 和 willSet/didSet
// 子类可以给父类中的任意属性添加观察属性

import UIKit

class PropertyObserverController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let a = MyClass()
        a.date = NSDate(timeIntervalSinceNow: 100)

        let b = A.B()
        let _ = b.number
        b.number = 3
    }

    
    class MyClass {
        let onYearInSecond: TimeInterval = 365 * 24 * 60 * 60
        var date: NSDate {
            willSet {
                let d = date
                print("即将将日期从\(d)设定至\(newValue)")
            }
            didSet {
                if date.timeIntervalSinceNow > onYearInSecond {
                    print("设定的时间太晚了")
                    date = NSDate().addingTimeInterval(onYearInSecond)
                }
                print("已经将日期从\(oldValue)设定至\(date)")
            }
        }
        init() {
            date = NSDate()
        }
    }
    
    class A {
        var number: Int {
            get {
                print("get")
                return 1
            }
            set { print("Set") }
        }
        class B: A {
            override var number: Int {
                willSet{ print("willSet") }
                didSet{ print("didSet") }
            }
        }
    }
    // get 首先被调用了一次
    // 因为我们实现了 didSet, didSet 中, 会用到 oldValue, 而这个值需要在整个set动作之前获取并存储待用
}
