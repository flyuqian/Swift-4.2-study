//
//  InitialCategoryController.swift
//  Swift-100-tips-study
//
//  Created by 解向前 on 2018/9/13.
//  Copyright © 2018年 com.test. All rights reserved.
//

//
// Swift 强化了designated初始化方法的地位
// Swift 中不加修饰的init方法都需要在方法中保证所有非Optional的实例变量被赋值初始化
// 子类中也强制, 显式或隐式地调用super版本的designated出事哈
// 无论何种路径, 被初始化对象总是可以完成完整的初始化
//
// convenience 关键字的初始化方法, 只作为补充或提供使用上的方便
//  所有convenience初始化方法 都必须调用同类中的designated方法完成设置
//  convenience出初始化方法 不能被子类重写, 或者是从子类中以super的方式被调用
//
// 原则
//  1. 初始化路径必须保证对象完全初始化, 这可以保证通过调用类型的designated初始化方法得到保证
//  2. 子类的designated初始化方法必须调动父类的designated方法, 以保证父类也完成初始化
//
// 如果希望子类一定实现某个designated初始化方法 可以添加required 关键字
// convenience 初始化方法, 也可以添加required
import UIKit

class InitialCategoryController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
