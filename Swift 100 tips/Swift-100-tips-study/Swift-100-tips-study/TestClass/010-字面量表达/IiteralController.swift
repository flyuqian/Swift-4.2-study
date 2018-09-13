//
//  IiteralController.swift
//  Swift-100-tips-study
//
//  Created by 解向前 on 2018/9/13.
//  Copyright © 2018年 com.test. All rights reserved.
//

//
// 字面量: 值像特定的数字, 字符串或者布尔值这样, 能够直截了当的支出自己的类型为变量进行赋值的值
// Swift为我们提供了一组非常有意思的协议, 使用字面量来表达特定的类型
/*
 ExpressibleByArrayLiteral
 ExpressibleByBooleanLiteral
 ExpressibleByDictionaryLiteral
 ExpressibleByFloatLiteral
 ExpressibleByNilLiteral
 ExpressibleByIntegerLiteral
 ExpressibleByStringLiteral
 */
// 所有的字面量表达协议都定义了一个 typealias 和对应的 init 方法
/*
protocol ExpressibleByBooleanLiteral {
    typealias BooleanLiteralType
    
    /// Create an instance initialized to `value`.
    init(booleanLiteral value: BooleanLiteralType)
}
 */
// 实现一个自己的Bool类型
fileprivate enum MyBool: Int {
    case myTrue, myFalse
}
extension MyBool: ExpressibleByBooleanLiteral {
    init(booleanLiteral value: Bool) {
        self = value ? .myTrue : .myFalse
    }
}
fileprivate let myTrue: MyBool = true
fileprivate let myFalse: MyBool = false
let value = myTrue.rawValue

// 书中还有 字符族 和 字符 的字面量, 表达式
// 去实现 的Person类, 字面量表达式
// ....

import UIKit

class IiteralController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    
    
    }
    

}
