//
//  AssertionController.swift
//  Swift-100-tips-study
//
//  Created by 解向前 on 2018/9/25.
//  Copyright © 2018年 com.test. All rights reserved.
//

//
// 断言在cocoa开发中, 一般用在检查输入参数是否满足一定条件, 对其进行论断
// Swift 提供一系列的 assert 方法, 使用断言
// 断言 是开发时特性, 只在Debug环境有效
// 可以对 断言开启条件进行设置, BuildSetting-Swift Compiler - Custom Flags - Other Swift Flags
//  -assert-config Debug 强制启用断言
//  -assert-config Release 禁用断言
//
// 如果需要在Release时, 需要将无法继续的程序终止, 使用fatalError
import UIKit

class AssertionController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
