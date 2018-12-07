//
//  TestAlamo_4_Controller.swift
//  strx
//
//  Created by IOS3 on 2018/12/7.
//  Copyright © 2018 IOS3. All rights reserved.
//

import UIKit
import RxSwift
import RxAlamofire
import Alamofire

class TestAlamo_4_Controller: BaseController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let destination: DownloadRequest.DownloadFileDestination = { _, response in
            let documentURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let fileURL = documentURL.appendingPathComponent(response.suggestedFilename!)
            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }
        let fileURL = URL(string: "http://www.hangge.com/blog/images/logo.png")!

        
        download(URLRequest(url: fileURL), to: destination)
            .map { reqeuset in
                Observable<Float>.create { observer in
                    reqeuset.downloadProgress(closure: { (progress) in
                        observer.onNext(Float(progress.fractionCompleted))
                        if progress.isFinished {
                            observer.onCompleted()
                        }
                    })
                    return Disposables.create()
                }
            }
            .flatMap { $0 }
            .subscribe(onNext: {
                element in
                print("\(element)")
            })
            .disposed(by: disposeBag)
        
        /*
         download(URLRequest(url: fileURL), to: destination)
         .subscribe(onNext: { element in
         print("a开始下载")
         }, onError: { error in
         print("下载失败, 原因: ", error)
         }, onCompleted: {
         print("下载完成")
         })
         .disposed(by: disposeBag)
         */
        
        
        
    }
    


}
