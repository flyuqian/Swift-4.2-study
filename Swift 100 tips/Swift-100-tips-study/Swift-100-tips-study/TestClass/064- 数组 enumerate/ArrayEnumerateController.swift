//
//  ArrayEnumerateController.swift
//  Swift-100-tips-study
//
//  Created by 解向前 on 2018/9/20.
//  Copyright © 2018年 com.test. All rights reserved.
//

//
// OC 中, 使用 enumrateObjectUsingBlock: 方法
// Swift 应使用, 快速枚举某个数组的 EnumerateGenerator, 它的元素同时包含了元素下标索引以及元素本身的多元组
import UIKit

class ArrayEnumerateController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        var result = 0
        let xxx = [1, 2, 3, 4, 5].enumerated()
        print(xxx);
        
        for (idx, num) in [1, 2, 3, 4, 5].enumerated() {
            result += num
            if idx == 2 {
                break
            }
        }
        print(result)
    }
}
