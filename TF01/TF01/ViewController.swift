//
//  ViewController.swift
//  TF01
//
//  Created by IOS3 on 2018/12/17.
//  Copyright © 2018 IOS3. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    fileprivate var datas: [SectionDesc]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "HomeCell")
    }


}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath)
        let section = datas[indexPath.section]
        let cellDesc = section.cells[indexPath.row]
        cell.textLabel?.text = cellDesc.title
        cell.detailTextLabel?.text = cellDesc.subTitle
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = datas[section]
        return section.cells.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return datas.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = datas[section]
        return section.title
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = datas[indexPath.section]
        let cellDesc = section.cells[indexPath.row]
        let vc = cellDesc.clz.init()
        navigationController?.pushViewController(vc, animated: true)
    }
}



fileprivate struct CellDesc {
    let clz: UIViewController.Type
    let title: String
    let subTitle: String
}
fileprivate struct SectionDesc {
    let cells: [CellDesc]
    let title: String
}
