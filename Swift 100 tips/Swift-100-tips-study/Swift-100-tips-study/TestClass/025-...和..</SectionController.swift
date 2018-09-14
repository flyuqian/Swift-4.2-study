//
//  SectionController.swift
//  Swift-100-tips-study
//
//  Created by 解向前 on 2018/9/14.
//  Copyright © 2018年 com.test. All rights reserved.
//

//
// ...
// ..<
// 除了输出Int或Double, 返回一个Range外
// 操作符还有一个接受 Comparable的输入, 返回 ClosedInterval 或 HalfOpenInterval的重载
import UIKit

class SectionController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        let test = "helLo"
        let interval = "a"..."z"
        for c in test {
            if interval.contains(String(c)) {
                print("\(c)不是小写字母")
            }
        }
    }

}
