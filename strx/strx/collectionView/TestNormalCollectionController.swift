//
//  TestNormalCollectionController.swift
//  strx
//
//  Created by IOS3 on 2018/11/22.
//  Copyright © 2018 IOS3. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


fileprivate class MyCell: UICollectionViewCell {
    var label: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .orange
        
        label = UILabel(frame: frame)
        label.textAlignment = .center
        contentView.addSubview(label)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = bounds
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class TestNormalCollectionController: BaseController {

    
    var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        UICollectionView.elementKindSectionFooter
//        collectionView.register(nil, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "")
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 70)
        
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.register(MyCell.self, forCellWithReuseIdentifier: "Cell")
        view.addSubview(collectionView)
        
        let items = Observable.of([
            "Swift",
            "PHP",
            "Ruby",
            "Java",
            "C++",
            ])
        items
            .bind(to: collectionView.rx.items) {
                cv, row, it in
                let ip = IndexPath(row: row, section: 0)
                let cell = cv.dequeueReusableCell(withReuseIdentifier: "Cell", for: ip) as! MyCell
                cell.label.text = "\(row): \(it)"
                return cell
        }
        .disposed(by: disposeBag)
        
        
        
        
//        collectionView.rx.itemSelected
//        collectionView.rx.modelSelected
//        itemDeselected
//        modelDeselected
//        itemHighlighted
//        itemUnhighlighted
//        willDisplayCell
//        willDisplaySupplementaryView
        
    }
    

    

}
