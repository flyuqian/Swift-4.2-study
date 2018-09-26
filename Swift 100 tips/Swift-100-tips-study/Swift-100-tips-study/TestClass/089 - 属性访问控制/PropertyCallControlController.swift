//
//  PropertyCallControlController.swift
//  Swift-100-tips-study
//
//  Created by 解向前 on 2018/9/25.
//  Copyright © 2018年 com.test. All rights reserved.
//

//
// Swift 的控制权限, 由低到高为
//      private, filePrivate, internal, public, open -默认为internal
// 精确的最小化访问控制级别, 有利于项目的维护
// 可以对属性进行这么限制
//      public private(set) var name: String , 属性可在module外使用, 但只能在该类中设值

import UIKit

class PropertyCallControlController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
