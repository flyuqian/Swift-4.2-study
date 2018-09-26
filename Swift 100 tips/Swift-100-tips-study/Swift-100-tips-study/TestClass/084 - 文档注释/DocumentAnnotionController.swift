//
//  DocumentAnnotionController.swift
//  Swift-100-tips-study
//
//  Created by 解向前 on 2018/9/25.
//  Copyright © 2018年 com.test. All rights reserved.
//

import UIKit

class DocumentAnnotionController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        

        
        // 案例1
        /**
         A demo method
         - parameter input: An Int number
         - returns: The string represents the input number
         */
        func method(input: Int) -> String {
            return String(input)
        }
        
        /// 尅街注释
        let a = method(input: 2)
        
        
        // Option + Cmd + / 快速生成文档注释
        
        /// <#Description#>
        ///
        /// - Parameter input: <#input description#>
        /// - Returns: <#return value description#>
        func method2(input: Int) -> String {
            return String(input)
        }
    }
    

   

}
