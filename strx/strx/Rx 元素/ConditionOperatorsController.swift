//
//  ConditionOperatorsController.swift
//  strx
//
//  Created by IOS3 on 2018/11/19.
//  Copyright © 2018 IOS3. All rights reserved.
//

import UIKit
import RxSwift


class ConditionOperatorsController: BaseController {

    
    
    
    //MARK: amb
    // 当传入多个 Observable到amb时, 它将取第一个发出元素或产生事件的Observable, 然后只发出它的事件, 忽略掉其他额Observable
    func testAmb() {
        
        let subject1 = PublishSubject<Int>()
        let subject2 = PublishSubject<Int>()
        let subject3 = PublishSubject<Int>()
        
        subject1.amb(subject2).amb(subject3)
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        subject2.onNext(1)
        subject1.onNext(20)
        subject2.onNext(2)
        subject1.onNext(40)
        subject3.onNext(0)
        subject2.onNext(3)
        subject1.onNext(60)
        subject3.onNext(0)
        subject3.onNext(0)
    }
    
    
    
    //MARK: takeWhile
    // 该方法 依次判断 Observable 序列的每一个值是否满足给定的条件, 当第一个不满足条件的值出现时, 它便自动完成
    func testTakeWhile() {
        Observable.of(2, 3, 4, 5, 6, 1, 2)
            .takeWhile { $0 < 4 }
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }
    
    
    
    // MARK: takeUntil
    // 除了订阅源 Observable外, 通过takeUntil 方法还可以监听另一个Observable, 即notifier
    // 如果notifier发出值或complete通知, 那么源Observable便自动完成, 停止发送事件
    func testTakeUntil() {
        let source = PublishSubject<String>()
        let notifier = PublishSubject<String>()
        
        source
            .takeUntil(notifier)
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        source.onNext("a")
        source.onNext("b")
        source.onNext("c")
        source.onNext("d")
        
        //停止接收消息
        notifier.onNext("z")
        
        source.onNext("e")
        source.onNext("f")
        source.onNext("g")
    }
    
    
    
    // MARK: 该方法, 用于跳过前边所有满足条件的事件
    // 一旦遇到不满足条件的事件, 之后就不会再跳过了
    func testSkipWhile() {
        Observable.of(2, 3, 4, 5, 6, 2, 1)
            .skipWhile { $0 < 4 }
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }
    
    
    
    
    // MARK: skipUntil
    /*
     同上面的 takeUntil 一样，skipUntil 除了订阅源 Observable 外，通过 skipUntil 方法我们还可以监视另外一个 Observable， 即 notifier 。
     与 takeUntil 相反的是。源 Observable 序列事件默认会一直跳过，直到 notifier 发出值或 complete 通知。
     */
    func testSkipUntil() {
        let source = PublishSubject<Int>()
        let notifier = PublishSubject<Int>()
        
        source
            .skipUntil(notifier)
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        source.onNext(1)
        source.onNext(2)
        source.onNext(3)
        source.onNext(4)
        source.onNext(5)
        
        //开始接收消息
        notifier.onNext(0)
        
        source.onNext(6)
        source.onNext(7)
        source.onNext(8)
        
        //仍然接收消息
        notifier.onNext(0)
        
        source.onNext(9)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        testAmb()
//        testTakeWhile()
//        testTakeUntil()
//        testSkipWhile()
        testSkipUntil()
    }

}
