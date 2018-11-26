//
//  ChangeStyleController.swift
//  strx
//
//  Created by IOS3 on 2018/11/22.
//  Copyright © 2018 IOS3. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources


fileprivate struct MySection {
    var header: String
    var items: [Item]
}
extension MySection: AnimatableSectionModelType {
    typealias Item = String
    var identity: String {
        return header
    }
    
    init(original: MySection, items: [Item]) {
        self = original
        self.items = items
    }
}

class ChangeStyleController: BaseController {

    
    func test1() {
        
        let tableView = UITableView(frame: CGRect(x: 0, y: 88, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), style: .plain)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView)
        tableView.setEditing(true, animated: true)
        
        
        let sections = Observable.of([
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
        
        let datasource = RxTableViewSectionedAnimatedDataSource<MySection>(
            configureCell: { ds, tv, ip, it in
                let cell = tv.dequeueReusableCell(withIdentifier: "Cell", for: ip)
                cell.textLabel?.text = "\(ip.row): \(it)"
                return cell
            },
            titleForHeaderInSection: { ds, idx in
                return ds.sectionModels[idx].header
            }
        )
        
        sections.bind(to: tableView.rx.items(dataSource: datasource)).disposed(by: disposeBag)
     
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        test1()
        
    }
    

    

}

extension ChangeStyleController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
