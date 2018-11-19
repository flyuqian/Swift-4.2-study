//
//  OtherOperatorController.swift
//  strx
//
//  Created by IOS3 on 2018/11/19.
//  Copyright © 2018 IOS3. All rights reserved.
//

import UIKit
import RxSwift


class OtherOperatorController: BaseController {
	
	
	
	
	//MARK: delay
	// 该操作符, 会将Observable的所有元素都先拖延一段设定好的时间, 然后才将他们发送出来
	func testDelay() {
		Observable.of(1, 2, 3)
            .delay(3, scheduler: MainScheduler.instance)
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
	}
    
    
    //MARK: delaySubscription
    // 延迟订阅, 经过设定的时间后才对 Observable 订阅
    func testDelaySubscription() {
        Observable.of(1, 2, 3)
            .delaySubscription(3, scheduler: MainScheduler.instance)
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }
    
    //MARK: materialize
    // 该操作符 可以将序列产生的时间, 转换成元素
    // 将 Observable 产生的所有事件, 转成元素, 然后发出来
    func testmaterialize() {
        Observable.of(1, 2, 3)
            .materialize()
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }
	
    
    
    // MARK: dematerialize
    // 将 materalaize 转换的元素还原
    func testDemateralize() {
        Observable.of(1, 2, 3)
            .materialize()
            .dematerialize()
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }
	
    
    //MARK: timeout
    // 该操作符可以设定一个超时时间, 如果源Observable在规定的时间内没有发出任何元素, 就产生一个error
    func testTimeout() {
        let times = [
            ["value" : 1, "time" : 0],
            ["value" : 2, "time" : 0.5],
            ["value" : 3, "time" : 1],
            ["value" : 4, "time" : 4],
            ["value" : 5, "time" : 5],
        ]
        Observable.from(times, scheduler: MainScheduler.instance)
            .flatMap {
                Observable.of(Int($0["value"]!))
                    .delaySubscription(Double($0["time"]!), scheduler: MainScheduler.instance)
            }.timeout(2, scheduler: MainScheduler.instance)
            .subscribe(onNext: { print($0) }, onError: { print($0) })
            .disposed(by: disposeBag)
        
    }
    
    
    //MARK: using
    // 使用using 创建Observable时, 同时会创建一个可被清除的资源, 一旦Observable终止了, 那么这个资源就会被清除
    func testUsing() {
        class AnyDisposable: Disposable {
            let _dispose: () -> Void
            init(_ disposeable: Disposable) {
                _dispose = disposeable.dispose
            }
            func dispose() {
                _dispose()
            }
        }
        
        let infiniteInterval = Observable<Int>.interval(0.1, scheduler: MainScheduler.instance)
            .do(
                onNext: { print("infinite: \($0)") },
                onSubscribe: { print("开始订阅 infinite") },
                onDispose: { print("销毁 infinite") }
        )
        
        let limited = Observable<Int>
            .interval(0.5, scheduler: MainScheduler.instance)
            .take(2)
            .do(onNext: { print("limited: \($0)") },
                onSubscribe: { print("开始订阅 limited") },
                onDispose: { print("销毁 limited") }
        )
        
        let o: Observable<Int> = Observable.using({ () -> AnyDisposable in
            return AnyDisposable(infiniteInterval.subscribe())
        }) { _ in
            return limited
        }
        
        o.subscribe()
    }
    
    
	override func viewDidLoad() {
		super.viewDidLoad()
//        testDelay()
//        testDelaySubscription()
//        testmaterialize()
//        testDemateralize()
//        testTimeout()
        testUsing()
		
	}
	
	
    
	
}

