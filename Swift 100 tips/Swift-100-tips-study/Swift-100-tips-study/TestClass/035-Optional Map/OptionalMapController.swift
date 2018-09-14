//
//  OptionalMapController.swift
//  Swift-100-tips-study
//
//  Created by 解向前 on 2018/9/14.
//  Copyright © 2018年 com.test. All rights reserved.
//

//
// map 方法定义在 CollectionType 的 extension中
// 将 Int? 乘 2, 下面写测试实现 func test()


import UIKit

class OptionalMapController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        test()
    }

    
    func test() {
        let num: Int? = 3
        var result: Int?
        
        if let realNum = num {
            result = realNum * 2
        }
        else {
            result = nil
        }
        
        // 使用map实现上面的需求
        // Optinal的声明中, 有map方法
        let result2 = num.map { $0 * 2 }
        print("result:\(result) result2: \(result2)")
    }
}

// 函数式编程的概念
// 函子: 可以被某个函数作用, 并映射为另一组结果, 这组结果也是函子的值
// Array 和 Optional的map都满足这个概念, 他们分别将 [Self.Generator.Element] 映射为[T] 和  T? 映射为 U?
