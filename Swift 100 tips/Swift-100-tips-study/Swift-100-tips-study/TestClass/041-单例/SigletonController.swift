//
//  SigletonController.swift
//  Swift-100-tips-study
//
//  Created by 解向前 on 2018/9/14.
//  Copyright © 2018年 com.test. All rights reserved.
//

import UIKit

class SigletonController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()


        // 比较推荐的一种单例写法
        class MyManager {
            static let shared = MyManager()
            private init(){}
        }
    }

}
