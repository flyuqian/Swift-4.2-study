//
//  SelectorController.swift
//  Swift-100-tips-study
//
//  Created by 解向前 on 2018/9/14.
//  Copyright © 2018年 com.test. All rights reserved.
//

//
// @selector OC关键字, 将一个方法 转换并复制给一个 SEL 类型, 表现类似一个动态的函数指针
// #selector 来从暴露给 OC 代码中获取一个selector;  Swift 对应原来的 SEL类型, 是一个叫做Selector的结构体
// Swift4中, 所有Swift方法在 OC中不可见, 在这类方法前加上 @objc, 将方法暴露给OC
// 如果想要整个Swift类型在OC中可用, 可以在类型前添加 @objcMembers

/*
 但是，如果在同一个作用域中存在同样名字的两个方法，即使它们的函数签名不相同，Swift 编译器也不允许编译通过：
 
 @objc func commonFunc() {
 
 }
 
 @objc func commonFunc(input: Int) -> Int {
 return input
 }
 
 let method = #selector(commonFunc)
 // 编译错误，`commonFunc` 有歧义
 对于这种问题，我们可以通过将方法进行强制转换来使用：
 
 let method1 = #selector(commonFunc as ()->())
 let method2 = #selector(commonFunc as (Int)->Int)
 

 */
import UIKit

class SelectorController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
