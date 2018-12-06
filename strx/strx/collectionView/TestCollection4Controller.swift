//
//  TestCollection4Controller.swift
//  strx
//
//  Created by IOS3 on 2018/12/6.
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

class TestCollection4Controller: BaseController {
    
    var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 100, height: 70)
        //        flowLayout.headerReferenceSize = CGSize(width: view.frame.width, height: 70)
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .white
        collectionView.register(TestCell.self, forCellWithReuseIdentifier: "cell")
        
        view.addSubview(collectionView)
        
        let items = Observable.just([
            SectionModel(model: "", items: [
                "Swift",
                "PHP",
                "Python",
                "Java",
                "C++",
                "C#"
                ])
            ])
        
        let datasource = RxCollectionViewSectionedReloadDataSource<SectionModel<String, String>>(
        configureCell: { ds, cv, ip, it in
            let cell = cv.dequeueReusableCell(withReuseIdentifier: "cell", for: ip)
            if let cell = cell as? TestCell {
                cell.label.text = it
            }
            return cell
        })
        items.bind(to: collectionView.rx.items(dataSource: datasource))
            .disposed(by: disposeBag)
        
        // 设置  Rx Delegate
//        collectionView.rx.setDelegate(self as! UIScrollViewDelegate)

        // collectionView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    



}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let cellWidth = (width - 30) / 4
        return CGSize(width: cellWidth, height: cellWidth * 1.5)
    }
}
