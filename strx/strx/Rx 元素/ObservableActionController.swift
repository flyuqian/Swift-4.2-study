//
//  ObservableActionController.swift
//  strx
//
//  Created by IOS3 on 2018/11/15.
//  Copyright © 2018 IOS3. All rights reserved.
//

import UIKit
import RxSwift

class ObservableActionController: BaseController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        test1()
        test2()
    }

}

//MARK: 订阅 Observable
extension ObservableActionController {
    
    func test1() -> Void {
        
        func test01() {
            let observable = Observable.of("A", "B", "C")
            observable.subscribe { event in
                print("event: \(event)");
                print("element: \(event.element)")
                }.disposed(by: disposeBag)
        }
        
        
        func test02() {
            // 分别处理不同类型性的 event
            let observable = Observable.of("A", "B", "C")
            observable.subscribe(onNext: {element in
                print(element)
            }, onError: { error in
                print(error)
            }, onCompleted: {
                print("completed")
            }, onDisposed: {
                print("disposed")
            }).disposed(by: disposeBag)
            
            // 上面的 不同类型的 event 可以自由组合使用
            // 如
            observable.subscribe(onNext: { elemnt in
                print(elemnt)
            }, onCompleted: {
                print("completed")
            }).disposed(by: disposeBag)
        }
        
        
        
//        test01()
        test02()
    }
    
    
}


//MARK: 监听事件的生命周期
// 我们可以使用 doOn 方法来监听事件的生命周期, 他会在每次事件发送前被调用
// 和 Subscrib一样, 可以通过组合不同的闭包处理不同类型的 event
// 即, do(onNext:) 在subScribe(onNext:)前调用
extension ObservableActionController {
    
    func test2() {
        let observable = Observable.of("A", "B", "C")
        
        observable
            .do(onNext: { (element) in
                print(element)
            }, onError: { (error) in
                print(error)
            }, onCompleted: {
                print("completed")
            }, onSubscribe: {
                print("subscribe")
            }, onSubscribed: {
                print("subscribed")
            }, onDispose: {
                print("on despose")
            })
            .subscribe(onNext: {element in
                print(element)
            }, onCompleted: {
                print("subscrib completed")
            })
    }
    

}


//MARK: Observable 的销毁
// Observable 流程,
// 创建, 被订阅后激活
// 发出 .error / .completed 类型的event后终结
//
// dispose() 方法, 该方法手动取消一个订阅行为
// 当我们认为 一个订阅不再需要了, 我们可以通过dispose()方法将这个订阅销毁, 防止内存泄漏
// 订阅行为被 dispose 后, Observable 再发出event, 这个subscribe 将不再受到时间
//
// disPoseBag, 会在自己快要被dealloc 的时候, 将其中的 订阅行为统一调用 dispose()方法
//
extension ObservableActionController {
    
    func test3() {
        
    }
}
