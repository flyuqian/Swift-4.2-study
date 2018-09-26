//
//  PlaygroundController.swift
//  Swift-100-tips-study
//
//  Created by 解向前 on 2018/9/25.
//  Copyright © 2018年 com.test. All rights reserved.
//

//
// Playground 可以用在项目中, 需要满足一下条件
//     playground 必须加入到项目中; 通过 file->new->File 选择Palyground
//     想要使用的代码, 必须通过 Cocoa (Touch) Framework 以一个单独的target的方式进行组织
//     编译结果的位置需要保持默认位置, 即在 Xcode 设置中的Locations里的Derived Data 保持默认值
//     如果是iOS应用, 这个框架必须针对iPhone 5s Simulator 这样的64位模拟器作为膜表进行编译
// 满足这些条件后, 就可以在 playground 中import你的框架 module名字来导入代码, 进行使用

//
// Playground 可视化开发
// playground 支持直接运行UI代码, 并且在集成环境中显示UI
// 需要将想要运行的UIView子类赋值给playground的lineView属性, 并且打开 Assistant Editor(ALT Shift Command Return)
// lineView 接受任意满足 playgroundViewable协议的属性
// playgroundViewable 本身需要返回 PlaygroundLiveViewRepresentation, UIView 和 UIViewController 都满足

import UIKit

class PlaygroundController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
