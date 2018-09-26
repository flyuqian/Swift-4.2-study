//
//  OverflowController.swift
//  Swift-100-tips-study
//
//  Created by 解向前 on 2018/9/25.
//  Copyright © 2018年 com.test. All rights reserved.
//

// 由于 32位 与 64位机器的 同时存在, 而Swift中视平台而定 Int的类型, 所以可能溢出
// 使用 带有 & 符号的, &+, &-, &*, &/, &%, 可以忽略溢出, 防止崩溃
// 但是溢出符号, 会导致结果不正确, 它只是简单的从高位截断


import UIKit

class OverflowController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

}
