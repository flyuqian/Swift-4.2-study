//
//  ShowArrayController.swift
//  SwiftAdvance
//
//  Created by 解向前 on 2018/9/26.
//  Copyright © 2018 com.test. All rights reserved.
//

//

import UIKit

class ShowArrayController: NormalBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//         test()
        // test2()
//        test3()
//        test4()
//        test5()
//        test6()
        test7()
        
    }
    
    
    
    
    // forEach
    func test7() {
        // 如果想要对集合中的每个元素都调用一个函数的话, 使用ForEach比较合适
        // 如: views.forEach(view.addSubview), 就可以完成需求
        
        // 我们不能将where语句加入到forEach中
        // 在forEach中的return并不能返回到外部函数的作用域之外, 它仅仅是返回到闭包本身之外
    }
    
    
    
    
    // flatMap
    func test6() {
        let array1 = ["1", "2", "3", "4"]
        let array2 = ["A", "B", "C", "D"]
        
        let result = array1.flatMapp { suit in
            array2.map { rank in
                (suit, rank)
            }
        }
        print(result)
    }
    
    

    
    // reduce
    func test5() {
        
        // reduce 基本使用
        let fibs = [0, 1, 1, 2, 3, 5]
//        var total = 0
//        for num in fibs {
//            total = total + num
//        }
//        print(total)
//        let sum = fibs.reduce(0){ total, num in total + num }
//        print(sum)
        
        // 运算符也是函数, 因此可以简写如下
        let sum = fibs.reduce(0, +)
        print(sum)
        
        // 我们也可以使用reduce 拼接字符串
        let str = fibs.reduce(""){ str, num in str + "\(num), " }
        print(str)
    }
    
    
    
    
    // Filter
    func test4() {
        
        // 筛选出满足要求的元素
        // [2, 4, 6, 8, 10]
//        let nums = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
//        let newNums = nums.filter{ $0 % 2 == 0 }
//        print(newNums);
        
        // map 和 filter 结合, 找出100以内 是其他数平方的偶数
        // [4, 16, 36, 64]
//        let result = (1 ..< 10).map { $0 * $0 }.filter { $0 % 2 == 0 }
//        print(result)
        
        
        // bigArray.filter { someCondition }.count > 0
        // 以上s代码, 性能较差, 分析: 因为filter会创建一个全新的数组, 并对数组中的每个元素进行操作, 上面情景使用 contains(where:)更适合
//        let nums = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
//        func testCondition(_ input: Int) -> Bool {
//            if input > 5 {
//                return true;
//            }
//            return false;
//        }
//        let result = nums.contains(where: testCondition)
//        print(result)
    }
    
    
    // 数组变形
    func test3() {
        // 案例,
        let fibs = [0, 1, 1, 2, 3, 5]
        var squared = [Int]()
        for x in fibs {
            squared.append(x * x)
        }
        // 使用 map 函数
        squared = fibs.map { fib in fib * fib }
        //
        // 其他变形函数
        // 如何对元素进行交换, map, filterMap
        // 元素是否应该被包含在结果中 filter
        // 将元素合并到一个总的和中 reduce
        // 序列中下一个元素应该是什么 sequence
        // 对每一个元素都应该进行怎样的操作 for-eatch
        // 两个元素之间应该进行怎样的排序 sort, lexicographicCompare 和 partition
        // 元素是否符合某个条件 index, first, contains
        // 两个元素中最小,最大的是哪个 mini, max
        // 另个元素是否相等 elementsEqual  和 start
        // 这个元素是否是一个分隔符 split
        // 当判断元素为真的时候, 将元素虑出到结果中, 一旦元素不威震, 就将剩余的抛弃 prefix, 这个函数在处理无限序列和延迟计算时非常有用
        // 当元素为真的时候, 丢弃元素, 一但元素不为真, 返回剩余元素 drop
        
        //
        // 不在标准库中的函数, 但是作者说非常值得尝试
        // accumulate 累加, 保留合并时每一步的值, 并保存到数组中
        // all(matching:) none(matching:) 测试序列中的所有元素是不是满足某一个标准
        // count(where: ) 计算满足条件元素的个数
        // indices(where:) 返回一个包含满足某个标准的所有元素的索引的列表
        let _ = 1.0 + 1.0
    }
    
    
    
    
    // 数组与可选值
    func test2() {
        // 使用索引操作数组, 我们必须确定索引没有越界
        // 我们应当, 尽量避免直接使用索引
            // 迭代 使用 for x in array
            // 迭代除了第一个元素以外的数组, for x in array.dropFirst()
            // 迭代除了最后5个元素 for x in array.dropLast(5)
            // 列举元素和下标 for (num, element) in collection.enumerated()
            // 想要寻找一个指定元素的位置 if let idx = array.index { someMatchingLogic($0) }
            // 想要对数组中的所有元素进行变形 array.map{
            // 想要筛选出符合标准的元素 array.filter {
        // 索引错误 为程序员错误😂
        //
        // 😂为了 怕你吧习惯性强制解包, Swift的数组, 设计为索引取值为确定非可选值, 索引出错时崩溃
        // first last 返回可选值, 可以作用于空数组, 并返回nil
        // 像 removeLast, popLast 的不同, 需要自行选择
    }
    
    
    //
    func test() {
        // 数组 是一个以有序方式存储一系列相同元素的集合
        let fibs = [0, 1, 1, 2, 3, 5]
        // fibs.append(8)
        // let 声明的数组为不可变类型
        // 需要调用 append 等, 需要 声明为 var
        // 数组和标准库中的其他类型一样, 具有值语意
        let x = [1, 2, 3]
        var y = x
        y.append(4)
        print("x: \(x), y: \(y)")
        
        let a = NSMutableArray(array: [1, 2, 3])
        let b: NSArray = a
        a.insert(4, at: 3)
        print("b:\(b)")
        // b 将打印 1234, 因为只能保证引用不变
        // 若想要b不变, 需要在赋值的时候, 使用a的拷贝
        let c: NSArray = a.copy() as! NSArray
        a.insert(5, at: 4)
        print("c: \(c)")
    }
}

// map 的实现
fileprivate extension Array {
    func map<T>(_ transform: (Element) -> T) -> [T] {
        var result: [T] = []
        result.reserveCapacity(count)
        for x in self {
            result.append(transform(x))
        }
        return result
    }
    // 实际的签名是
    // func map<T>(_transform: (Element)throws ->T) rethows -> [ T]
    // 对于可以抛错的变形函数, map会将抛错传递给调用者
    // map 为什么这么通用, 因为他将模板代码分离出来, 而这些模板不会随每次调用而发生变化
    
    
    // 不在标准库中的函数, 但是作者说非常值得尝试
    // accumulate 累加, 保留合并时每一步的值, 并保存到数组中
    // all(matching:) none(matching:) 测试序列中的所有元素是不是满足某一个标准
    // count(where: ) 计算满足条件元素的个数
    // indices(where:) 返回一个包含满足某个标准的所有元素的索引的列表
//    func accumulate<T>(adder: T, transform: (Element) -> T) -> [T] {
//        var result = [T]()
//        for x in self {
//            // result.append(adder + transform(x))
//        }
//    }
}

// Filter
private extension Array {
    // filter 实现
    func filterr(_ isIncluded: (Element) -> Bool) -> [Element] {
        var result: [Element] = []
        for x in self where isIncluded(x) {
            result.append(x)
        }
        return result
    }
}


// reduce
private extension Array {
    // reduce 实现
    func reduceee<Result>(_ initialResult: Result, _ nextPartialResult: (Result, Element) -> Result) -> Result {
        var result = initialResult
        for x in self {
            result = nextPartialResult(result, x)
        }
        return result
    }
    
    // 使用reduce 实现 map 和 filter
    func mapp2<T>(_ transform: (Element) -> T) -> [T] {
        return reduce([]) {
            $0 + [transform($1)]
        }
    }
    func filter2(_ isIncluded: (Element) -> Bool) -> [Element] {
        return reduce([]) {
            isIncluded($1) ? $0 + [$1] : $0
        }
    }
    // 上面实现符合美学, 但是swift的数组不是列表(list), 每次组合, 函数都会通过在前面的元素之后附加一个元素或者是已包含的元素, 并创建一个新手数组, 所以上面的实现复杂度是O(n*n), 而不是O(n)
    
    // reduce 还有另一个版本
    // 其负责将中间结果和某个元素合并的函数, 现在接受一个inout的Result作为参数
    // 使用 inout result 的版本, 因为不需要创建数组, 会将复杂度,降回到 O(n)
//    func reduceee2<Result>(inout initialResult: Result, _ updateAccoumulatingResult: (_ partialResult: inout Result, Element) throws -> ()) rethrows -> Result
    
    
    
    // flatMap
    func flatMapp<T>(_ transform: (Element) -> [T]) -> [T] {
        var result: [T] = []
        for x in self {
            result.append(contentsOf: transform(x))
        }
        return result
    }
}
