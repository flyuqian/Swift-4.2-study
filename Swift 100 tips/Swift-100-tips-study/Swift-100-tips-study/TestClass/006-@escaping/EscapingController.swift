//
//  EscapingController.swift
//  Swift-100-tips-study
//
//  Created by 解向前 on 2018/9/13.
//  Copyright © 2018年 com.test. All rights reserved.
//

import UIKit

class EscapingController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        forTest()
    }
    

}


extension EscapingController {
    func forTest() {
        doWork {
            print("work")
        }
        S().method1()
        S().method2()
        S().method3()
    }
}

fileprivate func doWork(block: () -> ()) {
    block()
}

// 上面的案例, 隐藏了一段假设: 参数中block的内容,会在dowork返回前就完成, 对于block的调用是同步行为
// 如果我们将block 通过Dispatch,使他在dowork返回之后调用, 这时我们需要在block前加上@escaping, 表明闭包会逃逸出方法
fileprivate func doWorkAsync(block: @escaping() -> ()) {
    DispatchQueue.main.async {
        block()
    }
}
// 使用闭包调用这两个方法时, 会有一些行为不同
// 闭包可以截获其中的变量
// dowork参数里没有逃逸的闭包, 因为闭包作用域不会超过函数本身, 所以不需要担心比包内持有 self 等
// 接受了 @escaping 的 doWorkAsync 不同, 由于需要保持闭包内的成员有效, 如果闭包中引用了self, Swift 强制我们明确写出 self


fileprivate class S {
    var foo = "foo"
    
    func method1() {
        doWork {
            print(foo)
        }
        foo = "bar"
    }
    func method2()  {
        doWorkAsync {
            print(self.foo)
        }
        foo = "bar"
    }
    // method2 中的闭包持有了self
    // 如果需要 闭包不持有self 可以使用 [weak self]
    func method3() {
        doWorkAsync {
            [weak self] in
            print(self?.foo ?? "nil")
        }
        foo = "bar"
    }
}

// 如果你在协议或者父类中定义了 @escaping 方法, 子类实现该方法, 需要添加@escaping, 如果不加, 则被认为是不同的函数签名
fileprivate protocol P {
    func work(b: @escaping () -> ())
}
fileprivate class C: P {
    func work(b: @escaping () -> ()) {
        DispatchQueue.main.async {
            print("in C")
            b()
        }
    }
}
// fileprivate class C1: P {   func work(b: () -> ()) {}  }
// 无法编译
