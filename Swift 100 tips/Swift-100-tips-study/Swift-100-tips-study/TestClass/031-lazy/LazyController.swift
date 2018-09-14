//
//  LazyController.swift
//  Swift-100-tips-study
//
//  Created by 解向前 on 2018/9/14.
//  Copyright © 2018年 com.test. All rights reserved.
//

//
// lazy修饰属性
// lazy方法

import UIKit

class LazyController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        ClassA().test()
    }
    
    class ClassA {
        lazy var str: String = {
            let str = "Hello"
            print("只有在首次访问时输出")
            return str
        }()
        
        // lazy 方法
        let data = 1...3
        func test() {
            let result = data.lazy.map { (i) -> Int in
                print("正在处理\(i)")
                return i * 2
            }
            print("正在输出访问结果")
            for i in result {
                print("操作后的结果\(i)")
            }
            print("操作完毕")
        }
    }

}
