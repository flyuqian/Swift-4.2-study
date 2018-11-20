//
//  SchedulersController.swift
//  strx
//
//  Created by IOS3 on 2018/11/20.
//  Copyright © 2018 IOS3. All rights reserved.
//

import UIKit

class SchedulersController: BaseController {
    
    
    // MARK: 调度器
    // RxSwift 实现多线程的核心模块
    // RxSwift 内置的 调度器
    /*
     CurrentThreadScheduler：表示当前线程 Scheduler。（默认使用这个）
     MainScheduler：表示主线程。如果我们需要执行一些和 UI 相关的任务，就需要切换到该 Scheduler 运行。
     SerialDispatchQueueScheduler：封装了 GCD 的串行队列。如果我们需要执行一些串行任务，可以切换到这个 Scheduler 运行。
     ConcurrentDispatchQueueScheduler：封装了 GCD 的并行队列。如果我们需要执行一些并发任务，可以切换到这个 Scheduler 运行。
     OperationQueueScheduler：封装了 NSOperationQueue。
     */
    func testSchedulers() {
        /* GCD 实现
         DispatchQueue.global(qos: .userInitiated).async {
             let data = try? Data(contentsOf: url)
             //再到主线程显示结果
             DispatchQueue.main.async {
             self.data = data
             }
         }
         */
        /* RxSwift实现
         let rxData: Observable<Data> = ...
         rxData
             .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .userInitiated)) //后台构建序列
             .observeOn(MainScheduler.instance)  //主线程监听并处理序列结果
             .subscribe(onNext: { [weak self] data in
                self?.data = data
             })
             .disposed(by: disposeBag)
         */
    }
    // subscribeOn 与 observeOn 区别
    /*
     （1）subscribeOn()
     该方法决定数据序列的构建函数在哪个 Scheduler 上运行。
     比如上面样例，由于获取数据、解析数据需要花费一段时间的时间，所以通过 subscribeOn 将其切换到后台 Scheduler 来执行。这样可以避免主线程被阻塞。
     
     （2）observeOn()
     该方法决定在哪个 Scheduler 上监听这个数据序列。
     比如上面样例，我们获取并解析完毕数据后又通过 observeOn 方法切换到主线程来监听并且处理结果。
     */
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

    

}
