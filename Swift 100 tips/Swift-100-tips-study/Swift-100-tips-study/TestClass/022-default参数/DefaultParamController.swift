
//
//  DefaultParamController.swift
//  Swift-100-tips-study
//
//  Created by 解向前 on 2018/9/13.
//  Copyright © 2018年 com.test. All rights reserved.
//

//
// Swift 支持默认参数, 且不限位置和个数
// 我们看到系统方法, 默认参数 default
// 这是含有默认参数的方法所生成的Swift的调用接口
// 当我们指定一个编译时就能确定的常量来作为默认参数的取值是, 这个取值是隐藏在方法内部实现的, 不应该暴露给其他部分
import UIKit

class DefaultParamController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        test()
        
    }

    
    func test(avg: Int = 0, avg2: String = "nil") -> Void {
        print("avg: \(avg), avg2: \(avg2)")
    }
}
