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
    fileprivate var datas: [SectionDesc] = {
       let arr = [
        SectionDesc(cells: [
            CellDesc(clz: TFInfunc01Controller.self, title: "Battleship案例", subTitle: ""),
            CellDesc(clz: TFInfunc02Controller.self, title: "封装 Core Image 案例", subTitle: ""),
            CellDesc(clz: TFInfunc03Controller.self, title: "理论背景: 柯里化", subTitle: ""),
            ], title: "函数式思想"),
        SectionDesc(cells: [
            CellDesc(clz: TFAboutTController.self, title: "map filter reduce <T>", subTitle: ""),
            ], title: "Map Filter Reduce"),
        SectionDesc(cells: [
            CellDesc(clz: TFOptionaltController.self, title: "可选值", subTitle: ""),
            ], title: "可选值"),
        SectionDesc(cells: [
            CellDesc(clz: TFQCController.self, title: "Quick Check", subTitle: ""),
            ], title: ""),
        SectionDesc(cells: [
            CellDesc(clz: TFTSearchController.self, title: "二叉树搜索案例", subTitle: ""),
            CellDesc(clz: CompleDicController.self, title: "基于字典树的自动补全 案例", subTitle: ""),
            ], title: "纯函数式数据结构"),
        SectionDesc(cells: [
            CellDesc(clz: TFChartController.self, title: "图表案例", subTitle: ""),
            ], title: "图表案例"),
        SectionDesc(cells: [
            CellDesc(clz: TFIteratorController.self, title: "迭代器", subTitle: ""),
            ], title: "迭代器和序列"),
        SectionDesc(cells: [
            CellDesc(clz: TFTest001Controller.self, title: "解析器组合算子", subTitle: ""),
            ], title: "案例, 案例"),
        SectionDesc(cells: [
            CellDesc(clz: TFLensController.self, title: "Lens(透镜)原理与应用", subTitle: ""),
            ], title: "其他案例"),
        ]
        return arr
    }()
    
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
