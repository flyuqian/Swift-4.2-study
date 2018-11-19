//
//  ErrorHandlerController.swift
//  strx
//
//  Created by IOS3 on 2018/11/19.
//  Copyright © 2018 IOS3. All rights reserved.
//

import UIKit
import RxSwift


class ErrorHandlerController: BaseController {
    
    enum MyError: Error {
        case A
        case B
    }
    
    
    //MARK: catchErrorJustReturn
    // 当遇到 error 事件的时候, 就返回指定的值, 然后结束
    func testCatchErrorJustReturn() {
        let sequenceThatFails = PublishSubject<String>()
        
        sequenceThatFails
            .catchErrorJustReturn("错误")
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        sequenceThatFails.onNext("a")
        sequenceThatFails.onNext("b")
        sequenceThatFails.onNext("c")
        sequenceThatFails.onError(MyError.A)
        sequenceThatFails.onNext("d")
    }
    
    
    
    //MARK: catchError
    // 该方法可以博湖error, 并对其进行处理
    // 同时还能返回另一个 Observable 序列进行订阅 - 切换到新的序列
    func testCatchError() {
        
        let sequenceThatFails = PublishSubject<String>()
        let recoverySequence = Observable.of("1", "2", "3")
        
        sequenceThatFails
            .catchError {
                print("Error:", $0)
                return recoverySequence
            }
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        sequenceThatFails.onNext("a")
        sequenceThatFails.onNext("b")
        sequenceThatFails.onNext("c")
        sequenceThatFails.onError(MyError.A)
        sequenceThatFails.onNext("d")

    }
    
    //MARK: retry
    // 使用该方法遇到错误的时候, 会重新订阅该序列, 比如网络请求失败, 可以重新连接
    // retry() 可以传入数字, 表示充实的次数, 如果不传, 则重试一次
    func testRetry() {
        
        var count = 1
        let sequenceThatErrors = Observable<String>.create { observable in
            observable.onNext("a")
            observable.onNext("b")
            
            if count == 1 {
                observable.onError(MyError.A)
                print("Error encountered")
                count += 1
            }
            
            observable.onNext("c")
            observable.onNext("d")
            observable.onCompleted()
            return Disposables.create()
        }
        
        sequenceThatErrors
        .retry(2)
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

//        testCatchErrorJustReturn()
//        testCatchError()
        testRetry()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
