//
//  StructAndClassController.swift
//  SwiftAdvance
//
//  Created by IOS3 on 2018/11/8.
//  Copyright © 2018 com.test. All rights reserved.
//

import UIKit

class StructAndClassController: NormalBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        test1()
//        test2()
//        test4()
        test5()
        
    }
    

}


// Swfit中, 存储结构化的数据,方式有: 结构体.枚举.类.闭包捕获变量
// Swfit 标准库中, 巨大部分公开类型是结构体
// 结构体: 值类型, 不能被继承

// MARK: 值类型 (复制类型)
// 一般我们将有生命周期的抽象声明为引用类型, 将通过值属性判断的类型声明为值类型

// MARK: 可变性
// Swift Array遍历时可以操作数组元素: 迭代器持有的数组是一个本地的独立复制
extension StructAndClassController {
    class BinaryScanner {
        var position: Int
        let data: Data
        init(data: Data) {
            self.position = 0
            self.data = data
        }
        
        func scanByte() -> UInt8? {
            guard position < data.endIndex else {
                return nil
            }
            position += 1
            return data[position - 1]
        }
    }
    fileprivate func scanRemainingBytes(scanner: BinaryScanner) {
        while let byte = scanner.scanByte() {
            print(byte)
        }
    }
    fileprivate func test1() {
        let scaner = BinaryScanner(data: Data("hello".utf8))
        scanRemainingBytes(scanner: scaner);
    }
    // 会崩
    fileprivate func test2() {
        for _ in 0..<Int.max {
            let scanner = BinaryScanner(data: Data("Hello".utf8))
            DispatchQueue.global().async {
                self.scanRemainingBytes(scanner: scanner)
            }
            scanRemainingBytes(scanner: scanner)
        }
    }
}



// MARK: 结构体
// 值类型, 意味着一个值变量被赋值给另一个变量时, 这个值本身也会被复制
// 对结构体进行改变, 在语义上来说, 与重新对它赋值是一样的, 也就是, 结构体的属性变了, 这将是一个新的结构体
// 数组是结构体, 所以适用以上规则, 如果数组中 值类型元素的属性发生了改变, 这将触发数组的 didSet 方法
// mutating 关键字, 声明我们在结构体内部可以对结构体各个部分进行改变
// mutating 关键字, 是将 self 隐式的标位 inout

// MARK: 自己实现一个 Data
// 这里 作者实现了写时复制
extension StructAndClassController {
    
    func test3() {
        struct MyData {
            var _data: NSMutableData
            init(_ data: NSData) {
                _data = data.mutableCopy() as! NSMutableData
            }
            
            func append(_ byte: UInt8) {
                var mutableByte = byte
                _data.append(&mutableByte, length: 1)
            }
        }
    }
    
    
    // 写时复制, 昂规方式
    func test4() {
        struct MyData {
            fileprivate var _data: NSMutableData
            fileprivate var _dataForWriting: NSMutableData {
                mutating get {
                    _data = _data.mutableCopy() as! NSMutableData
                    return _data
                }
            }
            
            init() {
                _data = NSMutableData()
            }
            init(_ data: NSData) {
                _data = data.mutableCopy() as! NSMutableData
            }
            
            mutating func append(_ byte: UInt8) {
                var mutableByte = byte
                _dataForWriting.append(&mutableByte, length: 1)
            }
        }
        
        if let data = "afsdgasdga".data(using: .utf8) {
            let nsmdata = NSMutableData()
            nsmdata.append(data)
            
            var x  = MyData(nsmdata)
            let y = x
            print(x._data === y._data)
            x.append(0x55)
            print(x._data === y._data)
        }
        
        var buffer = MyData(NSData())
        for byte in 0..<5 as CountableRange<UInt8> {
            buffer.append(byte)
        }
        // 每次调用 append 时, 底层的 _data 对象都要被复制一次, 因为buffer 没有和其他的 MyData 实例共享存储
    }
    

    
    // 高效方式 实现写时复制
    func test5() -> Void {
        
        // 一个可以将 OC 对象封装到Swift对象中的类
        final class Box<A> {
            var unbox: A
            init(_ value: A) {
                self.unbox = value
            }
        }
        
        struct MyData {
            private var _data: Box<NSMutableData>
            var _dataForWriting: NSMutableData {
                mutating get {
                    if !isKnownUniquelyReferenced(&_data) {
                        // _data 有多个引用
                        _data = Box(_data.unbox.mutableCopy() as! NSMutableData)
                        print("Making a copy")
                    }
                    return _data.unbox
                }
            }
            
            init() {
                _data = Box(NSMutableData())
            }
            init(_ data: NSData) {
                _data = Box(data.mutableCopy() as! NSMutableData)
            }
            mutating func append(_ byte: UInt8) {
                var mutableByte = byte
                _dataForWriting.append(&mutableByte, length: 1)
            }
        }
        
        var bytes = MyData()
        var copy = bytes
        for byte in 0..<5 as CountableRange<UInt8> {
            print("Appending 0x\(String(byte, radix: 16))")
            bytes.append(byte)
        }
    }
    
    
    
}
