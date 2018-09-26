//
//  LogController.swift
//  Swift-100-tips-study
//
//  Created by 解向前 on 2018/9/25.
//  Copyright © 2018年 com.test. All rights reserved.
//

import UIKit

class LogController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        printLog("print")
    }

    func printLog<T>(_ message: T, file: String = #file, method: String = #function, line: Int = #line) {
        #if DEBUG
        print("\((file as NSString).lastPathComponent)[\(line)], \(method): \(message)")
        #endif
    }
}
