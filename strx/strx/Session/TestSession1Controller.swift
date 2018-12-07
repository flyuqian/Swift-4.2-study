//
//  TestSession1Controller.swift
//  strx
//
//  Created by IOS3 on 2018/12/6.
//  Copyright © 2018 IOS3. All rights reserved.
//

import UIKit

class TestSession1Controller: BaseController {

    override func viewDidLoad() {
        super.viewDidLoad()

        test01()
    }
    


    func test01() {
        let urlString = "https://www.douban.com/j/app/radio/channels"
        let url = URL(string: urlString)
        let request = URLRequest(url: url!)
        
        URLSession.shared.rx.response(request: request)
            .subscribe(onNext: { response, data in
                if 200 ..< 300 ~= response.statusCode {
                    let str = String(data: data, encoding: .utf8)
                    print("返回的数据: \(str ?? "")")
                }
                else {
                    print("请求失败")
                }
            })
            .disposed(by: disposeBag)
        
        
        /*
         如果不需要获取底层的 response，只需知道请求是否成功，以及成功时返回的结果，那么建议使用 rx.data。
         因为 rx.data 会自动对响应状态码进行判断，只有成功的响应（状态码为 200~300）才会进入到 onNext 这个回调，否则进入 onError 这个回调。
         
         通过点击按钮取消请求
         URLSession.shared.rx.data(request: request)
         .takeUntil(self.cancelBtn.rx.tap)
         */
    }

}
