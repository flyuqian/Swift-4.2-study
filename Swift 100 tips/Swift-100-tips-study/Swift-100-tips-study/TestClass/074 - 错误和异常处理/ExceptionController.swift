//
//  ExceptionController.swift
//  Swift-100-tips-study
//
//  Created by 解向前 on 2018/9/25.
//  Copyright © 2018年 com.test. All rights reserved.
//

//
// OC 中, 异常应该在开发阶段被解决, NSError代表错误, 用于用户输入不标准或者读取文件出错等
// OC 中 容易忽略错误

// Swift 中使用 try-catch 处理异常
// 编译器 强制 抛出错误的API必须使用 异常处理
// 缺陷
// 不借助文档, 无法知道异常类型
// 非同步API异常不可用
//
// try! 表示,确定这次调用不会出错
// try? 表示尝试执行, 可选值包装返回结果
// 所以, 在可抛错方法中, 我们应该避免返回 可选值,
// rethrows 一般用在参数中, 表示参数为可抛错函数
// rethrows 可以用来重载被标记为throws的方法或参数, 或者用来满足被标记为throws的协议

import UIKit

class ExceptionController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
