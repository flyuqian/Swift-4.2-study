//
//  TestCollection2Controller.swift
//  strx
//
//  Created by IOS3 on 2018/12/5.
//  Copyright © 2018 IOS3. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources


fileprivate class TestCell: UICollectionViewCell {
    var label:UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //背景设为橙色
        self.backgroundColor = UIColor.orange
        
        //创建文本标签
        label = UILabel(frame: frame)
        label.textColor = UIColor.white
        label.textAlignment = .center
        self.contentView.addSubview(label)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = bounds
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

fileprivate class MySectionHeader: UICollectionReusableView {
    var label:UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //背景设为黑色
        self.backgroundColor = UIColor.black
        
        //创建文本标签
        label = UILabel(frame: frame)
        label.textColor = UIColor.white
        label.textAlignment = .center
        self.addSubview(label)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = bounds
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

fileprivate struct MySection {
    var header: String
    var items: [Item]
}

extension MySection: AnimatableSectionModelType {
    typealias Item = String
    var identity: String {
        return header
    }
    init(original: MySection, items: [MySection.Item]) {
        self = original
        self.items = items
    }
}

class TestCollection2Controller: BaseController {

    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 100, height: 70)
        flowLayout.headerReferenceSize = CGSize(width: view.frame.width, height: 70)
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .white
        collectionView.register(TestCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(MySectionHeader.self, forSupplementaryViewOfKind:UICollectionView.elementKindSectionHeader , withReuseIdentifier: "header")
        view.addSubview(collectionView)
        
        let items = Observable.just([
                SectionModel(model: "脚本语言", items: [
                    "Python",
                    "javascript",
                    "PHP",
                    ]),
                SectionModel(model: "高级语言", items: [
                    "Swift",
                    "C++",
                    "Java",
                    "C#"
                    ])
            ])
        let datasource = RxCollectionViewSectionedReloadDataSource<SectionModel<String, String>>(
            configureCell: { ds, cv, ip, item in
                let cell = cv.dequeueReusableCell(withReuseIdentifier: "cell", for: ip)
                if let cell = cell as? TestCell {
                    cell.label.text = item
                }
                return cell
        },
            configureSupplementaryView: {
                ds, cv, kind, ip in
                let section = cv.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: ip)
                if let section = section as? MySectionHeader {
                    section.label.text = ds[ip.section].model
                }
                return section
        })
        items.bind(to: collectionView.rx.items(dataSource: datasource))
            .disposed(by: disposeBag)
    }
    
    
    
    
    // 自定义 SectionModel
    func testMySection() {
        // 初始化数据
        let section = Observable.just([
            MySection(header: "", items: [
                "Swift",
                "PHP",
                "Python",
                "Java",
                "javascript",
                "C#"
                ])
            ])
        let dataSource = RxCollectionViewSectionedReloadDataSource<MySection>(
            configureCell: {ds, cv, ip, item in
                let cell = cv.dequeueReusableCell(withReuseIdentifier: "cell", for: ip)
                if let cell = cell as? TestCell {
                    cell.label.text = item
                }
                return cell
        })
        
        section.bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    

    
    
    // 使用RxDataSourcer 默认的 SectionModel
    func testSectionModel() {
        // 初始化数据
        let items = Observable.just([
            SectionModel(model: "", items: [
                "Swift",
                "PHP",
                "Python",
                "Java",
                "javascript",
                "C#"
                ])
            ])
        let dataSource = RxCollectionViewSectionedReloadDataSource<SectionModel<String, String>>(
            configureCell: {ds, cv, ip, element in
                let cell = cv.dequeueReusableCell(withReuseIdentifier: "cell", for: ip)
                if let cell = cell as? TestCell {
                    cell.label.text = element
                }
                return cell
        })
        
        items.bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    
}
