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
//        test04()
        test05()
        
        
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
    
    //
    /// 无序列
    // 像我们至今为止看到的迭代器一样, sequence 对于next闭包的调用时被延迟的
    // 序列的下一个值不会被计算, 他在调用者需要的时候生成: fibsSequence2.prefix(10), 便只会生成10个元素, 然后停止, 因为c序列如果是主动计算的, 则会因为序列是无线电额, 而造成内存溢出
    // 集合和序列的区别就是序列可以是无限的
    
    
    //
    /// 不稳定序列
    // 网络流/IO流/事件流, 都可以使用序列进行建模, 这些序列都m无法做到多次遍历
    // Sequencex文档, 明确序列不保证可以多次遍历
    // 一个非集合的序列可能会在第二次遍历是产生随机的序列元素
    
    
    //
    /// 序列和迭代器之间的关系
    // 对于像斐波那契数列这样的稳定序列来说, 它的内部状态不随for 循环而改变, 他们需要独立的遍历状态, 该状态由迭代器提供
    // 因为语言原因, IteratorProtocol不能继承自Sequence, 但是标准库中大部分的额迭代器都满足了Sequence 协议
    
    
    
    //
    /// 子序列
    // SubSequence Sequence的关联类型
    // 用于返回原序列的切片操作
    // prefix suffix
    // prefix(whild:)
    // dropFirst dropLast
    // drop(while:)
    // split
    //
    // 如果没有明确指定SubSequence 的类型, 编译器会将其推断为AnySequence<Iterator.Element>类型, 这是因为Sequence以这个z类型作为返回值, 为上述方法提供了默认实现, 如果想要使用自己的子序列类型, 我们必须为这些方法提供自定义实现
    
    
    
    
    //
    /// 链表
    // 实现单项链表
    fileprivate func test05() -> Void {
        
        // 链表在文件下部实现, 方便写 extension
        
        
        let emptyList = List<Int>.end
        let oneElementList = List.node(1, next: emptyList)
        let list = List<Int>.end.cons(1).cons(2).cons(3)
        let list2: List = [3, 2, 1]
        // 该链表有一个特性, 它是持久的, 节点不可变, 一旦被创建, 就b无法进行更改
        // 将一个元素添加到链表中并不会复制该链表, 只会给你一个连接在既存链表的前端节点
        // 也就是说两个链表可以共享链表尾
        
        var stack: List<Int> = [3, 2, 1]
        var a = stack
        var b = stack
        print(a.pop())
        print(b.pop())
        print(a.pop())
        print(b.pop())
        
        stack.push(4)
        print(a.pop())
        print(b.pop())
        print(stack.pop())
        print(stack.pop())
        /*
         Optional(3)
         Optional(3)
         Optional(2)
         Optional(2)
         Optional(1)
         Optional(1)
         Optional(4)
         Optional(3)
         - 链表的节点是值, 他们不会发生改变, 一个存储了3并指向确定的下一个节点的节点永远不会变成其他的值
         - 具有值类型的特性
         */
    }
    
}
fileprivate enum List<Element> {
    case end
    indirect case node(Element, next: List<Element>)
    // indirect 关键字, 告诉编译器枚举值node 应当被看做引用
    func cons(_ x: Element) -> List {
        return .node(x, next: self)
    }
}
// 添加 ExpressibleByArrayLiteral 支持
extension List: ExpressibleByArrayLiteral {
    init(arrayLiteral elements: Element...) {
        self = elements.reversed().reduce(.end) { partialList, element in
            partialList.cons(element)
        }
    }
}
// 定义 pop和push
extension List {
    mutating func push(_ x: Element) {
        self = self.cons(x)
    }
    mutating func pop() -> Element? {
        switch self {
        case .end: return nil
        case let .node(x, next: tail):
            self = tail
            return x;
        }
    }
}
// 遵守 Sequence
extension List: IteratorProtocol, Sequence {
    mutating func next() -> Element? {
        return pop()
    }
}
