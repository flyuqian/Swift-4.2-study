//
//  SequenceController.swift
//  Swift-100-tips-study
//
//  Created by 解向前 on 2018/9/13.
//  Copyright © 2018年 com.test. All rights reserved.
//

// for ... in 可以用在所有实现了 Sequence 的类型上
// 为了实现一个Sequence, 需要实现一个IteratorProtocol
// Sequence 已经实现了 map filter reduce 等方法

import UIKit

class SequenceController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let arr = [1, 2, 3, 4, 5, 8]
        for i in ReversSequence(array: arr) {
            print("index \(i)")
        }
    }

}


//MARK: 实现一个 反向的 iterator 和 sequnce
// 遵守 IteratorProtocol 协议
// 指定 IteratorProtocol 中 Element 类型
// 提供 next() -> Element? 方法
class ReversIterator<T>: IteratorProtocol {
    typealias Element = T
    
    var array: [Element]
    var currentIndex = 0
    
    init(array: [Element]) {
        self.array = array
        currentIndex = array.count - 1
    }
    
    func next() -> T? {
        if currentIndex < 0 {
            return nil
        }
        else {
            let element = array[currentIndex]
            currentIndex -= 1
            return element
        }
    }
}

// 遵守 Sequence 协议
// 指定 Iterator 类型
// 提供 makeIterator() -> Iterator? 方法
struct ReversSequence<T>: Sequence {
    var array: [T]
    init(array: [T]) {
        self.array = array
    }
    typealias Iterator = ReversIterator<T>
    
    func makeIterator() -> ReversIterator<T> {
        return ReversIterator(array: self.array)
    }
}
