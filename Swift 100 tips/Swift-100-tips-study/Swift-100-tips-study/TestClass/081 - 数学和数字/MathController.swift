//
//  MathController.swift
//  Swift-100-tips-study
//
//  Created by 解向前 on 2018/9/25.
//  Copyright © 2018年 com.test. All rights reserved.
//

//
// Darwin 里的math.h 定义了很多和数学相关的内容, 他在Swift中进行了modeule映射, 可以在Swift中直接使用

import UIKit


class MathController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 圆周长
        let _ = 2 * Double.pi * 5
        // 三角函数使用
        let _ = 5 * tan(Double.pi)
        
        
        // 对数字做了一些约定 (针对平台进行适应)
        let _ = Int.max; _ = Int.min
        
        
        // infinity无穷, nan非数字
        let _ = Double.infinity; _ = Double.nan.isNaN
        // 不能使用 nan 用于比较, 使用 isNaN 判断是不是一个 NAN
        
    }
}
