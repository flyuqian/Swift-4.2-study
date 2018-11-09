//
//  CloureAndMemryController.swift
//  SwiftAdvance
//
//  Created by IOS3 on 2018/11/9.
//  Copyright © 2018 com.test. All rights reserved.
//

import UIKit

class CloureAndMemryController: NormalBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        test1()
        
    }
    


}


extension CloureAndMemryController {
    
    // MARK: 闭包和可变性
    // 如, 一个函数, 每次调用时生成一个唯一整数, 直到Int.max. 当将状态移动到函数外部实现, 就是函数对变量进行了吧闭合
    func test1() -> Void {
        var i = 0
        func uniqueInterger() -> Int {
            i += 1
            return i
        }
        print(uniqueInterger())
        print(uniqueInterger())
        let otherfunc: () -> Int = uniqueInterger
        print(otherfunc())
        print(otherfunc())
        // 1 2 3 4
        
        
        func uniqueIntergerProvider() -> () -> Int {
            var i = 0
            return {
                i += 1
                return i
            }
        }
        let other: () -> Int = uniqueIntergerProvider()
        print(other())
        print(other())
        print(other())
        // 1, 2, 3
        print("###########")
        
        // 除了返回闭包, 我们还可封装成一个 AnyIterator
        func uniqueIntergerProvider2() -> AnyIterator<Int> {
            var i = 0
            return AnyIterator {
                i += 1
                return i
            }
        }
        // Swift 的结构体一般存储在栈上,
        // 对于可变结构体这是一种优化, 默认存储在堆上, 绝大多数优化生效, 将其存储到栈上,
        // 编译器这么优化, 是因为那些逃逸闭包补货的变量需要在栈帧之外依然存在, 当编译器检测到结构体变量被一个函数闭合的时候, 优化将不再生效
    }
    
    
    
    // MARK: 内存
    func test2() {
        // 值类型没有循环引用
        // weak
        // unownend
        //
        // 选择, 如果对象的生命周期相互不关联, 不确定哪一个对象的生命周期更长, 我们应该使用weak
        // 如果可以保证非强引用对象拥有强引用对象 或者 更长的生命周期的话, unowned会更方便, 此时我们不需要处理可选值, 并且unowned比weak少性能损耗
        // 但是你在生命周期问题上出错, 使用 unowend 将造成程序crash
        
    }
    
    
    
    // MARK: 闭包和内存
    // 闭包是引用类型
    
    
    
    // MARK: 循环引用
}
