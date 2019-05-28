//
//  Custom.swift
//  Swift_YJC
//
//  Created by IOS3 on 2018/12/25.
//  Copyright © 2018 IOS3. All rights reserved.
//

import Foundation



let FYDomain = "http://cloud.wm319.com/"
//
//#if DEBUG
//let FYDomain = "http://114.116.28.196:9003/"
//#else
//let FYDomain = "http://cloud.wm319.com/"
//#endif




public func debugLog<T>(_ message: T, fileName: String = #file, funcName: String = #function, lineNum: Int = #line) {
    #if DEBUG
    if let file = fileName.components(separatedBy: "/").last,
        let fn = file.components(separatedBy: ".").first {
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let time = formatter.string(from: date)
        
        print("[\(time)] - \(fn)<\(lineNum)> - \(funcName)\nlog: \(message)")
    }
    #endif
}





