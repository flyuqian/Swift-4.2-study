//
//  UIColor+Extension.swift
//  Swift_YJC
//
//  Created by IOS3 on 2018/12/25.
//  Copyright © 2018 IOS3. All rights reserved.
//

import Foundation
import UIKit


extension UIColor {
    
    convenience init(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, _ a: CGFloat) {
        self.init(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: a)
    }
    
    convenience init(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat) {
        self.init(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: 1.0)
    }
    
    convenience init(_ hexCode: String) {
        var cString:String = hexCode.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if cString.count < 6 {
            self.init(red: 1, green: 1, blue: 1, alpha: 1)
        }
        else {
            let start = cString.startIndex
            var r: UInt32 = 0
            var g: UInt32 = 0
            var b: UInt32 = 0
            var a: UInt32 = 0
            if cString.count == 6 {
                Scanner(string: String(cString[start..<cString.index(start, offsetBy: 2)])).scanHexInt32(&r)
                Scanner(string: String(cString[cString.index(start, offsetBy: 2)..<cString.index(start, offsetBy: 4)])).scanHexInt32(&g)
                Scanner(string: String(cString[cString.index(start, offsetBy: 4)..<cString.index(start, offsetBy: 6)])).scanHexInt32(&b)
                self.init(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: 1)
            }
            else if cString.count == 8 {
                Scanner(string: String(cString[start..<cString.index(start, offsetBy: 2)])).scanHexInt32(&r)
                Scanner(string: String(cString[cString.index(start, offsetBy: 2)..<cString.index(start, offsetBy: 4)])).scanHexInt32(&g)
                Scanner(string: String(cString[cString.index(start, offsetBy: 4)..<cString.index(start, offsetBy: 6)])).scanHexInt32(&b)
                Scanner(string: String(cString[cString.index(start, offsetBy: 6)..<cString.index(start, offsetBy: 8)])).scanHexInt32(&a)
                self.init(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(a) / 255.0)
            }
            else {
                self.init(red: 1, green: 1, blue: 1, alpha: 1)
            }
        }
    }
    
}
