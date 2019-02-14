//
//  CurryingController.swift
//  Swift-100-tips-study
//
//  Created by 解向前 on 2018/9/13.
//  Copyright © 2018年 com.test. All rights reserved.
//


// 柯里化 是函数式语言的重要表现
import UIKit

class CurryingController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let addTwo = addTo(2)
        let result = addTwo(8)
        print("8 addTo(2) result: \(result)")
        
        let greaterThan10 = greaterThan(10)
        let s1 = greaterThan10(4)
        let s2 = greaterThan10(14)
        
        print("4 greaterThan 10 " + (s1 ? "true" : "false"))
        print("14 greaterThan 10 " + (s2 ? "true" : "false"))
    }

    
    
    

}


//MARK: 1
extension CurryingController {
    // 该函数将数字 +1
    fileprivate func addOne(num: Int) -> Int {
        return num + 1
    }
    
    // 若需要 +2 +3 的函数, 则需要重新定义
    // 此时,我们定义一个函数, 接收 需要与输入数字相加的数字, 并返回一个函数
    func addTo(_ adder: Int) -> (Int) -> Int {
        return { num in
            return num + adder
        }
    }
    
    // 例子2: 比较大小
    func greaterThan(_ comparer: Int) -> (Int) -> Bool {
        return { $0 > comparer }
    }
    
    
}

//
// 利用 柯里化, 实现一种TargetAction
fileprivate protocol TargetAction {
    func performAction()
}
fileprivate struct TargetActionWapper<T: AnyObject>: TargetAction {
    
    weak var target: T?
    let action: (T) -> () -> ()
    
    func performAction() {
        if let t = target {
            action(t)()
        }
    }
}

fileprivate enum ControlEvent {
    case TouchUpInside
    case valueChanged
}
fileprivate class Control {
    var actions = [ControlEvent: TargetAction]()
    func setTarget<T: AnyObject>(target: T,
                                 action: @escaping(T) -> () ->(),
                                 controlEvent: ControlEvent) {
        actions[controlEvent] = TargetActionWapper(target: target, action: action)
    }
    func removeTargetForControlEvent(controlEvent: ControlEvent) {
        actions[controlEvent] = nil
    }
    func performActionForControlEvent(controlEvent: ControlEvent) {
        actions[controlEvent]?.performAction()
    }
}
