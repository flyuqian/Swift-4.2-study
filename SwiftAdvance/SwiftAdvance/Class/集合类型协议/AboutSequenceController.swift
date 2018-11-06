//
//  AboutSequenceController.swift
//  SwiftAdvance
//
//  Created by IOS3 on 2018/11/5.
//  Copyright © 2018 com.test. All rights reserved.
//

import UIKit

class AboutSequenceController: NormalBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        test01()
//        test02()
//        test03()
        test04()
        
    }
    

    
    
    
    /// 序列
    // Sequence 协议是集合类型结构找那个的基础, 一个序列代表的是一系列具有相同类型的值
    // 可以对这些值进行迭代, 遍历一个序列最简单的方式是 for 循环
    // 满足x该协议的类型都可以直接使用这些功能
    // 满足Sequence协议, 需要提供一个 返回 Iterator 的 makeIterator()方法
    //
    /// 迭代器
    // 序列通过创建g一个迭代器来提佛那个对元素的额访问. 迭代器每次产生一个序列的值, 并且当遍历序列时对遍历状态进行管理
    // IteratorProtocol 协议中唯一的一个方法是 next() , 当序列耗尽时, next()返回nil
    // 一般来说, 你只有在想要实现一个自定义序列类型的时候, 才需要关心迭代器
    // 迭代器是单向结构, 它只能按照增加的方向前进, 而不能倒退或重置
    // 几乎所有有意义的迭代器都要求可变状态, 这样他们才能够管理在序列中的当前位置
    //
    // 斐波那契序列案例 (可发生内存溢出)
    fileprivate struct FibsIterator: IteratorProtocol {
        var state = (0, 1)
        mutating func next() -> Int? {
            let upcomingNumber = state.0
            state = (state.1, state.0 + state.1)
            return upcomingNumber
        }
    }
    fileprivate func test01() {
        
        var fibs = FibsIterator(state: (0, 1))
        for _ in 0...10 {
            if let rs = fibs.next() {
                print(rs)
            }
        }
    }
    
    /// 遵守序列协议
    // PrefixGenerator 案例
    fileprivate struct PrefixIterator: IteratorProtocol {
        let string: String
        var offset: String.Index
        
        init(string: String) {
            self.string = string
            offset = string.startIndex
        }
        mutating func next() -> Substring? {
            guard offset < string.endIndex else { return nil }
            offset = string.index(after: offset)
            return string[..<offset]
        }
    }
    fileprivate struct PrefixSequence: Sequence {
        let string: String
        func makeIterator() -> PrefixIterator {
            return PrefixIterator(string: string)
        }
    }
    fileprivate func test02() {
        let str = "fgyhuoipoknsajghpa[ouhuibnjmkap"
        var ps = PrefixIterator(string: str)
        while ps.next() != nil {
            if let s = ps.next() {
                print(s)
            }
        }
        for prefix in PrefixSequence(string: "aijhlbh anij higaadsga") {
            print(prefix)
        }
    }
    
    //
    /// 迭代器和值语义
    // 以上迭代器都具有值语义, 标准库中的大部分迭代器也具有值语义
    // 如果复制一份具有值语义的迭代器, 迭代器的状态也会被复制
    // StrideToIterator例子
    // AnyIterator 是一个将迭代器进行封装的迭代器, 是引用类型
    fileprivate func test03() {
        let seq = stride(from: 0, to: 10, by: 1)
        var i1 = seq.makeIterator()
        
        let r2 = i1.next()
        let r3 = i1.next()
        
        var i2 = i1
        let r4 = i1.next()
        let r5 = i1.next()
        let r6 = i2.next()
        let r7 = i2.next()
        print(r2)
        print(r3)
        print(r4)
        print(r5)
        print(r6)
        print(r7)
        
        var i3 = AnyIterator(i1)
        var i4 = i3
        let r8 = i3.next()
        let r9 = i4.next()
        let r10 = i3.next()
        let r11 = i4.next()
        print(r8)
        print(r9)
        print(r10)
        print(r11)
    }
    
    //
    /// 基于函数的迭代器和序列
    // AnyIterator 还有另一个初始化方法, 直接接受一个 next函数作为参数, 与对应的AnySequence类型结合起来使用, 我们可以做到不定义任何新的类型, 就能创建迭代器
    fileprivate func test04() {
        func fibsIterator() -> AnyIterator<Int> {
            var state = (0, 1)
            return AnyIterator {
                let upcomingNumber = state.0
                state = (state.1, state.0 + state.1)
                return upcomingNumber
            }
        }
        let fibs = fibsIterator()
        for _ in 0...12 {
            if let a = fibs.next() {
                print(a)
            }
        }
        let fibsSequence = AnySequence(fibs)
        let arr = Array(fibsSequence.prefix(10))
        print(arr)
    }
    
}
