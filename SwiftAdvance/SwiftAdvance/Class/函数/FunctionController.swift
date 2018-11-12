//
//  FunctionController.swift
//  SwiftAdvance
//
//  Created by IOS3 on 2018/11/12.
//  Copyright © 2018 com.test. All rights reserved.
//

import UIKit

class FunctionController: NormalBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
//        test1()
        test2()
        
    }
}


//
// Swift 的函数我们需要知道下面
// 0 函数可以像Int String那样被赋值变量, 也可以作为另一个函数的输入参数或者返回值
// 1 函数可以捕获其局部作用域之外的变量
// 2 两种方式创建函数, 一种是func, 另一种是 {}. Swift中另一种被称为闭包表达式
// 一个函数和它捕获的变量环境组合起来被称为闭包
//
// 闭包表达式的特性
/*
 - 如果你将闭包作为参数传递，并且你不再用这个闭包做其他事情的话，就没有必要现将它存储到一个局部变量中。可以想象一下比如 5*i 这样的数值表达式，你可以把它直接传递给一个接受 Int 的函数，而不必先将它计算并存储到变量里。
 - 如果编译器可以从上下文中推断出类型的话，你就不需要指明它了。在我们的例子中，从数组元素的类型可以推断出传递给 map 的函数接受 Int 作为参数，从闭包的乘法结果的类型可以推断出闭包返回的也是 Int。
 - 如果闭包表达式的主体部分只包括一个单一的表达式的话，它将自动返回这个表达式的结果，你可以不写 return。
 - Swift 会自动为函数的参数提供简写形式，$0 代表第一个参数，$1 代表第二个参数，以此类推。
 - 如果函数的最后一个参数是闭包表达式的话，你可以将这个闭包表达式移到函数调用的圆括号的外部。这样的尾随闭包语法在多行的闭包表达式中表现非常好，因为它看起来更接近于装配了一个普通的函数定义，或者是像 if (expr) { } 这样的执行块的表达[…]
  */
extension FunctionController {
    fileprivate func test1() {
        
        // 捕获变量
        func counterFunc() -> (Int) -> String {
            var counter = 0
            func innerFunc(i: Int) -> String {
                counter += i
                return "running total: \(counter)"
            }
            return innerFunc
        }
        
        let f = counterFunc()
        print(f(3))
        print(f(4))
        
        
        // 函数可以用 {} 声明闭包表达式
        func doubler(i: Int) -> Int {
            return i * 2
        }
        let doublerAlt = {(i: Int) -> Int in return i * 2}
        [1, 2, 3, 4].map(doubler).map{ print($0) }
        [1, 2, 3, 5].map(doublerAlt).map{ print($0) }
    }
}


// 排序
extension FunctionController {
    
    @objcMembers
    final class Person: NSObject {
        let first: String
        let last: String
        let yearOfBirth: Int
        init(first: String, last: String, yearOfBirth: Int) {
            self.first = first
            self.last = last
            self.yearOfBirth = yearOfBirth
        }
    }
    
    
    // public func sorted(by areInIncreasingOrder: (Element, Element) throws -> Bool) rethrows -> [Element]
    typealias SortDescriptor<Value> = (Value, Value) -> Bool
    
    
    func sortDescriptor<Value, Key>(
        key: @escaping (Value) -> Key,
        by areInIncreasingOrder: @escaping (Key, Key) -> Bool
        ) -> SortDescriptor<Value> {
        
        return { areInIncreasingOrder(key($0), key($1)) }
    }
    
    func sortDescriptor<Value, Key>(key: @escaping(Value) -> Key)
        -> SortDescriptor<Value> where Key: Comparable {
            return { key($0) < key($1) }
    }
    
    func sortDescriptor<Value, Key>(
        key: @escaping(Value) -> Key,
        ascending: Bool = true,
        by comparator: @escaping(Key) -> (Key) -> ComparisonResult
        ) -> SortDescriptor<Value> {
        
        return { lhs, rhs in
            let order: ComparisonResult = ascending ? .orderedAscending : .orderedDescending
            return comparator(key(lhs))(key(rhs)) == order
        }
    }
    
    func combine<Value> (sortDescriptors: [SortDescriptor<Value>])
        -> SortDescriptor<Value> {
            return { lhs, rhs in
                for areInIncreasingOrder in sortDescriptors {
                    if areInIncreasingOrder(lhs, rhs) { return true }
                    if areInIncreasingOrder(rhs, lhs) { return false }
                }
                return false
            }
    }
    
    func test2() {
        let people = [
            Person(first: "Emily", last: "Young", yearOfBirth: 2002),
            Person(first: "David", last: "Gray", yearOfBirth: 1991),
            Person(first: "Robert", last: "Barnes", yearOfBirth: 1985),
            Person(first: "Ava", last: "Barnes", yearOfBirth: 2000),
            Person(first: "Joanne", last: "Miller", yearOfBirth: 1994),
            Person(first: "Ava", last: "Barnes", yearOfBirth: 1998),
            ]
        let sortByYearAlt: SortDescriptor<Person> = sortDescriptor(key: { $0.yearOfBirth }, by: <)
        let sortByYearAlt2: SortDescriptor<Person> = sortDescriptor(key: { $0.yearOfBirth })
        let sortByFirstName: SortDescriptor<Person> = sortDescriptor(key: { $0.first }, by: String.localizedStandardCompare)
        
        let combined: SortDescriptor<Person> = combine(sortDescriptors: [sortByFirstName, sortByYearAlt2])
        
        let rs = people.sorted(by: sortByYearAlt)
        let rs3 = people.sorted(by: sortByFirstName)
        for p in rs {
            print(p.yearOfBirth)
        }
        
        let rs4 = people.sorted(by: combined)
        for p in rs4 {
            print("\(p.first) - \(p.yearOfBirth)")
        }
    }
}



// MARK: 局部函数和变量捕获
// 并归排序
extension Array where Element: Comparable {
    private mutating func merge(lo: Int, mi: Int, hi: Int) {
        var temp: [Element] = []
        var i = lo, j = mi
        while i != mi && j != hi {
            if self[j] < self[i] {
                temp.append(self[j])
                j += 1
            }
            else {
                i += 1
            }
        }
        temp.append(contentsOf: self[i..<mi])
        temp.append(contentsOf: self[j..<hi])
        replaceSubrange(lo..<hi, with: temp)
    }
    mutating func mergeSortInPlaceInefficient() {
        let n = count
        var size = 1
        while size < n {
            for lo in stride(from: 0, to: n - size, by: size * 2) {
                merge(lo: lo, mi: (lo + size), hi: Swift.min(lo + size * 2, n))
            }
            size *= 2
        }
    }
}
extension FunctionController {
    
}
