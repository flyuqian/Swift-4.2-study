//
//  ViewController.swift
//  SwiftAdvance
//
//  Created by 解向前 on 2018/9/26.
//  Copyright © 2018 com.test. All rights reserved.
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
        
        
        jumpClasss.append(JumpClass(clazz: TArrayController.self, desc: "集合类型 - 数组"))
        jumpClasss.append(JumpClass(clazz: TDictC.self, desc: "集合类型 - 字典"))
        
        jumpClasss.append(JumpClass(clazz: TReloadC.self, desc: "泛型 - 重载"))
        jumpClasss.append(JumpClass(clazz: CollectionUseTC.self, desc: "泛型 - 对集合采用泛型操作"))
        jumpClasss.append(JumpClass(clazz: DesignUseTC.self, desc: "泛型 - 使用泛型进行代码设计"))
        
        jumpClasss.append(JumpClass(clazz: Protocol1C.self, desc: "协议 - 面向协议编程"))
        jumpClasss.append(JumpClass(clazz: ProtocolTypeC.self, desc: "协议 - 协议的两种类型"))
        
    }
}
