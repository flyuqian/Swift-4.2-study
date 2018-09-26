//
//  DynamicObjcController.swift
//  Swift-100-tips-study
//
//  Created by 解向前 on 2018/9/19.
//  Copyright © 2018年 com.test. All rights reserved.
//

//

//
// 使用 @import 引入 module
// OC 中使用 同项目中的Swift源文件, 需要导入自动生成的头文件 {product-module-name}-Swift.h中, 在使用的地方 #import "MyApp-Swift.h"
// 在OC中调用Swift类型时, 为了解决运行时特性, 需要添加@objc修饰符, 继承自NSObject的类的非私有属性已经自动添加@objc
// 如果需要属性或方法动态派发, 需要使用dynamic修饰符
import UIKit

class DynamicObjcController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
