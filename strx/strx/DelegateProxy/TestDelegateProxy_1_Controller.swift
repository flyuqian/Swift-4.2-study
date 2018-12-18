//
//  TestDelegateProxy_1_Controller.swift
//  strx
//
//  Created by IOS3 on 2018/12/12.
//  Copyright © 2018 IOS3. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import CoreLocation



/*
 （1）DelegateProxy 是代理委托，我们可以将它看作是代理的代理。
 （2）DelegateProxy 的作用是做为一个中间代理，他会先把系统的 delegate 对象保存一份，然后拦截 delegate 的方法。也就是说在每次触发 delegate 方法之前，会先调用 DelegateProxy 这边对应的方法，我们可以在这里发射序列给多个订阅者。
 */


extension Reactive where Base: UILabel {
    var coordinates: Binder<CLLocationCoordinate2D> {
        return Binder(base) { lable, location in
            lable.text = "经度: \(location.longitude)\n纬度: \(location.latitude)"
        }
    }
}
class TestDelegateProxy_1_Controller: BaseController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let btn = UIButton(frame: CGRect(x: 0, y: 100, width: 100, height: 100))
        btn.setTitle("点击", for: .normal)
        btn.setTitleColor(.darkGray, for: .normal)
        view.addSubview(btn)
        
        let label = UILabel(frame: CGRect(x: 0, y: 200, width: 100, height: 100))
        view.addSubview(btn)
        

        let geolocationService = GeolocationService.instance
        
        geolocationService.authorized
            .drive(btn.rx.isHidden)
            .disposed(by: disposeBag)
        
        geolocationService.location
            .drive(label.rx.coordinates)
            .disposed(by: disposeBag)
        
        btn.rx.tap
            .bind { [weak self] _ -> Void in
                self?.openAppPreferences()
        }.disposed(by: disposeBag)
    }
    

    //跳转到应有偏好的设置页面
    private func openAppPreferences() {
        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
        
    }

}
