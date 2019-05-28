//
//  UIView+Frame.swift
//  Swift_YJC
//
//  Created by IOS3 on 2018/12/25.
//  Copyright © 2018 IOS3. All rights reserved.
//

import Foundation
import UIKit


extension UIView {
    
    /// frame.origin.x
    var x: CGFloat {
        get {
            return frame.origin.x
        }
        set {
            frame.origin.x = newValue
        }
    }
    
    /// frame.origin.y
    var y: CGFloat {
        get {
            return frame.origin.y
        }
        set {
            frame.origin.y = newValue
        }
    }
    
    /// frame.size.width
    var width: CGFloat {
        get {
            return frame.width
        }
        set {
            frame.size.width = newValue
        }
    }
    
    /// frame.size.height
    var height: CGFloat {
        get {
            return frame.height
        }
        set {
            frame.size.height = newValue
        }
    }
}

