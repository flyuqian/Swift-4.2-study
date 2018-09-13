//
//  InitialOrderController.swift
//  Swift-100-tips-study
//
//  Created by 解向前 on 2018/9/13.
//  Copyright © 2018年 com.test. All rights reserved.
//

//
// Swift 的初始化方法需要保证类型的所有属性都被初始化
// 在保证子类成员初始化完成, 才能调用父类的初始化方法
//
// 一般子类初始化的顺序
// 1.设置子类自己需要初始化的参数
// 2.调用父类的响应的初始化方法
// 3.对父类中的需要改变的成员进行设定
// 如果不需要改变父类的成员, 那么可以不用调用父类的init方法, 由Swift自动调用super.init()


import UIKit

class InitialOrderController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
