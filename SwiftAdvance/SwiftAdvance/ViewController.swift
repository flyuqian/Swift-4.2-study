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
        
        
        jumpClasss.append(JumpClass(clazz: CloureAndMemryController.self, desc: "04 类和结构体 - 02 闭包的可变性和内存 "))
        jumpClasss.append(JumpClass(clazz: StructAndClassController.self, desc: "04 类和结构体 - 01 值语义 - 结构体"))
        
        
        jumpClasss.append(JumpClass(clazz: OptionalValueController.self, desc: "03 可选值 - 01 可选值"))
        
        
        jumpClasss.append(JumpClass(clazz: CollectionTypeController.self, desc: "02 集合类型协议 - 02 集合类型"))
        jumpClasss.append(JumpClass(clazz: AboutSequenceController.self, desc: "02 集合类型协议 - 01 序列"))
        
        jumpClasss.append(JumpClass(clazz: ShowArray2ViewController.self, desc: "01 - 02 数组切片/集合/字典/range"))
        jumpClasss.append(JumpClass(clazz: ShowArrayController.self, desc: "01 - 01 数组 和高阶函数讲解"))
    }
}
