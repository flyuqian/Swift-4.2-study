//
//  ComBineOpratorController.swift
//  strx
//
//  Created by IOS3 on 2018/11/19.
//  Copyright © 2018 IOS3. All rights reserved.
//



import UIKit
import RxSwift


// 结合操作, 是指多个Observable序列进行组合, 拼装成一个新的Observalbe 序列
class ComBineOpratorController: BaseController {

    
    
    //MARK: startWith
    // 在Observable序列开始之前插入一些事件元素, 即发出事件消息前, 会先发出这些插入的事件
    func  testStartWith() {
        Observable.of("2", "3")
            .startWith("1")
            .startWith("A")
            .startWith("B")
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }
    
    
    
    //MARK:  merge
    // 可以将 两个或两个以上的Observable序列合并成一个 Observable 序列
    func testMerge() {
        let subject1 = PublishSubject<Int>()
        let subject2 = PublishSubject<Int>()
        
        Observable.of(subject1, subject2)
            .merge()
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        subject1.onNext(20)
        subject1.onNext(40)
        subject1.onNext(60)
        subject2.onNext(1)
        subject1.onNext(80)
        subject1.onNext(100)
        subject2.onNext(1)
    }
    
    
    //MARK: zip
    // 该方法可以将多个（两个或两个以上的）Observable 序列压缩成一个 Observable 序列。
    // 而且它会等到每个 Observable 事件一一对应地凑齐之后再合并。
    // 比如我们想同时发送两个请求，只有当两个请求都成功后，再将两者的结果整合起来继续往下处理。这个功能就可以通过 zip 来实现
    func testZip() {
        let subject1 = PublishSubject<Int>()
        let subject2 = PublishSubject<String>()
        
        Observable.zip(subject1, subject2) {
            "\($0)\($1)"
            }
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        subject1.onNext(1)
        subject2.onNext("A")
        subject1.onNext(2)
        subject2.onNext("B")
        subject2.onNext("C")
        subject2.onNext("D")
        subject1.onNext(3)
        subject1.onNext(4)
        subject1.onNext(5)
    }
    
    
    
    
    // MARK: combineLatest
    // 该方法同样是将多个（两个或两个以上的）Observable 序列元素进行合并。
    // 但与 zip 不同的是，每当任意一个 Observable 有新的事件发出时，它会将每个 Observable 序列的最新的一个事件元素进行合并
    func testCombineLatest() {
        let subject1 = PublishSubject<Int>()
        let subject2 = PublishSubject<String>()
        
        Observable.combineLatest(subject1, subject2) {
            "\($0)\($1)"
            }
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        subject1.onNext(1)
        subject2.onNext("A")
        subject1.onNext(2)
        subject2.onNext("B")
        subject2.onNext("C")
        subject2.onNext("D")
        subject1.onNext(3)
        subject1.onNext(4)
        subject1.onNext(5)
    }
    
    
    
    // MARK: withLatestFrom
    // 该方法将两个 Observable 序列合并为一个。每当 self 队列发射一个元素时，便从第二个序列中取出最新的一个值
    func testWithLatestFrom() {
        let subject1 = PublishSubject<String>()
        let subject2 = PublishSubject<String>()
        
        subject1.withLatestFrom(subject2)
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        subject1.onNext("A")
        subject2.onNext("1")
        subject1.onNext("B")
        subject1.onNext("C")
        subject2.onNext("2")
        subject1.onNext("D")
    }
    
    
    
    // MARK: switchLatest
    // switchLatest 有点像其他语言的 switch 方法，可以对事件流进行转换。
    // 比如本来监听的 subject1，我可以通过更改 variable 里面的 value 更换事件源。变成监听 subject2。
    func testSwitchLatest() {
        let subject1 = BehaviorSubject(value: "A")
        let subject2 = BehaviorSubject(value: "1")
        
        let variable = Variable(subject1)
        
        variable.asObservable()
            .switchLatest()
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        subject1.onNext("B")
        subject1.onNext("C")
        
        //改变事件源
        variable.value = subject2
        subject1.onNext("D")
        subject2.onNext("2")
        
        //改变事件源
        variable.value = subject1
        subject2.onNext("3")
        subject1.onNext("E")
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        testStartWith()
//        testMerge()
//        testZip()
//        testCombineLatest()
//        testWithLatestFrom()
        testSwitchLatest()
        
    }
    

    

}
