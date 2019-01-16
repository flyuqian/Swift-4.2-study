//
//  TFIteratorController.swift
//  TF01
//
//  Created by IOS3 on 2018/12/20.
//  Copyright © 2018 IOS3. All rights reserved.
//

import UIKit

class TFIteratorController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "迭代器"
        view.backgroundColor = .white
        
        // test1()
        // test2()
        // test3()
        test4()
        
    }
    
    
    
   

}


// 从概念上讲, 任何类型只要遵守  IteratorProtocol 协议, 那么它就是一个迭代器
struct ReverseIndexIterator: IteratorProtocol {
    var index: Int
    
    init<T>(array: [T]) {
        index = array.endIndex - 1
    }
    
    mutating func next() -> Int? {
        guard index >= 0 else { return nil }
        defer { index -= 1 }
        return index
    }
}


// 我们定义一个迭代器, 用来生成 无数个 二的幂值, 知道溢出
struct PowerItreator: IteratorProtocol {
    var power: NSDecimalNumber = 1
    
    mutating func next() -> NSDecimalNumber? {
        power = power.multiplying(by: 2)
        return power
    }
}
extension PowerItreator {
    mutating func find(where predicate: (NSDecimalNumber) -> Bool) -> NSDecimalNumber? {
        while let x = next() {
            if predicate(x) {
                return x
            }
        }
        return nil
    }
}



// 生成字符串的迭代器
struct FileLinesIterator: IteratorProtocol {
    let lines: [String]
    var currentLine: Int = 0
    
    init(filename: String) throws {
        let contents: String = try String(contentsOfFile: filename)
        lines = contents.components(separatedBy: .newlines)
    }
    
    mutating func next() -> String? {
        guard currentLine < lines.endIndex else { return nil }
        defer { currentLine += 1 }
        return lines[currentLine]
    }
}


fileprivate extension IteratorProtocol {
    mutating func find(predicate: (Element) -> Bool) -> Element? {
        while let x = next() {
            if predicate(x) {
                return x
            }
        }
        return nil
    }
}

// 构建一个迭代器转换器, 用参数中limit值来限制参数迭代器所生成的结果个数
struct LimitIterator<I: IteratorProtocol>: IteratorProtocol {
    var limit = 0
    var iterator: I
    
    init(limit: Int, iterator: I) {
        self.limit = limit
        self.iterator = iterator
    }
    
    mutating func next() -> I.Element? {
        guard limit > 0 else { return nil }
        limit -= 1
        return iterator.next()
    }
}


// 使用 AnyIterator 我们可以更简短的定义迭代器
extension Int {
    func countDown() -> AnyIterator<Int> {
        var i = self - 1
        return AnyIterator {
            guard i >= 0 else { return nil }
            defer { i -= 1 }
            return i
        }
    }
}

//MARK: - 序列
// 每一个序列都有一个关联的迭代器类型, 和 一个创建迭代器的方法

// 我们定义一个序列, 用于生成某个数组的一系列倒序序列的值
struct ReverseArrayIndices<T>: Sequence {
    let array: [T]
    init(array: [T]) {
        self.array = array
    }
    func makeIterator() -> ReverseIndexIterator {
        return ReverseIndexIterator(array: array)
    }
}
// test4


// 序列也具有 标准的 map 和 filter 方法
// 这些 map 和 filter 方法不会返回新的序列 , 而是遍历序列来说生成一个数组


//MARK: 延迟序列化

















extension TFIteratorController {
    
    func test4() {
        var array = ["one", "two", "three"]
        let revers = ReverseArrayIndices(array: array)
        var it = revers.makeIterator()
        
        while let i = it.next() {
            print("index: \(i) is \(array[i])")
        }
        
        for i in ReverseArrayIndices(array: array) {
            print("index: \(i) is \(array[i])")
        }
    }
    
    
    func test3() {
        
        let path = "/Users/ios3/Desktop/干了什么.md"
        do {
            var it = try FileLinesIterator(filename: path)
            while let str = it.next() {
                print(str)
            }
        } catch {
            print(error)
        }

    }
    
    
    func test2() -> Void {
        var powerIterator = PowerItreator()
        let rst = powerIterator.find { $0.intValue > 1000 }
        print(rst)
        
    }
    
    func test1() {
        let letters = ["A", "B", "C"]
        var iterator = ReverseIndexIterator(array: letters)
        while let i = iterator.next() {
            print("Element \(i) of the array is \(letters[i])")
        }
    }
}
