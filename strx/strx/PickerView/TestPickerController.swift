//
//  TestPickerController.swift
//  strx
//
//  Created by IOS3 on 2018/12/6.
//  Copyright © 2018 IOS3. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources


class TestPickerController: BaseController {

    var pickerView: UIPickerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        test01()
    }
    
    
    func test01() {
        
        pickerView = UIPickerView()
        view.addSubview(pickerView)
        
        
        // 显示普通文本的 PickerView 适配器
        let stringPickerAdapter = RxPickerViewStringAdapter<[String]>(
            components: [],
            numberOfComponents: { _, _, _ in 1 },
            numberOfRowsInComponent: { _, _, items, _ in
                return items.count
        }, titleForRow: { _, _, items, row, _ in
            return items[row]
        })
        
//        Observable.just(["one", "two", "three"])
//            .bind(to: pickerView.rx.items(adapter: stringPickerAdapter))
//            .disposed(by: disposeBag)
        
        // 双列数据
        let stringPickerAdapter2 = RxPickerViewStringAdapter<[[String]]>(
            components: [],
            numberOfComponents: { ds, pv, cps in cps.count },
            numberOfRowsInComponent: { _, _, cps, cp in
                return cps[cp].count
        }, titleForRow: { _, _, cps, row, cp in
            return cps[cp][row]
        })
        
        // 可以 在 适配器中返回 富文本或者自定义视图, 自定义样式
        
        
        Observable.just([["One", "Two", "Tree"],
                         ["A", "B", "C", "D"]])
            .bind(to: pickerView.rx.items(adapter: stringPickerAdapter2))
            .disposed(by: disposeBag)
        
        let button = UIButton(frame:CGRect(x:0, y:110, width:100, height:30))
        button.center = self.view.center
        button.backgroundColor = UIColor.blue
        button.setTitle("获取信息",for:.normal)
        view.addSubview(button)
        
        button.rx.tap
            .bind{ [weak self] in
                self?.getPickerViewValue()
        }.disposed(by: disposeBag)
        
        
        
    }

    @objc func getPickerViewValue(){
        let message = String(pickerView.selectedRow(inComponent: 0))
        let alertController = UIAlertController(title: "被选中的索引为",
                                                message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }

}
