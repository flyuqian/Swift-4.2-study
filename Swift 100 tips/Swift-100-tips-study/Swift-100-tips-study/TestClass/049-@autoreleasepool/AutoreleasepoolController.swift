//
//  AutoreleasepoolController.swift
//  Swift-100-tips-study
//
//  Created by 解向前 on 2018/9/19.
//  Copyright © 2018年 com.test. All rights reserved.
//

//
// autoreleasepool 会将街搜到该消息的所有对象放到预先建立的releasepool中, 在autoreleasepool 收到drain消息时, 将对象的引用计数减一, 并移出autoreleasepool
// app中, 整个主线程就是一个autoreleasepool, 在主runloop 结束时,进行drain操作
// 语法
// autoreleasepool { ... }
// 使用初始化方法, 自动内存管理会处理好内存相关的事情, 不需要自动释放
import UIKit

class AutoreleasepoolController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }


}
