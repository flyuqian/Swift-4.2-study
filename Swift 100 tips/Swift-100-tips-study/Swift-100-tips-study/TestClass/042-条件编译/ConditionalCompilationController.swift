//
//  ConditionalCompilationController.swift
//  Swift-100-tips-study
//
//  Created by 解向前 on 2018/9/14.
//  Copyright © 2018年 com.test. All rights reserved.
//

//
// 支持 #if 编译标记
//        #if <condition>
//        #elseif <condition>
//        #else
//        #endif
// condition, 并不是任意的, Swift 内建了几种平台和架构的组合, 帮我们为不同的平台编译不同的代码
//        os() macOS, iOS, tvOS, watchOS, Linux   🌸🐔 可选用参数还有FreeBSD, Windows, Android,😂
//        arch() x86_64, arm, arm64, i386
//        swift() >=某个版本
// 这些方法和参数都是大小写敏感的
//        #if os(macOS)
//            typealias Color = NSColor
//        #else
//            typealias Color = UIColor
//        #endif
// 自定义符号进行编译
//        @IBAction func someButtonPressed(sender: AnyObject) {
//            #if FREE_VERSION
//                一些操作
//            #else
//                另一些操作
//            #endif
//        }
// FREE_VERSION 这个编译符号需要在项目的编译选项中进行设置
// Build Setting -> Swift Compiler - Custom Flags -> Other Swift Flags 加上 -D FREE_VERSION
import UIKit

class ConditionalCompilationController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
