//
//  ModifierController.swift
//  Swift-100-tips-study
//
//  Created by 解向前 on 2018/9/13.
//  Copyright © 2018年 com.test. All rights reserved.
//

import UIKit

class ModifierController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    
    func test() {
        
        func incrementor(variable: Int) -> Int {
            // variable += 1
            print(variable)
            return variable
        }
        // variable += 1 会使编译器报错, 原因: 参数默认使用 let 修饰
        // 2.2 中可以显示的声明为var, 现以废弃
        // 现在我们只能声明显示的变量
        func incrementor2(variable: Int) -> Int {
            var num = variable
            num += 1
            return num
        }
        
        //
        // 如果我们需要在函数内部直接修改参数值, 我们需要给参数加上 inout 关键字
        func incrementor3(variable: inout Int) {
            variable += 1
        }
        // 调用的时候, 需要加上 &, 表明参数可被改变
        var lucky = 7
        incrementor3(variable: &lucky)
        print("lucky: \(lucky)")
        
        // 参数的修饰符, 具有传递限制
        // 我们必须为 嵌套函数的每一层 的参数, 声明它该有的修饰符
    }
}
