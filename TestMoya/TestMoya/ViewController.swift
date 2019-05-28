//
//  ViewController.swift
//  TestMoya
//
//  Created by IOS3 on 2019/3/29.
//  Copyright © 2019 IOS3. All rights reserved.
//

import UIKit
import RxSwift
import Moya


struct YJCResponse<T: Codable>: Codable {
    let code: String
    let msg: String
    let data: T
}

struct UserLoginModel: Codable {
    let id: Int
    let username: String
    let nickname: String
    let token: String
    let birthday: String?
    let gender: String?
    let photo_url: String?
}



//enum NavigationBarItemType {
//    case one
//}
//
//protocol NavigationBarManager {
//    func getNavigationItem(with type: NavigationBarItemType) -> UINavigationItem
//}
//extension NavigationBarManager {
//    func getNavigationItem(with type: NavigationBarItemType) {
//        switch type {
//        case .one:
//            
//            break
//        default:
//            break
//        }
//    }
//}

class BaseViewController: UIViewController {
    
}



protocol S {
    var a: String { get }
}

class B: S {
    var a: String {
        get {
            return "ccc"
        }
    }
    
}



class ViewController: BaseViewController {
    
    let disposeBag = DisposeBag()
    
    var userProvider: MoyaProvider<UserAPI>!
    var userHUDProvider: MoyaProvider<UserAPI>!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        userProvider = MoyaProvider<UserAPI>(plugins: [NetworkLoggerPlugin()])
        userHUDProvider = MoyaProvider<UserAPI>(plugins: [NetworkLoggerPlugin(), FYRequestHUDPlugin(viewController: self)])
        
        
        let result = login(params: ["username" : 17610241753, "passwordOrSms" : "123456", "type" : 1])
        
        result.subscribe(onNext: { (result) in
            switch result {
            case let .success(response):
                debugLog(response.data.username)
            case .failure(let error):
                
                switch error {

                default:
                    break
                }
                break
            }
        }).disposed(by: disposeBag)
    }
    
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // userHUDProvider.rx.request(.login(username: "17610241753", passwordOrSms: "123456", type: .password
        
        
    }

    
    
    func login(params: [String : Any]) -> PublishSubject<Result<YJCResponse<UserLoginModel>, FYRequestError>>  {
        
        let subject = PublishSubject<Result<YJCResponse<UserLoginModel>, FYRequestError>>()
        
        switch analysisParamters(params: params) {
        case .success(let str):
            let response = userProvider.rx.request(.login(str))
            response.subscribe(onSuccess: { (resp) in
                guard let res = try? JSONDecoder().decode(YJCResponse<UserLoginModel>.self, from: resp.data) else {
                    subject.onNext(.failure(.decode))
                    return;
                }
                subject.onNext(.success(res))
            }) { (error) in
                subject.onNext(.failure(.client(error)))
            }
        case .failure(let error):
            subject.onNext(.failure(error))
        }
        return subject
    }
    
    func analysisParamters(params: [String : Any]) -> Result<String, FYRequestError> {
        do {
            let paramsData = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
            guard let paramsStr = String(data: paramsData, encoding: .utf8) else {
                return .failure(.paser)
                
            }
            return .success(paramsStr)
        } catch let error {
            debugLog(error.localizedDescription)
            return .failure(.paser)
        }
    }
    
//    func handel<T: Codable>(response: Single<Response>) -> Observable<Result<T, Error>> {
//        let subject = PublishSubject<Result<T, Error>>()
//        response.subscribe(onSuccess: { (resp) in
//
//
//        }) { (error) in
//
//        }
//    }

}


enum FYRequestError: Error {
    case paser
    case client(Error)
    case server(Int, String)
    case decode
}
