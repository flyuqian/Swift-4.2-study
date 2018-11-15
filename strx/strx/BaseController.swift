//
//  BaseController.swift
//  strx
//
//  Created by IOS3 on 2018/11/12.
//  Copyright © 2018 IOS3. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class BaseController: UIViewController {
    
    let disposeBag = DisposeBag()
    var contentFrame: CGRect = .zero
    var nav_bottom: CGFloat = 64
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if #available(iOS 11.0, *) {
            if let delegate = UIApplication.shared.delegate,
                let window = delegate.window,
                let bottom = window?.safeAreaInsets.bottom {
                if bottom > CGFloat.init(0) {
                    nav_bottom = 88
                }
            }
        }
        
        contentFrame = CGRect(x: 0, y: 88, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)

        view.backgroundColor = .groupTableViewBackground
    }
    

    deinit {
        print("\(self) deinit")
    }
    
}
