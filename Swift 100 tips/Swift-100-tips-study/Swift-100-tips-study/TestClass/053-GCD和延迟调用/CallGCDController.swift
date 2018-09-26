//
//  CallGCDController.swift
//  Swift-100-tips-study
//
//  Created by 解向前 on 2018/9/19.
//  Copyright © 2018年 com.test. All rights reserved.
//

//
// GCD 是使用多线程的一种方式
import UIKit

class CallGCDController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    
        
        // GCD 案例
        func test1() {
            // 创建膜表队列
            let workingQueue = DispatchQueue(label: "my_queue")
            
            // 派发到刚创建的队列中, GCD会负责进行线程调度
            workingQueue.async {
                // 在 workingQueue中异步进行
                print("努力工作")
                Thread.sleep(forTimeInterval: 2) // 2s 延迟
                DispatchQueue.main.async {
                    print("结束工作, 更新UI")
                }
            }
        }
        test1()
        
    }
}

//
private struct Delay {
    typealias Task = (_ cancel: Bool) -> Void
    
    func delay(_ time: TimeInterval, task: @escaping () -> ()) -> Task? {
        func dispatch_later(block: @escaping () -> ()) {
            let t = DispatchTime.now() + time
            DispatchQueue.main.asyncAfter(deadline: t, execute: block)
        }
        
        var closure: (() -> Void)? = task
        var result: Task?
        
        let delayedClosure: Task = {
            cancle in
            if let internalClosure = closure {
                if (cancle == false) {
                    DispatchQueue.main.async(execute: internalClosure)
                }
            }
            closure = nil
            result = nil
        }
        result = delayedClosure
        
        dispatch_later {
            if let delayedClosure = result {
                delayedClosure(false)
            }
        }
        return result
    }
    
    func cancel(_ task: Task?) {
        task?(true)
    }
    
}
