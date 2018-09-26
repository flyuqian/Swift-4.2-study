//
//  UnmanagedController.swift
//  Swift-100-tips-study
//
//  Created by 解向前 on 2018/9/25.
//  Copyright © 2018年 com.test. All rights reserved.
//

//
// OC 中 ARC只负责NSObject的引用计数
//
// Swift 中 CF类型名称通过typealias 去掉了 Ref
// Swift 中 CF API 纳入了ARC的管理
// 对于非系统的CF类型, 如果没有明确的使用上边的标注指明内存管理方式, 这些API返回的类型会被对应为Unmanaged<T>
//  这意味着在使用时我们需要手动进行内存管理，一般来说会使用得到的 Unmanaged 对象的 takeUnretainedValue 或者 takeRetainedValue 从中取出需要的 CF 对象，并同时处理引用计数。takeUnretainedValue 将保持原来的引用计数不变，在你明白你没有义务去释放原来的内存时，应该使用这个方法。而如果你需要释放得到的 CF 的对象的内存时，应该使用 takeRetainedValue 来让引用计数加一，然后在使用完后对原来的 Unmanaged 进行手动释放。为了能手动操作 Unmanaged 的引用计数，Unmanaged 中还提供了 retain，release 和 autorelease 这样的 "老朋友" 供我们使用。一般来说使用起来是这样的 (当然这些 API 都是我虚构的)：

import UIKit

class UnmanagedController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
