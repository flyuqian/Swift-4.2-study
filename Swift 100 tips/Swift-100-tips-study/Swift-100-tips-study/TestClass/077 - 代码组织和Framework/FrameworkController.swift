//
//  FrameworkController.swift
//  Swift-100-tips-study
//
//  Created by 解向前 on 2018/9/25.
//  Copyright © 2018年 com.test. All rights reserved.
//

//
// 因为 iOS平台安全, Apple不允许动态链接非系统的框架
// 对于 第三方提供的 .framework文件, 是静态库, 每个APP需要在编译的时候进行独立的链接
// Xcode6 开始,提供类型为 Cocoa Touch Framwork 的target 选项, 在同一项目中通过 import target 的 module名字引入, 这样的框架只能在自己的APP中使用, 给别人使用的框架, 需要单独建立用于生成框架的项目, 现在只适用于OC, 书中有生成framework的案例
import UIKit

class FrameworkController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
