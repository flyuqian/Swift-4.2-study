//
//  ObservableController.swift
//  strx
//
//  Created by IOS3 on 2018/11/12.
//  Copyright © 2018 IOS3. All rights reserved.
//

import UIKit
import RxSwift

class ObservableController: BaseController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}


// MARK: Observable<T>
// observable<T> 是 Rx 框架的基础, 可观察序列
// 作用, 异步产生一些列的Event(事件), 即: Observable随时间推移发出 event(element: T)
// Event可以携带数据, T 指定数据类型
// Observer 订阅 Observable

// MARK: Event
/* 源码中 Event 的定义
 public enum Event<Element> {
     case next(Element)
     case error(Swift.Error)
     case completed
 }
 */
// next: 正常事件, 携带数据 T
// error: 错误, 发出 error 后, Observable终止, 不在发出 event
// completed: 正常结束, 之后 Observable终止

// MARK: 创建Observable 序列
extension ObservableController {
    func test() -> Void {

        // just()
        // 传入一个默认值
        let _ = Observable.just(5)
        
        // of()
        // 传入 同类型可变参数
        let _ = Observable.of("a", "b", "c")
        
        // from()
        // 效果与 of() 相同
        let _ = Observable.from([1, 2, 3])
        
        // empty()
        // 空内容 Observable 序列
        let _ = Observable<Int>.empty()
    }
    
    
}
