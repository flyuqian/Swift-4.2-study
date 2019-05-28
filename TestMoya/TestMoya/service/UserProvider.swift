//
//  RxUserProvider.swift
//  TestMoya
//
//  Created by IOS3 on 2019/3/29.
//  Copyright © 2019 IOS3. All rights reserved.
//

import Foundation
import Moya





/*
MoyaProvider<UserAPI>(
    endpointClosure: , // 自定义endPoint , 定义请求头相关信息
 requestClosure: , // 他用于定义当 Endpoint 有问题时，提前拦截请求，即决定是否执行请求或执行什么样的请求（我们可以回调一个修改了的 URLRequest），也就是说这里可以定制 URLRequest 的属性，例如 timeoutInterval 、 cachePolicy 、 httpShouldHandleCookies 等，事实上这里也可以设置 httpHeaderFields。
    stubClosure: , // 实现一个返回  Moya.StubBehavior 的闭包，这个 Moya.StubBehavior 用于表示是否/怎样去 stub 一个请求，说清楚点就是是否使用 SampleData 作为请求返回的数据，用于模拟网络请
    callbackQueue: ,
 manager: , // 这里可以自定义 SessionManager，一般用于定制 configuration。configuration 包含了 requestCachePolicy 、 timeoutIntervalForRequest 、 httpAdditionalHeaders 、 httpCookieStorage 等设置
    plugins: , 可以在请求准备发起和接收到返回数据时回调
    trackInflights: )
*/
let userBaseURL = FYDomain + "user/"


public enum UserLoginType: String {
    case password = "1"
    case sms = "2"
}


public enum UserAPI {
    
    /// 注册
    case register(String)
    
    /// 登录
    case login(String)
    
    /// 登出
    case logout(String)

    /// 发送验证码
    case createSmsCode(String)

    /// 校验验证码
    case checkSmsCode(String)

    /// 修改密码(忘记密码)
    case changePassword(String)

    /// 修改密码(个人中心)
    case changePasswordByNew(String)
}

extension UserAPI: TargetType {
    public var baseURL: URL {
        return URL(string: userBaseURL)!
    }
    
    public var path: String {
        switch self {
        case .register(_):
            return "register"
            
        case .login(_):
            return "login"

        case .logout(_):
            return "logout"

        case .createSmsCode(_):
            return "createSmsCode"

        case .checkSmsCode(_):
            return "checkSmsCode"

        case .changePassword(_):
            return "changePassword"

        case .changePasswordByNew(_):
            return "changePasswordByNew"
            
        }
    }
    
    public var method: Moya.Method {
        switch self {
            
        default:
            return .post
        }
    }
    
    // 单元测试模拟的数据
    public var sampleData: Data {
        return "{}".data(using: .utf8)!
    }
    
    // 请求任务, 在这里加参数
    public var task: Task {
        switch self {
        case .register(let paramString), .login(let paramString), .logout(let paramString),
                  .createSmsCode(let paramString), .checkSmsCode(let paramString),
                  .changePassword(let paramString), .changePasswordByNew(let paramString):
            return .requestParameters(parameters: ["info" : paramString], encoding: URLEncoding.default)
        }
    }
    
    public var headers: [String : String]? {
        return nil
    }
    
    
}





//public enum RequestError {
//    case paramsEncode
//    case client
//    case server(code: Int, msg: String)
//    case dataDecode
//}


