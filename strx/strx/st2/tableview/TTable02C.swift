//
//  TTable02C.swift
//  strx
//
//  Created by IOS3 on 2019/3/1.
//  Copyright © 2019 IOS3. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

// 注意：RxDataSources 是以 section 来做为数据结构的。所以不管我们的 tableView 是单分区还是多分区，在使用 RxDataSources 的过程中，都需要返回一个 section 的数组。

class TTable02C: BaseController {
    
    //MARK: properties
    var tableView: UITableView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        initialTableView()
//        test1()
        test2()
    }
    

    func initialTableView() {
        tableView = UITableView(frame: view.frame, style: .plain)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
    }
    
    
    //MARK: 使用RxDataSources自带的section
    func test1() {
        
        // 用户数据
        let items = Observable.just([
            SectionModel(model: "", items: [
                "UILable的用法",
                "UIText的用法",
                "UIButton的用法"
                ])
            ])
        // 数据源
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, String>>(configureCell: { dataSource, tv, ip, element in
            let cell = tv.dequeueReusableCell(withIdentifier: "cell", for: ip)
            cell.textLabel?.text = "\(ip.row): \(element)"
            return cell
        })
        
        // 绑定数据源
        items.bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    
    
    
    //MARK: 使用自定义的Section
    func test2() {
        let sections = Observable.just([
            MySection(header: "基础控件", items: [
                "UILable的用法",
                "UIText的用法",
                "UIButton的用法"
                ]),
            MySection(header: "高级控件", items: [
                "UITableView的用法",
                "UICollectionViews的用法"
                ])
            ])
        
        let dataSource = RxTableViewSectionedAnimatedDataSource<MySection>(
            configureCell: {ds, tv, ip, it in
                let cell = tv.dequeueReusableCell(withIdentifier: "cell", for: ip)
                cell.textLabel?.text = "\(ip.row): \(it)"
                return cell
        },
            titleForHeaderInSection: { ds, idx in
                return ds.sectionModels[idx].header
        })
        
        sections.bind(to: tableView.rx.items(dataSource: dataSource))
        .disposed(by: disposeBag)
    }

}



fileprivate struct MySection {
    var header: String
    var items: [Item]
}
extension MySection: AnimatableSectionModelType {
    init(original: MySection, items: [String]) {
        self = original
        self.items = items
    }
    
    typealias Item = String
    var identity: String {
        return header
    }
}
