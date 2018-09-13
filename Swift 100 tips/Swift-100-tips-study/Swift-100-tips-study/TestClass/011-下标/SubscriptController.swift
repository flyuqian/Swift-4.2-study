//
//  SubscriptController.swift
//  Swift-100-tips-study
//
//  Created by 解向前 on 2018/9/13.
//  Copyright © 2018年 com.test. All rights reserved.
//

//
// Array 通过下标获取的是一个确定值, 下标错误,运行时崩溃, 所以下标的使用方式,应该是下标的计算获取来保证下标的正确, 不应该使用常量指定
// Dictionary 通过下标获取的是一个可选项, 因为我们不能限制访问下标的输入值

// 案例
extension Array {
    subscript(input: [Int]) -> ArraySlice<Element> {
        get {
            var result = ArraySlice<Element>()
            for i in input {
                assert(i < self.count, "index out of range")
                result.append(self[i])
            }
            return result
        }
        set {
            // input 是下标数组
            // newValue 是=后的值
            for (index, i) in input.enumerated() {
                assert(i < self.count, "index out of range")
                self[i] = newValue[index]
                print("index: \(index), i: \(i)")
            }
        }
    }
}

import UIKit

class SubscriptController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        var arr = [1, 2, 3, 4, 5, 6, 7, 8]
        print("old arr: \(arr)")
        let a = arr[[0, 3, 4]]
        print("a: \(a)")
        arr[[0, 2, 3]] = [-1, -3, -4]
        print("new arr: \(arr)")
        
        let c = arr.enumerated()
//        for (index, i) in c {
//            print("index: \(index), i: \(i)")
//        }
    }

}


