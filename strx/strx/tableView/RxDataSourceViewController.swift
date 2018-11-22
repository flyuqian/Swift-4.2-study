//
//  RxDataSourceViewController.swift
//  strx
//
//  Created by IOS3 on 2018/11/21.
//  Copyright © 2018 IOS3. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class RxDataSourceViewController: BaseController {

    
    // 对于 结构简单的 tableView 使用RxSwift自带的绑定完成
    // 而 对于需要显示多个 section 或者 增加更复杂的编辑功能时, 可是使用 RxDataSource
    // RxDataSources 是以 section 来做为数据结构的。所以不管我们的 tableView 是单分区还是多分区，在使用 RxDataSources 的过程中，都需要返回一个 section 的数组。
    
    func test1() {
        
        let tableView = UITableView(frame: CGRect(x: 0, y: 88, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), style: .plain)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView)
        
        let items = Observable.just([
            SectionModel(model: "", items: [
                "文本输入框的用法",
                "开关按钮的用法",
                "进度条的用法",
                "文本标签的用法",
                ])
            ])
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, String>>(configureCell: { (dataSource, tableView, indexPath, element) -> UITableViewCell in
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            cell.textLabel?.text = "\(indexPath.row)：\(element)"
            return cell
        })
        
        items
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    
    
    
    //MARK: 自定义Section
    func test2() {
        
        struct MySection: AnimatableSectionModelType {
            typealias Item = String
            var header: String
            var items: [Item]
            var identity: String {
                return header
            }
            init(original: MySection, items: [Item]) {
                self = original
                self.items = items
            }
            init(header: String, items: [Item]) {
                self.header = header
                self.items = items
            }
        }
        
        let tableView = UITableView(frame: CGRect(x: 0, y: 88, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), style: .plain)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView)
        
        let sections = Observable.just([
            MySection(header: "基本控件", items: [
                "文本输入框的用法",
                "开关按钮的用法",
                "进度条的用法",
                "文本标签的用法",
                ]),
            MySection(header: "高级控件", items: [
                "高级控件1",
                "高级控件2",
                "高级控件3",
                ])
            ])
        let datasource = RxTableViewSectionedAnimatedDataSource<MySection>(configureCell: { ds, tv, ip, item in
            let cell = tv.dequeueReusableCell(withIdentifier: "Cell", for: ip)
            cell.textLabel?.text = item
            return cell
        })
        datasource.titleForHeaderInSection = { ds, idx -> String in
            return ds.sectionModels[idx].header
        }
        sections.bind(to: tableView.rx.items(dataSource: datasource)).disposed(by: disposeBag)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        test1()
        test2()
        
        
    }
    

    

}
