//
//  TestDelegateProxy_2_Controller.swift
//  strx
//
//  Created by IOS3 on 2018/12/12.
//  Copyright © 2018 IOS3. All rights reserved.
//
//  感觉, 这个有点看不懂, 先不看了
//

import UIKit
import RxSwift
import RxCocoa



public class RxImagePickerDelegateProxy: DelegateProxy<UIImagePickerController, UIImagePickerControllerDelegate & UINavigationControllerDelegate>, DelegateProxyType, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    init(imagePicker: UIImagePickerController) {
        super.init(parentObject: imagePicker, delegateProxy: RxImagePickerDelegateProxy.self)
    }
    
    public static func registerKnownImplementations() {
        self.register { RxImagePickerDelegateProxy(imagePicker: $0) }
    }
    
    public static func currentDelegate(for object: UIImagePickerController) -> (UIImagePickerControllerDelegate & UINavigationControllerDelegate)? {
        return object.delegate
    }
    
    public static func setCurrentDelegate(_ delegate: (UIImagePickerControllerDelegate & UINavigationControllerDelegate)?, to object: UIImagePickerController) {
        object.delegate = delegate
    }
    
    
}


extension Reactive where Base: UIImagePickerController {
    public var pickerDelegate: DelegateProxy<UIImagePickerController, UIImagePickerControllerDelegate & UINavigationControllerDelegate> {
        return RxImagePickerDelegateProxy.proxy(for: base)
    }
    
    public var didFinishPickingMediaWithInfo: Observable<[String : AnyObject]> {
        return pickerDelegate.methodInvoked(#selector(UIImagePickerControllerDelegate.imagePickerController(_:didFinishPickingMediaWithInfo:))).map { a in
            return try castOrThrow(Dictionary<String, AnyObject>.self, a[1])
        }
    }
}

fileprivate func castOrThrow<T>(_ resultType: T.Type, _ object: Any) throws -> T {
    guard let returnValue = object as? T else {
        throw RxCocoaError.castingError(object: object, targetType: resultType)
    }
    return returnValue
}



class TestDelegateProxy_2_Controller: BaseController {

    override func viewDidLoad() {
        super.viewDidLoad()

        addSubviews()
    }
    
    
    
    @objc func btn1Click(sender: UIButton) -> Void {
        
    }
    @objc func btn2Click(sender: UIButton) -> Void {
        
    }
    @objc func btn3Click(sender: UIButton) -> Void {
        
    }

   
    func addSubviews() {
        let btn1 = UIButton(frame: CGRect(x: 0, y: 100, width: 100, height: 50));
        btn1.setTitle("拍照", for: .normal)
        btn1.setTitleColor(.darkText, for: .normal)
        btn1.addTarget(self, action: #selector(btn1Click(sender:)), for: .touchUpInside)
        
        let btn2 = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50));
        btn2.setTitle("拍照", for: .normal)
        btn2.setTitleColor(.darkText, for: .normal)
        btn2.addTarget(self, action: #selector(btn2Click(sender:)), for: .touchUpInside)
        
        let btn3 = UIButton(frame: CGRect(x: 200, y: 100, width: 100, height: 50));
        btn3.setTitle("拍照", for: .normal)
        btn3.setTitleColor(.darkText, for: .normal)
        btn3.addTarget(self, action: #selector(btn3Click(sender:)), for: .touchUpInside)
    }

}
