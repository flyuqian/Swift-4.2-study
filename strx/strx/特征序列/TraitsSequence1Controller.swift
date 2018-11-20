//
//  TraitsSequence1Controller.swift
//  strx
//
//  Created by IOS3 on 2018/11/20.
//  Copyright © 2018 IOS3. All rights reserved.
//

import UIKit
import RxSwift



class TraitsSequence1Controller: BaseController {

    // 除了 Observable，RxSwift 还为我们提供了一些特征序列（Traits）：Single、Completable、Maybe、Driver、ControlEvent。
    // Observable 是可以用于任何上下文环境的通用序列
    // 而 traits 可以更准确的描述序列, 同时提供上下文含义, 语法糖
    
    //MARK: Single
    // Single 只能发出一个元素, 或者产生一个 error 事件
    // 不会共享状态变化
    // 应用场景 执行 HTTP请求
    // SingleEvent 枚举 包含.success .error
    func testSingle() {
        
        // asSingle Observable->Single
        Observable.of("1")
            .asSingle()
            .subscribe { print($0) }
            .disposed(by: disposeBag)
        
        
        enum DataError: Error {
            case cantParseJSON
        }
        
        func getPlayList(_ channel: String) -> Single<[String : Any]> {
            return Single<[String : Any]>.create(subscribe: { single in
                let url = "https://douban.fm/j/mine/playlist?"
                    + "type=n&channel=\(channel)&from=mainsite"
                let task = URLSession.shared.dataTask(with: URL(string: url)!) {
                    data, _, error in
                    if let error = error {
                        single(.error(error))
                        return
                    }
                    guard let data = data,
                        let json = try? JSONSerialization.jsonObject(with: data, options: .mutableLeaves),
                        let result = json as? [String : Any] else {
                            single(.error(DataError.cantParseJSON))
                            return
                    }
                    single(.success(result))
                }
                task.resume()
                return Disposables.create { task.cancel() }
            })
        }
        
        // 也可以使用 subscribe(onSuccess:onError:)
        getPlayList("0")
            .subscribe { event in
                switch event {
                case .success(let json):
                    print("JSON: \(json)")
                case .error(let error):
                    print("发生错误: ", error)
                }
            }.disposed(by: disposeBag)
    }
    
    
    
    // MARK: Completable
    // 只能产生一个事件 completed事件/error事件
    // 不发出任何元素, 不共享状态
    // 应用场景,缓存文件, 只关心是否缓存成功
    // CompetableEvent 枚举: .completed .error
    func testCompletable() {
        enum CacheError: Error {
            case failedCaching
        }
        
        func cacheLocally() -> Completable {
            return Completable.create(subscribe: { (completable) in
                let success = (arc4random() % 2  == 0)
                guard success else {
                    completable(.error(CacheError.failedCaching))
                    return Disposables.create {}
                }
                completable(.completed)
                return Disposables.create { }
            })
        }
        cacheLocally()
            .subscribe(onCompleted: {
                print("保存成功")
            }) { (error) in
                print("保存失败: ", error.localizedDescription)
            }.disposed(by: disposeBag)
    }
    
    
    
    // MARK: maybe
    // 只能发出 一个元素/completed/error, 不共享状态变化
    // MaybeEvent 枚举, .success .completed .error
    // asMaybe() observable -> maybe
    
    func testMaybe() {
        enum StringError: Error {
            case failedGenerate
        }
        func generateString() -> Maybe<String> {
            return Maybe<String>.create { maybe in
                
                //成功并发出一个元素
                maybe(.success("hangge.com"))
                
                //成功但不发出任何元素
                maybe(.completed)
                
                //失败
                //maybe(.error(StringError.failedGenerate))
                
                return Disposables.create {}
            }
        }
        
        
        generateString()
            .subscribe { maybe in
                switch maybe {
                case .success(let element):
                    print("执行完毕，并获得元素：\(element)")
                case .completed:
                    print("执行完毕，且没有任何元素。")
                case .error(let error):
                    print("执行失败: \(error.localizedDescription)")
                    
                }
            }
            .disposed(by: disposeBag)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        testSingle()
//        testCompletable()
        testMaybe()
    }
    

    

}
