//
//  HomeController.swift
//  strx
//
//  Created by IOS3 on 2018/11/12.
//  Copyright © 2018 IOS3. All rights reserved.
//

import UIKit



fileprivate struct JumpClassModel {
    let clzType: UIViewController.Type
    let title: String
    let subTitle: String
}
fileprivate struct SectionModel {
    let headerTitle: String
    let footerTitle: String
    let jumpClzs: [JumpClassModel]
}


class HomeController: UITableViewController {

    
    fileprivate var cellModels = [SectionModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialCellModels()
        
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "homecellid")
    }

    

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return cellModels.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return cellModels[section].jumpClzs.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let title = cellModels[section].headerTitle
        if title.count > 0 {
            return title
        }
        return nil
    }
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        let title = cellModels[section].footerTitle
        if title.count > 0 {
            return title
        }
        return nil
    }
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let jc = cellModels[indexPath.section].jumpClzs[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "homecellid", for:
            indexPath)
        cell.textLabel?.text = jc.title
        cell.detailTextLabel?.text = jc.subTitle

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let jc = cellModels[indexPath.section].jumpClzs[indexPath.row]
        let vc = jc.clzType.init()
        navigationController?.pushViewController(vc, animated: true)
    }
}



extension HomeController {
    func initialCellModels() {
        cellModels = [
            SectionModel(headerTitle: "初识 RxSwfit", footerTitle: "", jumpClzs: [
                JumpClassModel(clzType: WellComeRxController.self, title: "响应式编程与传统编程比较", subTitle: ""),
                ]),
            SectionModel(headerTitle: "RxSwfit 元素介绍", footerTitle: "", jumpClzs: [
                JumpClassModel(clzType: ObservableController.self, title: "Observable", subTitle: "Observable 介绍, 创建可观察序列"),
                ]),
        ]
    }
}
