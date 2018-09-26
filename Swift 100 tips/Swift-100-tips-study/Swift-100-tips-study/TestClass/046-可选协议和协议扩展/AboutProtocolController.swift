//
//  AboutProtocolController.swift
//  Swift-100-tips-study
//
//  Created by 解向前 on 2018/9/19.
//  Copyright © 2018年 com.test. All rights reserved.
//

//
// OC 的protocol里存在@optional关键字
// Swift协议中的方法必须被实现
// 如果想要在Swift中实现可选方法, 需要在定义协议前,和所有协议方法前都添加 @objc, 并标记为optional, 且仅可被标记为 @objc 的class实现
// Swift 可以通过 protocol extension, 为协议提供默认实现, 有默认实现的方法可选

import UIKit

class AboutProtocolController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
