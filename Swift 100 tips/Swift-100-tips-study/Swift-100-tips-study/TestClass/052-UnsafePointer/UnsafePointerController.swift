//
//  UnsafePointerController.swift
//  Swift-100-tips-study
//
//  Created by 解向前 on 2018/9/19.
//  Copyright © 2018年 com.test. All rights reserved.
//

//
// Swift思想, 所有的引用或者变量的类型都是确定的, 并且能正确对应他们的实际类型, 无法进行任意的类型转换
// Swift针对C语言交互, 定义了 UnsafePointer和他的变体
/*
         C 方法
         void method(const int *num) {
            printf("%d",  *num)
         }
         Swift
         func method(_ num: UnsafePointer<CInt>) {
            print(num.pointee)
         }
 */
// 对于C中的基础类型, 在Swift中 加上C然后首字母大写
import UIKit

class UnsafePointerController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    
    }
}
