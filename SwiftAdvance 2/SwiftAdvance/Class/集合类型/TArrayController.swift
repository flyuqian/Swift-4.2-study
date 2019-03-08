//
//  TArrayController.swift
//  SwiftAdvance
//
//  Created by IOS3 on 2019/2/25.
//  Copyright © 2019 com.test. All rights reserved.
//

import UIKit

class TArrayController: NormalBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

     
//        test01()
//        test02()
        test05()
    }
    
    func test06() {
        // forEach 适合数组中的元素都调用一个函数
        // forEach 中不能会直接加入 where, 并且forEach 的return不能返回到函数的作用域之外
    }
    
    
    func test05() {
        print("对 flatMap的的使用")
        let suits = ["♠︎", "♥︎", "♣︎", "♦︎"]
        let ranks = ["J","Q","K","A"]
        
        let result = suits.flatMap{ suit in
            ranks.map { rank in
                (suit, rank)
            }
        }
        print(result)
        
        
        let result2 = suits.map{ suit in
            ranks.map{ rank in
                (suit, rank)
            }
        }
        print("使用 map")
        print(result2)
    
    }
    
    func test04() {
        print("可变和带有状态的闭包")
        
    }
    
   
    
    func test03() {
        print("数组变形")
        let fibs = [0, 1, 1, 2, 3, 5]
        var squared: [Int] = []
//        for fib in fibs {
//            squared.append(fib * fib)
//        }
        squared = fibs.map{ $0 * $0 }
        print("squared: \(squared)")
        
        /*
        ***** 标准库中的一些接受函数的作为参数的函数
         
         map 和 flatMap — 如何对元素进行变换
         
         filter — 元素是否应该被包含在结果中
         
         reduce — 如何将元素合并到一个总和的值中
         
         sequence — 序列中下一个元素应该是什么？
         
         forEach — 对于一个元素，应该执行怎样的操作
         
         sort，lexicographicCompare 和 partition — 两个元素应该以怎样的顺序进行排列
         
         index，first 和 contains — 元素是否符合某个条件
         
         min 和 max — 两个元素中的最小/最大值是哪个
         
         elementsEqual 和 starts — 两个元素是否相等
         
         split — 这个元素是否是一个分割符
         
         prefix - 当判断为真的时候，将元素滤出到结果中。一旦不为真，就将剩余的抛弃。和 filter 类似，但是会提前退出。这个函数在处理无限序列或者是延迟计算 (lazily-computed[…]”
         
         */
    }
    

    func test02() {
        print("数组与可选值")
        
        /*
         想要迭代数组？ for x in array
         
         想要迭代除了第一个元素以外的数组其余部分？ for x in array.dropFirst()
         
         想要迭代除了最后 5 个元素以外的数组？ for x in array.dropLast(5)
         
         想要列举数组中的元素和对应的下标？ for (num, element) in collection.enumerated()
         
         想要寻找一个指定元素的位置？ if let idx = array.index { someMatchingLogic($0) }
         
         想要对数组中的所有元素进行变形？ array.map { someTransformation($0) }
         
         想要筛选出符合某个标准的元素？ array.filter { someCriteria($0) > }
         
         */
    }
    
    func test01() {
        
        let fibs = [0, 1, 1, 2, 3, 5]
        // fibs 不变
        var mFibs = [0, 1, 1, 2, 3, 5]
        mFibs.append(8)
        mFibs.append(contentsOf: [13, 21])
        print(mFibs)
        
        // 数组是值类型
        var x = [1, 2, 3]
        var y = x
        y.append(4)
        print("x: \(x)")
        print("y: \(y)")
        // 以上 x,y 的赋值, 同样适用于函数, 一个数组作为参数传递给一个函数, 函数使用的是这个数组的副本
        
    }

}
