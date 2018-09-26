//
//  CallCAsmnameController.swift
//  Swift-100-tips-study
//
//  Created by 解向前 on 2018/9/20.
//  Copyright © 2018年 com.test. All rights reserved.
//

//
// Foundation 导入了Darwin 等 C库
//
// 使用第三方 C代码, 像OC一样将头文件暴露在桥接文件中
// @asmname
//        File.swift
//        将 C 的 test 方法映射为 Swift 的 c_test 方法
//        @asmname("test") func c_test(a: Int32) -> Int32
//
//        func testSwift(input: Int32) {
//            let result = c_test(input)
//            print(result)
//        }
//
//        testSwift(1)
//         输出：2
// 这种 方法可以避免到入库方法 与系统库重名
// 还可以将 C 中不认可的Swift程序元素字符重命名为 ascii码, 以便在C中使用


import UIKit

class CallCAsmnameController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
