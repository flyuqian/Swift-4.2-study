//
//  MoreCellStyleController.swift
//  strx
//
//  Created by IOS3 on 2018/11/22.
//  Copyright © 2018 IOS3. All rights reserved.
//
// titleSwitchCell    titleImageCell
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources


// 单元格类型
fileprivate enum SectionItem {
    case TitleImageSectionItem(title: String, image: UIImage)
    case TitleSwitchSectionItem(title: String, enabled: Bool)
}
// 自定义Section
fileprivate struct MySection {
    var header: String
    var items: [SectionItem]
}

extension MySection: SectionModelType {
    typealias Item = SectionItem
    
    init(original: MySection, items: [Item]) {
        self = original
        self.items = items
    }

}

class MoreCellStyleController: BaseController {
    
    
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "titleSwitchCell")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "titleImageCell")
        
        
        //初始化数据
        let sections = Observable.just([
            MySection(header: "我是第一个分区", items: [
                .TitleImageSectionItem(title: "图片数据1", image: UIImage(named: "php")!),
                .TitleImageSectionItem(title: "图片数据2", image: UIImage(named: "react")!),
                .TitleSwitchSectionItem(title: "开关数据1", enabled: true)
                ]),
            MySection(header: "我是第二个分区", items: [
                .TitleSwitchSectionItem(title: "开关数据2", enabled: false),
                .TitleSwitchSectionItem(title: "开关数据3", enabled: false),
                .TitleImageSectionItem(title: "图片数据3", image: UIImage(named: "Swift")!)
                ])
            ])
        
        let datasource = RxTableViewSectionedReloadDataSource<MySection>(
            configureCell: { ds, tv, ip, it in
                switch ds[ip] {
                    
                case .TitleImageSectionItem(let title, let image):
                    
                    if let cell = tv.dequeueReusableCell(withIdentifier: "titleImageCell") {
                        (cell.viewWithTag(1) as! UILabel).text = title
                        (cell.viewWithTag(2) as! UIImageView).image = image
                        return cell
                    }
                    return UITableViewCell()
                case .TitleSwitchSectionItem(let title, let enabled):
                    if let cell = tv.dequeueReusableCell(withIdentifier: "titleSwitchCell") {
                        (cell.viewWithTag(1) as! UILabel).text = title
                        (cell.viewWithTag(2) as! UISwitch).isEnabled = enabled
                        return cell
                    }
                    
                    
                    return UITableViewCell()
                }
        },
            titleForHeaderInSection: { ds, idx in
                return ds.sectionModels[idx].header
        })
        
        sections.bind(to: tableView.rx.items(dataSource: datasource))
            .disposed(by: disposeBag)
        
    }


    

}
