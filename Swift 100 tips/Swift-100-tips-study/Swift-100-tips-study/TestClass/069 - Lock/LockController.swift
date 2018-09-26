//
//  LockController.swift
//  Swift-100-tips-study
//
//  Created by 解向前 on 2018/9/25.
//  Copyright © 2018年 com.test. All rights reserved.
//

//
// 锁, 为了在不同线程中安全访问同一个资源
// cocoa 中最长用的是 @synchronized , 用于修饰一个变量, 为其加上或者解除一个互斥锁
// 枷锁 会消耗性能, 并可能造成死锁. 所以我们要尽量追求简单
// Swift中不存在, @synchronied
//
// 自己封装使用
func synchronized(_ lock: AnyObject, closure: () -> ()) {
    objc_sync_enter(lock)
    closure()
    objc_sync_exit(lock)
}

fileprivate class Obj {
    var _str = "123"
    var str: String {
        get {
            return _str
        }
        set {
            synchronized(self, closure: {
                _str = newValue
            })
        }
    }
}
import UIKit

class LockController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
