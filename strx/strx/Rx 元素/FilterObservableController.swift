//
//  FilterObservableController.swift
//  strx
//
//  Created by IOS3 on 2018/11/19.
//  Copyright © 2018 IOS3. All rights reserved.
//

import UIKit
import RxSwift

class FilterObservableController: BaseController {

    

    // MARK: filter
    // 过滤掉某些不符合要求的事件
    func testFilter() {
        Observable.of(2, 30, 22, 5, 60, 3, 40, 9)
            .filter { $0 > 10 }
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }
    
    
    
    //MARK: distinctUntilChanged
    // 该操作符用于过滤掉连续重复的事件
    func testDistinctUntilChanged() {
        Observable.of(1, 2, 3, 1, 1, 1, 4)
            .distinctUntilChanged()
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }
    
    
    
    //MARK: single
    // 限制只发送一次事件, 或者满足条件的第一个事件
    // 如果存在有多个事件或者没有事件都发出一个Error事件
    // 如果只有一个事件, 则不会发出error事件
    
    func testSignle() {
        Observable.of(1, 2, 3, 4)
            .single { $0 == 2 }
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        print("-------------------------")
        Observable.of("A", "B", "C", "D")
            .single()
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }
    
    
    
    //MARK: elementAt
    // 只处理指定位置的事件
    func testElementAt() {
        Observable.of(1, 2, 3, 4, 5)
            .elementAt(2)
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }
    
    
    
    //MARK: ignoreElements
    // 该操作符可以忽略掉所有的元素, 只发出error或completed事件, 如果我们只关心序列什么时候终止, 我们可以使用这个方法
    func testIgnoreElements() {
        Observable.of(1, 2, 3, 4)
            .ignoreElements()
            .subscribe { print($0) }
            .disposed(by: disposeBag)
    }
    
    
    
    //MARK: take
    // 该方法取 Observable 的前n个事件, 满足数量后会自动 .completed
    func testTake() {
        Observable.of(1, 2, 3, 4)
            .take(2)
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }
    
    
    
    //MARK: takeLast
    // 该方法取 Observable 中的后n个事件
    func testTakeLast() {
        Observable.of(1, 2, 3, 4)
            .takeLast(2)
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }
    
    
    
    //MARK: skip
    // 跳过 Observable 的前n个 事件
    func testSkip() {
        Observable.of(1, 2, 3, 4, 5)
            .skip(2)
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }
    
    
    //MARK: Sample
    // Sample 除了订阅源Observable外, 还可以监听另一个Observable, 即notifier
    // 每当收到 notifier 事件，就会从源序列取一个最新的事件并发送。而如果两次 notifier 事件之间没有源序列的事件，则不发送值
    func testSample() {
        let source = PublishSubject<Int>()
        let notifier = PublishSubject<String>()
        
        source.sample(notifier)
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        source.onNext(1)
        notifier.onNext("A")
        
        source.onNext(2)
        notifier.onNext("B")
        notifier.onNext("C")
        
        source.onNext(3)
        source.onNext(4)
        
        notifier.onNext("D")
        source.onNext(5)
        
        notifier.onCompleted()
    }
    
    
    
    //MARK: debounce
    // 过滤高频产生的元素, 它只会发出这种元素, 该元素产生后, 一段时间没有新元素产生
    func testDebounce() {
        let times = [
            ["value" : 1, "time" : 0.1],
            ["value" : 2, "time" : 1.1],
            ["value" : 3, "time" : 1.2],
            ["value" : 4, "time" : 1.2],
            ["value" : 5, "time" : 1.4],
            ["value" : 6, "time" : 2.1],
        ]
        Observable.from(times)
            .flatMap { item in
                return Observable.of(Int(item["value"]!))
                    .delaySubscription(Double(item["time"]!), scheduler: MainScheduler.instance)
            }.debounce(0.5, scheduler: MainScheduler.instance)
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        testFilter()
//        testDistinctUntilChanged()
//        testSignle()
//        testElementAt()
//        testIgnoreElements()
//        testTake()
//        testTakeLast()
//        testSkip()
//        testSample()
        testDebounce()
    }

}
