//
//  TailRecursionController.swift
//  Swift-100-tips-study
//
//  Created by 解向前 on 2018/9/26.
//  Copyright © 2018 com.test. All rights reserved.
//

import UIKit

class TailRecursionController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // 递归 可以将复杂的过程用易于理解的方式转化和描述
    // 0...n 的 累加
    func sum(_ n: UInt) -> UInt {
        if n == 0 {
            return 0
        }
        return n + sum(n - 1)
    }
    // 如果数字足够大, 就可能出错
    // 因为 每次对于sum的递归调用都需要在调用栈上保存当前状态, n 足够大, 就会因为栈空间耗尽而导致 栈溢出
    // 解决栈溢出, 可以采用尾递归
    //
    // 尾递归, 让函数里的最后一个动作是一个函数调用的形式, 这个调用的返回值, 直接被当前函数返回, 从而避免在栈上保存状态, 这样函数就可不但更新栈帧, 而不是新建一个
    func tailSum(_ n: UInt) -> UInt {
        func sumInternal(_ n: UInt, current: UInt) -> UInt {
            if n == 0 {
                return current
            }
            else {
                return sumInternal(n - 1, current: current + n)
            }
        }
        return sumInternal(n, current: 0)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let _ = tailSum(1_000_000)
        // 该调用一节会出错, 因为Debug模式下, Swift编译器不会对尾递归进行优化, 如果改为realse 就可以正常运行
    }
}
