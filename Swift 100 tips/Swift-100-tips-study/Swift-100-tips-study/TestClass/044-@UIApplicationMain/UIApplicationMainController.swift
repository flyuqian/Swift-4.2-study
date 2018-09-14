//
//  UIApplicationMainController.swift
//  Swift-100-tips-study
//
//  Created by 解向前 on 2018/9/14.
//  Copyright © 2018年 com.test. All rights reserved.
//

//
//    在 C 系语言中，程序的入口都是 main 函数。对于一个 Objective-C 的 iOS app 项目，在新建项目时， Xcode 将帮我们准备好一个 main.m 文件，其中就有这个 main 函数：
//    int main(int argc, char * argv[]) {
//        @autoreleasepool {
//            return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
//        }
//    }
//    在这里我们调用了 UIKit 的 UIApplicationMain 方法。这个方法将根据第三个参数初始化一个 UIApplication 或其子类的对象并开始接收事件 (在这个例子中传入 nil，意味使用默认的 UIApplication)。最后一个参数指定了 AppDelegate 类作为应用的委托，它被用来接收类似 didFinishLaunching 或者 didEnterBackground 这样的与应用生命周期相关的委托方法。另外，虽然这个方法标明为返回一个 int，但是其实它并不会真正返回。它会一直存在于内存中，直到用户或者系统将其强制终止。
//
// Swift 中由 @UIApplicationMain 帮我们自动插入main函数这样的模板代码
// 如果我们希望使用 UIApplication 的子类的话
// 创建一个main.Swift 文件
// 我们不需要定义作用域, 这个文件中的代码将被作为main函数来执行
// 在AppDelegate中移除 @UIApplicationMain标签
// 添加 main.Swift 文件
// 加上: UIApplicationMain(Process.argc, Process.unsafeArgv, nil, NSStringFromClass(AppDelegate))
// 我们可以将 第三个参数替换成自己的 UIApplication 子类

//        import UIKit
//        class MyApplication: UIApplication {
//            override func sendEvent(event: UIEvent!) {
//                super.sendEvent(event)
//                print("Event sent: \(event)");
//            }
//        }
//        UIApplicationMain(Process.argc, Process.unsafeArgv,
//            NSStringFromClass(MyApplication), NSStringFromClass(AppDelegate))
// 这样每次发送事件时, 我们都能监听到这个事件



import UIKit

class UIApplicationMainController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
