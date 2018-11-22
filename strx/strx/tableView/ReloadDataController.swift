//
//  ReloadDataController.swift
//  strx
//
//  Created by IOS3 on 2018/11/21.
//  Copyright © 2018 IOS3. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources


class ReloadDataController: BaseController {
    
    
    
    func test1() {
        /*** 效果
         （1）界面初始化完毕后，tableView 默认会加载一些随机数据。
         （2）点击右上角的刷新按钮，tableView 会重新加载并显示一批新数据。
         （3）为方便演示，每次获取数据不是真的去发起网络请求。而是在本地生成后延迟 2 秒返回，模拟这种异步请求的情况。
         */
        
        func getRandomResult() -> Observable<[SectionModel<String, Int>]> {
            print("正在请求数据...")
            let items = (0..<5).map {_ in
                Int(arc4random())
            }
            let observable = Observable.just([SectionModel(model: "s", items: items)])
            return observable.delay(2, scheduler: MainScheduler.instance)
        }
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        btn.setTitle("刷新", for: .normal)
        btn.setTitleColor(.blue, for: .normal)
        let stopBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        stopBtn.setTitle("停止", for: .normal)
        stopBtn.setTitleColor(.blue, for: .normal)
        self.navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: stopBtn), UIBarButtonItem(customView: btn)]
        
        let randomResult = btn.rx.tap.asObservable()
            .throttle(1, scheduler: MainScheduler.instance) // 在主线程中操作, 1s内值若多次改变, 取最后一个值
            .startWith(())  //一开始就请求一次数据
            // .flatMapLatest(getRandomResult) // 连续请求时, 只取最后一次数据
            .flatMapLatest { getRandomResult().takeUntil(stopBtn.rx.tap) } //点击停止按钮, 停止对请求结果的接收
            .share(replay: 1, scope: SubjectLifetimeScope.forever)
        
        
        
        
        
        let tableView = UITableView(frame: CGRect(x: 0, y: 88, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), style: .plain)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView)
        
        
        let datasource = RxTableViewSectionedReloadDataSource<SectionModel<String, Int>>(configureCell: {
            ds, tv, ip, item in
            let cell = tv.dequeueReusableCell(withIdentifier: "Cell", for: ip)
            cell.textLabel?.text = "条目\(ip.row): \(item)"
            return cell
        })
        
        randomResult.bind(to: tableView.rx.items(dataSource: datasource))
            .disposed(by: disposeBag)
        
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        test1()
        
    }
    

    

}
