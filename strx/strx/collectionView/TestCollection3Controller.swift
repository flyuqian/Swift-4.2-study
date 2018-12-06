//
//  TestCollection3Controller.swift
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

class TestCollection3Controller: BaseController {

    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 100, height: 70)
//        flowLayout.headerReferenceSize = CGSize(width: view.frame.width, height: 70)
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .white
        collectionView.register(TestCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(MySectionHeader.self, forSupplementaryViewOfKind:UICollectionView.elementKindSectionHeader , withReuseIdentifier: "header")
        view.addSubview(collectionView)
        
        let btn = UIButton()
        btn.setTitle("刷新", for: .normal);
        btn.setTitleColor(.darkGray, for: .normal)
        
        let btn2 = UIButton()
        btn2.setTitle("停止", for: .normal);
        btn2.setTitleColor(.darkGray, for: .normal)
        
        navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: btn2), UIBarButtonItem(customView: btn)]
        
        let randomResult = btn.rx.tap.asObservable()
            .throttle(1, scheduler: MainScheduler.instance) // 在1s内若值多次改变, 取最后一次
            .startWith(()) // 开始 自动请求数据
            .flatMapLatest {
                self.getRandomResult().takeUntil(btn2.rx.tap)
            }
            // .flatMapLatest(getRandomResult)
            .share(replay: 1, scope: .forever)
        
        let datasource = RxCollectionViewSectionedReloadDataSource<SectionModel<String, Int>>(
            configureCell: { ds, cv, ip, it in
                let cell = cv.dequeueReusableCell(withReuseIdentifier: "cell", for: ip)
                if let cell = cell as? TestCell {
                    cell.label.text = "\(it)"
                }
                return cell
        })
        
        randomResult.bind(to: collectionView.rx.items(dataSource: datasource)).disposed(by: disposeBag)
        
    }
    

    
    
    // 获取随机数据
    func getRandomResult() -> Observable<[SectionModel<String, Int>]> {
        print("正在请求数据 ...")
        let items = (0...5).map {
            _ in
            Int(arc4random_uniform(100000))
        }
        let observable = Observable.just([SectionModel(model: "S", items: items)])
        return observable.delay(2, scheduler: MainScheduler.instance)
    }

}
