//
//  RandomNumberController.swift
//  Swift-100-tips-study
//
//  Created by 解向前 on 2018/9/25.
//  Copyright © 2018年 com.test. All rights reserved.
//

//
// arc4random 返回的值, 无论在什么平台上都是一个 UInt32, 所以用在32位平台上有一半几率因为Int转换越界
// 使用
// Int(arc4random()) % x  ==> 0..<x 的一个随机数

import UIKit

class RandomNumberController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
