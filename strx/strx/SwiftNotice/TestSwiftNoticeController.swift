//
//  TestSwiftNoticeController.swift
//  strx
//
//  Created by IOS3 on 2018/12/7.
//  Copyright © 2018 IOS3. All rights reserved.
//


// 没有都试一遍, 作者都8个月没更新, 也没有适配4.2
// http://www.hangge.com/blog/cache/detail_2033.html

import UIKit

class TestSwiftNoticeController: BaseController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        
    }
    

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        SwiftNotice.wait()
//        self.pleaseWait()
//        SwiftNotice.showText("请稍等")
//        self.noticeOnlyText("请稍等")
        SwiftNotice.showNoticeWithText(.success, text: "cheng 功", autoClear: true, autoClearTime: 2)
//        self.noticeSuccess("成功", autoClear: true, autoClearTime: 2)
    }
}
