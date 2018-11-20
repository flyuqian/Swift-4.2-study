//
//  TestUI_1_Controller.swift
//  strx
//
//  Created by IOS3 on 2018/11/20.
//  Copyright © 2018 IOS3. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TestUI_1_Controller: BaseController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 将文本绑定到 text 属性上
        func test1() {
            let label = UILabel(frame: CGRect(x: 0, y: 100, width: 300, height: 50))
            view.addSubview(label)
            
            // 每 0.1s 发出一个索引
            let timer = Observable<Int>.interval(0.1, scheduler: MainScheduler.instance)
            timer
                .map { String(format: "%0.2d : %0.2d : %0.1d", ($0 / 600) % 600, ($0 % 600 ) / 10, $0 % 10) }
                .bind(to: label.rx.text)
                .disposed(by: disposeBag)
        }
        
        
        
        
        
        //将数字转成对应的富文本
        func formatTimeInterval(ms: NSInteger) -> NSMutableAttributedString {
            let string = String(format: "%0.2d:%0.2d.%0.1d",
                                arguments: [(ms / 600) % 600, (ms % 600 ) / 10, ms % 10])
            //富文本设置
            let attributeString = NSMutableAttributedString(string: string)
            //从文本0开始6个字符字体HelveticaNeue-Bold,16号
            attributeString.addAttribute(NSAttributedString.Key.font,
                                         value: UIFont(name: "HelveticaNeue-Bold", size: 16)!,
                                         range: NSMakeRange(0, 5))
            //设置字体颜色
            attributeString.addAttribute(NSAttributedString.Key.foregroundColor,
                                         value: UIColor.white, range: NSMakeRange(0, 5))
            //设置文字背景颜色
            attributeString.addAttribute(NSAttributedString.Key.backgroundColor,
                                         value: UIColor.orange, range: NSMakeRange(0, 5))
            return attributeString
        }
        // 将文本绑定到 attributedText属性上
        func test2() {
            let label = UILabel(frame: CGRect(x: 0, y: 100, width: 300, height: 50))
            view.addSubview(label)
            
            let timer = Observable<Int>.interval(0.1, scheduler: MainScheduler.instance)
            timer
                .map(formatTimeInterval)
                .bind(to: label.rx.attributedText)
                .disposed(by: disposeBag)
        }
        
        
        
        // test1()
        test2()
        
        
    }
    

    

}
