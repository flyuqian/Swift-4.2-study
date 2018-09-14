//
//  WhereAndParttenController.swift
//  Swift-100-tips-study
//
//  Created by 解向前 on 2018/9/14.
//  Copyright © 2018年 com.test. All rights reserved.
//

//
// where 下面案例
// where 对泛型的限定


import UIKit

class WhereAndParttenController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        Test().test()
        Test().test2()
    }
    
    struct Test {
        func test() {
            let name = ["王小二", "张三", "李四", "王二小"]
            name.forEach {
                switch $0 {
                case let x where x.hasPrefix("王"):
                    print("\(x) 是作者本家")
                default:
                    print("你好, \($0)")
                }
            }
        }
        
        func test2() {
            let num: [Int?] = [48, 99, nil]
            let n = num.compactMap { $0 }
            for score in n where score > 60 {
                print("及格的成绩: \(score)")
            }
            
            num.forEach {
                if let score = $0, score > 60 {
                    print("及格成绩: \(score)")
                }
                else {
                    print(":(")
                }
            }
        }
    }
    
    

}
