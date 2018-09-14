//
//  ViewController.swift
//  Swift-100-tips-study
//
//  Created by 解向前 on 2018/9/12.
//  Copyright © 2018年 com.test. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    struct JumpClass {
        var clazz: UIViewController.Type
        var desc: String
    }
    
    var jumpClasss = [JumpClass]() 
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addJumpClass()
        tableView.delegate = self;
        tableView.dataSource = self;
    }


    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let jump = jumpClasss[indexPath.row]
        let c = jump.clazz.init()
        navigationController?.pushViewController(c, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jumpClasss.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let jump = jumpClasss[indexPath.row]
        cell.textLabel?.text = jump.desc
        cell.detailTextLabel?.text = NSStringFromClass(jump.clazz)
        return cell
    }
}

extension ViewController {
    fileprivate func addJumpClass() {
        /* -----           Swift 元素            ------- */
        jumpClasss.insert(JumpClass(clazz: CurryingController.self, desc: "001-柯里化"), at: 0);
        jumpClasss.insert(JumpClass(clazz: MutatingController.self, desc: "002-protocol 方法声明为mutating"), at: 0);
        jumpClasss.insert(JumpClass(clazz: SequenceController.self, desc: "003-Sequence"), at: 0);
        jumpClasss.insert(JumpClass(clazz: TupleController.self, desc: "004-多元组 Tuple"), at: 0);
        jumpClasss.insert(JumpClass(clazz: AutoclosureController.self, desc: "005-@autocloure 和 ??"), at: 0)
        jumpClasss.insert(JumpClass(clazz: EscapingController.self, desc: "006-@escaping"), at: 0)
        jumpClasss.insert(JumpClass(clazz: OptionalChainingController.self, desc: "007-Optional Chaining 可选链"), at: 0)
        jumpClasss.insert(JumpClass(clazz: OperatorController.self, desc: "008-操作符"), at: 0)
        jumpClasss.insert(JumpClass(clazz: ModifierController.self, desc: "009-func 的参数修饰"), at: 0)
        jumpClasss.insert(JumpClass(clazz: IiteralController.self, desc: "010-字面量表达"), at: 0)
        
        jumpClasss.insert(JumpClass(clazz: SubscriptController.self, desc: "011-下标"), at: 0)
        jumpClasss.insert(JumpClass(clazz: FuncNestController.self, desc: "012-下标"), at: 0)
        jumpClasss.insert(JumpClass(clazz: MoudelController.self, desc: "013-命名空间"), at: 0)
        jumpClasss.insert(JumpClass(clazz: TypealiasController.self, desc: "014-typealias"), at: 0)
        jumpClasss.insert(JumpClass(clazz: AssociatedypeController.self, desc: "015-associatedtype"), at: 0)
        jumpClasss.insert(JumpClass(clazz: MutParamsController.self, desc: "016-可变参数函数"), at: 0)
        jumpClasss.insert(JumpClass(clazz: InitialOrderController.self, desc: "017-初始化方法顺序"), at: 0)
        jumpClasss.insert(JumpClass(clazz: InitialCategoryController.self, desc: "018-初始化方法 的分类, 修饰符"), at: 0)
        jumpClasss.insert(JumpClass(clazz: InitialReturnNilController.self, desc: "019-初始化返回 nil"), at: 0)
        jumpClasss.insert(JumpClass(clazz: Static_ClassController.self, desc: "020-static 和 class"), at: 0)
        
        jumpClasss.insert(JumpClass(clazz: SwiftCollectionController.self, desc: "021-多类型和容器"), at: 0)
        jumpClasss.insert(JumpClass(clazz: DefaultParamController.self, desc: "022-default 参数"), at: 0)
        jumpClasss.insert(JumpClass(clazz: RegularController.self, desc: "023-正则表达式"), at: 0)
        jumpClasss.insert(JumpClass(clazz: DimMatchController.self, desc: "024-模糊匹配"), at: 0)
        jumpClasss.insert(JumpClass(clazz: SectionController.self, desc: "025- ... 和 ..<"), at: 0)
        jumpClasss.insert(JumpClass(clazz: TypeController.self, desc: "026- AnyClass,元类型和.self"), at: 0)
        jumpClasss.insert(JumpClass(clazz: KeySelfController.self, desc: "027- 协议和类方法中的 Self"), at: 0)
        jumpClasss.insert(JumpClass(clazz: DynamicTypeController.self, desc: "028- 动态类型和多方法"), at: 0)
        jumpClasss.insert(JumpClass(clazz: PropertyObserverController.self, desc: "029- 属性观察"), at: 0)
        jumpClasss.insert(JumpClass(clazz: FinalController.self, desc: "030- final"), at: 0)
        
        jumpClasss.insert(JumpClass(clazz: LazyController.self, desc: "031- lazy"), at: 0)
        jumpClasss.insert(JumpClass(clazz: ReflectionController.self, desc: "032- 反射和Mirror"), at: 0)
        jumpClasss.insert(JumpClass(clazz: ImplicitUnpackOptionalController.self, desc: "033- 隐式解包 Optional"), at: 0)
        jumpClasss.insert(JumpClass(clazz: MutilOptionalController.self, desc: "034- 多重 Optional"), at: 0)
        jumpClasss.insert(JumpClass(clazz: OptionalMapController.self, desc: "035- Optional Map"), at: 0)
        jumpClasss.insert(JumpClass(clazz: ProtocolExtensionController.self, desc: "036- protocol Extension"), at: 0)
        jumpClasss.insert(JumpClass(clazz: WhereAndParttenController.self, desc: "037- Where 和 匹配模式"), at: 0)
        jumpClasss.insert(JumpClass(clazz: IndirectEnumController.self, desc: "038- indirect 和 嵌套 enum"), at: 0)
        
        /* -----            OC -> Swift            ------- */
        jumpClasss.insert(JumpClass(clazz: IndirectEnumController.self, desc: "039- Selector"), at: 0)
        jumpClasss.insert(JumpClass(clazz: InstanceMothodDynamicController.self, desc: "040- 实例方法的动态调用"), at: 0)
        
        jumpClasss.insert(JumpClass(clazz: SigletonController.self, desc: "041- 单例"), at: 0)
        jumpClasss.insert(JumpClass(clazz: ConditionalCompilationController.self, desc: "042- 条件编译"), at: 0)
        jumpClasss.insert(JumpClass(clazz: CompilerSignController.self, desc: "043- 编译标记"), at: 0)
        jumpClasss.insert(JumpClass(clazz: UIApplicationMainController.self, desc: "044- @UIApplicationMain"), at: 0)
    }
}



























