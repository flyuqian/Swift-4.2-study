//
//  TestMVVM_1_Controller.swift
//  strx
//
//  Created by IOS3 on 2018/12/11.
//  Copyright © 2018 IOS3. All rights reserved.
//

//
// MVC 介绍
/*
 - Model：数据层。负责读写数据，保存 App 状态等。
 - View：界面显示层。负责和用户交互，向用户显示页面，反馈用户行为等。
 - Controller：业务逻辑层。负责业务逻辑、事件响应、数据加工等工作。
 - 通常情况下，Model 与 View 之间是不允许直接通信的，而必须由 Controller 层进行协调
 
 - 缺点
    - ViewController 既扮演了 View 的角色，又扮演了 Controller 的角色。
    - 而 Model 在 ViewController 中又可以直接与 View 进行交互。
    - 一旦 App 的交互复杂些，就会发现 ViewController 将变得十分臃肿。大量代码被添加到控制器中，使得控制器负担过重。同时 View 与 Controller 混在一起，也不容易实现 View 层的复用。
 */

//
// MVVM
/*
 - MVVM 增加了 ViewModel 层。我们可以将原来 Controller 中的业务逻辑抽取出来放到 ViewModel 中，从而大大减轻了 ViewController 的负担。
 - 同时在 MVVM 中，ViewController 只担任 View 的角色（ViewController 与 View 现在共同作为 View 层），负责 View 的显示和更新，其他业务逻辑不再需要 ViewController 来管了。
 - 同样使用 MVVM 架构时，Model 与 View|ViewControllter 之间是不允许直接通信的，而是由 ViewModel 层进行协调
 
 - 优点
    - 一来可以对 ViewController 进行瘦身。
    - 二来可以实现视图逻辑的复用。比如一个 ViewModel 可以绑定到不同的 View 上，让多个 view 重用相同的视图逻辑。
    - 而且使用 MVVM 可以大大降低代码的耦合性，不仅方便测试、维护，也方便多人协作开发。
 - 缺点
    - 相较于 MVC，使用 MVVM 会轻微的增加代码量。但总体上减少了代码的复杂性，个人觉得还是值得的。
    - 还有就是学习成本。使用 MVVM 还是有许多地方要学习的。比如 View 与 ViewModel 之间的数据绑定，如果驾驭不好，同样会造成代码逻辑复杂，不易维护的问题。但我想年轻人还是要有颗拥抱变化的心。不要守旧、不要排斥新技术，这样才能不断进步，不会被时代给淘汰。
 */

import UIKit

class TestMVVM_1_Controller: BaseController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

    

}
