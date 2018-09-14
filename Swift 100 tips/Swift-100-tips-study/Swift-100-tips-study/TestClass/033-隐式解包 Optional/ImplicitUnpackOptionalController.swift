//
//  ImplicitUnpackOptionalController.swift
//  Swift-100-tips-study
//
//  Created by 解向前 on 2018/9/14.
//  Copyright © 2018年 com.test. All rights reserved.
//

//
// 一种特殊的Optional
// 对他的成员或者方法进行访问时, 编译器会帮我们自动进行解包  ImplicitlyUnwrappedOptional
// 隐式解包的Optional和普通的Optional没有区别, 只是访问其成员或方法, 编译器自动插入 ! 解包
// 声明的时候, 在类型后面加上!, 这个语法糖, 告诉编译器我们需要一个可以隐式解包的Optional值
//          var maybeObject: MyClass!
//          maybeObject.foo()
//          maybeObject!.foo() 两种方式是相同的
// 隐式解包, 是cocoa有OC转向Swift时, Swift的妥协, 我们应尽量避免 隐式解包的使用

import UIKit

class ImplicitUnpackOptionalController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
