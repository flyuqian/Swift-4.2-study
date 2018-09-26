//
//  Encode@Controller.swift
//  Swift-100-tips-study
//
//  Created by 解向前 on 2018/9/20.
//  Copyright © 2018年 com.test. All rights reserved.
//

//
// 类型编码 @encode
// OC 中 @encode , 通过传入一个类型, 我们就可以获取代表这个类型的编码C字符串
// 这个关键字, 常用在OC运行时的消息机制中, 传递参数时, 由于类型信息的确实, 需要类型编码进行辅助以保证类型信息也能够被传递

// Swift拥有自己的 Metatype 来处理类型, 并且在运行时保留了这些类型的信息
// 在Cocoa中我们还可以通过NSValue的objcType属性来获取对应的类型指针
import UIKit

class Encode_Controller: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
