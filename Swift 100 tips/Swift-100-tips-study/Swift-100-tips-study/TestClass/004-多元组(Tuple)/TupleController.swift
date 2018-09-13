//
//  TupleController.swift
//  Swift-100-tips-study
//
//  Created by 解向前 on 2018/9/13.
//  Copyright © 2018年 com.test. All rights reserved.
//

import UIKit

class TupleController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
     
        var a = 3
        var b = 88
        swapMe2(a: &a, b: &b)
        print("a: \(a) b: \(b)")
    }

    
    // 使用多元组实现 交换输入
    func swapMe2<T>(a: inout T, b: inout T) {
        (a, b) = (b, a)
    }
}

// CGRectDivide 在一定位置切分两个区域
// Swift 使用 多元组实现
