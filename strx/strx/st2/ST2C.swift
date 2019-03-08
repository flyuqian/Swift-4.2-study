//
//  ST2C.swift
//  strx
//
//  Created by IOS3 on 2019/3/1.
//  Copyright © 2019 IOS3. All rights reserved.
//

import UIKit


fileprivate struct ST2CJump {
    var title: String
    var jump: ST2CJumpClass
}
fileprivate enum ST2CJumpClass {
    case typeClass(clz: UIViewController.Type)
    case typeSB(sb: String, vc: String)
}


extension ST2C {
    func initialCellModels() {
        cellModels.append(ST2CJump(title: "tableView 的使用1", jump: .typeClass(clz: TTable01C.self)))
        cellModels.append(ST2CJump(title: "tableView 的使用2, RxDataSource",
                                   jump: .typeClass(clz: TTable02C.self)))
        cellModels.append(ST2CJump(title: "tableView 的使用3, 刷新数据",
                                   jump: .typeClass(clz: TTBReloadC.self)))
        cellModels.append(ST2CJump(title: "tableView 的使用3, 可编辑表格",
                                   jump: .typeClass(clz: TTBEditC.self)))
        cellModels.append(ST2CJump(title: "PromiseKit 01",
                                   jump: .typeClass(clz: TPromiseC.self)))
    }
}

class ST2C: BaseController {
    
    fileprivate var cellModels = [ST2CJump]()
    fileprivate var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialCellModels()
        self.title = "练习 hangge.com 的Rx"
        self.initTableView()
    }
    
    func initTableView() {
        tableView = UITableView(frame: view.frame, style: .plain)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ST2C_cell")
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
    }
    

}


extension ST2C: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = cellModels[indexPath.row];
        switch model.jump {
        case .typeClass(let vc):
            let jump = vc.init()
            jump.title = model.title
            navigationController?.pushViewController(jump, animated: true)
            
        case .typeSB(let sbName, let vcName):
            let sb = UIStoryboard(name: sbName, bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: vcName)
            vc.title = model.title
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellModels.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ST2C_cell", for: indexPath)
        cell.textLabel?.text = cellModels[indexPath.row].title
        return cell
    }
}
