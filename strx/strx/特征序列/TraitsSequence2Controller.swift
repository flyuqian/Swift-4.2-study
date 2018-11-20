//
//  TraitsSequence2Controller.swift
//  strx
//
//  Created by IOS3 on 2018/11/20.
//  Copyright © 2018 IOS3. All rights reserved.
//

import UIKit

class TraitsSequence2Controller: BaseController {
    
    // Driver
    // 最复杂的 trait, 它的目标是提供一种简便的方式在UI层编写响应式代码
    // 特征
    //  不会产生error事件
    //  一定在主线程监听
    //  共享状态变化
    /* 使用场景
      (1）Driver 最常使用的场景应该就是需要用序列来驱动应用程序的情况了，比如：
        通过 CoreData 模型驱动 UI
        使用一个 UI 元素值（绑定）来驱动另一个 UI 元素值
     （2）与普通的操作系统驱动程序一样，如果出现序列错误，应用程序将停止响应用户输入。
     （3）在主线程上观察到这些元素也是极其重要的，因为 UI 元素和应用程序逻辑通常不是线程安全的。
     （4）此外，使用构建 Driver 的可观察的序列，它是共享状态变化。
     */
    
    
    // 这个是官方提供的样例，大致的意思是根据一个输入框的关键字，来请求数据，然后将获取到的结果绑定到另一个 Label 和 TableView 中
    func testDriver() {
        // 案例不完整啊
        // http://www.hangge.com/blog/cache/detail_1942.html
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        //
    }
    

    

}
