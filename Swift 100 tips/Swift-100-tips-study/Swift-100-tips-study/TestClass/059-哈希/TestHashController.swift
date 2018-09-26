//
//  TestHashController.swift
//  Swift-100-tips-study
//
//  Created by 解向前 on 2018/9/19.
//  Copyright © 2018年 com.test. All rights reserved.
//

//
// 我们需要为 判等结果为相同的对象 提供相同的哈希值
// Swift提供 Hashable 协议, 实现了这个协议, 即可为该类型提供 哈希 支持
// Swift Dictionary 类型的key必须实现了 Hashable
import UIKit

class TestHashController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
