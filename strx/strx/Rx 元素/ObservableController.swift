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

        test()
        
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
        
        // never()
        // 永远不发出event, 也 永远不终止的 Observable 序列
        let _ = Observable<String>.never()
        
        // error()
        // 不做任何操作, 直接发出一个错误
        enum MyError: Error {
            case A, B
        }
        let _ = Observable<Int>.error(MyError.B)
        
        // range
        // 指定起始值, 创建一个将该范围所有值作为初始值的 序列
        let _ = Observable.range(start: 1, count: 5)
        let _ = Observable.of(1, 2, 3, 4, 5) // 与上边相同
        
        // repeatElement()
        // 无限发出给定元素Event, 永不终止
        let _ = Observable.repeatElement(1)
        
        // generate()
        // 创建一个只有提供的所有判断条件都为 true的时候, 才给出动作的 Observable 序列
        let _ = Observable.generate(
            initialState: 0,
            condition: { $0 <= 10 },
            iterate: { $0 + 2 }
        )
        // 2, 4, 6, 8, 10
        
        // create()
        // 接收 闭包参数, 对每个过来的序列进行处理
        let _ = Observable<String>.create { (observer) -> Disposable in
            observer.onNext("next, string")
            observer.onCompleted()
            return Disposables.create()
        }
        
        // deferred()
        // 相当于创建一个 Observable工厂, 通过传入闭包延迟创建 Observable序列
        // 闭包为真正实例化序列对象的地方
        func testDeferred() {
            var isOdd = true
            let factory: Observable<Int> = Observable.deferred {
                isOdd = !isOdd
                if isOdd {
                    return Observable.of(1, 3, 5, 7)
                }
                else {
                    return Observable.of(2, 4, 6, 8)
                }
            }
            factory.subscribe { event in
                print("\(isOdd)", event)
            }.disposed(by: disposeBag)
            
            factory.subscribe { event in
                print("\(isOdd)", event)
                }.disposed(by: disposeBag)
        }
//        testDeferred()
    
        // interval()
        // 创建的Observable序列, 每隔一段设定时间, 会发出一个索引数的元素, 会一直发送下去
        // 只能发出索引, 1 2 3....
        Observable<Int>.interval(1, scheduler: MainScheduler.instance)
            .subscribe { event in
                // print(event)
            }.disposed(by: disposeBag)
        
        // timer
        // 只生成唯一元素
        Observable<Int>.timer(2, scheduler: MainScheduler.instance)
            .subscribe { event in
                print(event)
            }.disposed(by: disposeBag)
        
        // 每隔一段设定时间发出一个元素
        Observable<Int>.timer(4, period: 1, scheduler: MainScheduler.instance)
            .subscribe { event in
                print(event)
        }.disposed(by: disposeBag)
        
    }
    
    
}
