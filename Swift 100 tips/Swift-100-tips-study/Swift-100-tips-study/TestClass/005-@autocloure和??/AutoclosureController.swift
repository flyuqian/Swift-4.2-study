//
//  AutoclosureController.swift
//  Swift-100-tips-study
//
//  Created by 解向前 on 2018/9/13.
//  Copyright © 2018年 com.test. All rights reserved.
//

//
// @autoclosure 可以将一句表达式自动封装成一个闭包
// @autoclosure 不接受带有参数的写法, 只能封装 ()->T
import UIKit

class AutoclosureController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}


extension AutoclosureController {
    func test1() {
        
        // 定义一个方法, 接收一个闭包, 在闭包结果为true 时打印
        func logIfTrue(_ predicate: () -> Bool) {
            if predicate() {
                print("True")
            }
        }
        // 调用
        logIfTrue { () -> Bool in
            return 2 > 1
        }
        // 简化
        logIfTrue({2 > 1})
        logIfTrue{2 > 1}
        
        // 此时加上 @autoclsure
        func logIfTrue2(_ predicate: @autoclosure() -> Bool) {
            if predicate() {
                print("True")
            }
        }
        logIfTrue2(2 > 1)
    }
}

/*
func ??<T>(optional: T?, defaultValue: @autoclosure () -> T) -> T {
    switch optional {
    case .Some(let value):
        return value
    case .None:
        return defaultValue()
    }
}
 */
// ?? 的实现中, 默认值 使用()->T
// 将默认值的计算推迟到 optional 判定为 nil 之后, 节约成本


