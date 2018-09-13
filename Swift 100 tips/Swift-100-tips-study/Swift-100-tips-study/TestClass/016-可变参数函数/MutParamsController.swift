//
//  MutParamsController.swift
//  Swift-100-tips-study
//
//  Created by 解向前 on 2018/9/13.
//  Copyright © 2018年 com.test. All rights reserved.
//

//
// 可变参数函数, 可以接受任意多个参数的函数
// 如: OC中的 stringWithFormat方法
// Swift中, 写法 func sum(inputs: Int...), 可变参数被封装成一个数组
// 限制: 一个方法,只能有一个可变参数, 可变参数必须为同一个类型的参数
// 对于第二个限制, 我们可以把可变参数的类型声明为Any
import UIKit

class MutParamsController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
