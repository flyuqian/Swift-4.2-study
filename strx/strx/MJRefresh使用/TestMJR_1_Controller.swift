//
//  TestMJR_1_Controller.swift
//  strx
//
//  Created by IOS3 on 2018/12/12.
//  Copyright © 2018 IOS3. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


class TestMJR_1_Controller: BaseController {
    
    var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView = UITableView(frame: view.frame, style: .plain)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        tableView.mj_header = MJRefreshNormalHeader()

        let viewModel = ViewModel(headerRefresh: tableView.mj_header.rx.refreshing.asDriver())
        
        viewModel.tableData.asDriver()
            .drive(tableView.rx.items) { tv, row, it in
                var cell = tv.dequeueReusableCell(withIdentifier: "cell")
                if cell == nil {
                    cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
                }
                cell?.textLabel?.text = "\(row + 1) - \(it)"
                return cell!
            }.disposed(by: disposeBag)
        
        viewModel.endHeaderRefreshing
            .drive(tableView.mj_header.rx.endRefreshing)
            .disposed(by: disposeBag)
        
    }
    

}


//    将下拉、上拉的刷新事件转为 ControlEvent 类型的可观察序列。
//    增加一个用于停止刷新的绑定属性。
fileprivate extension Reactive where Base: MJRefreshComponent {
    var refreshing: ControlEvent<Void> {
        let source: Observable<Void> = Observable.create {
            [weak control = self.base] observer in
            if let control = control {
                control.refreshingBlock = {
                    observer.on(.next(()))
                }
            }
            return Disposables.create()
        }
        return ControlEvent(events: source)
    }
    
    var endRefreshing: Binder<Bool> {
        return Binder(base) { refresh, isEnd in
            if isEnd {
                refresh.endRefreshing()
            }
        }
    }
    
}


// 网络请求服务
fileprivate class NetworkService {
    func getRandomResult() -> Driver<[String]> {
        print("z正在请求数据...")
        let items = (0 ..< 15).map { _ in "随机数据\(Int(arc4random()))" }
        let observable = Observable.just(items)
        return observable
            .delay(1, scheduler: MainScheduler.instance)
            .asDriver(onErrorDriveWith: Driver.empty())
    }
}


// ViewModel
fileprivate class ViewModel {
    
    let tableData: Driver<[String]>
    let endHeaderRefreshing: Driver<Bool>
    init(headerRefresh: Driver<Void>) {
        let networkService = NetworkService()
        self.tableData = headerRefresh
            .startWith(())
            .flatMapLatest { _ in networkService.getRandomResult() }
        self.endHeaderRefreshing = self.tableData.map { _ in true }
    }
}
