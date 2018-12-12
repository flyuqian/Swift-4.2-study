//
//  TestMJR_2_Controller.swift
//  strx
//
//  Created by IOS3 on 2018/12/12.
//  Copyright © 2018 IOS3. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


class TestMJR_2_Controller: BaseController {
    
    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView(frame: view.frame, style: .plain)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        tableView.mj_header = MJRefreshNormalHeader()
        tableView.mj_footer = MJRefreshAutoNormalFooter()
        
        let viewModel = ViewModel(input: (
            headerRefresh: tableView.mj_header.rx.refreshing.asDriver(),
            footerRefresh: tableView.mj_footer.rx.refreshing.asDriver()
            ), dependency: (
                disposeBag: disposeBag,
                networkService: NetworkService()
            ))
        
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
        viewModel.endFooterRefreshing
            .drive(tableView.mj_footer.rx.endRefreshing)
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
    
    let tableData = BehaviorRelay<[String]>(value: [])
    let endHeaderRefreshing: Driver<Bool>
    let endFooterRefreshing: Driver<Bool>
    
    init(input: (headerRefresh: Driver<Void>, footerRefresh: Driver<Void>),
         dependency: (disposeBag: DisposeBag, networkService: NetworkService)) {
        
        let headerRefreshData = input.headerRefresh.debug()
            .startWith(())
            .flatMapLatest { return dependency.networkService.getRandomResult() }
        
        let footerRefreshData = input.footerRefresh
            .flatMapLatest { return dependency.networkService.getRandomResult() }
        
        self.endHeaderRefreshing = headerRefreshData.map { _ in true }
        self.endFooterRefreshing = footerRefreshData.map { _ in true }
        
        headerRefreshData.drive(onNext: { items in
            self.tableData.accept(items)
        }).disposed(by: dependency.disposeBag)
        
        footerRefreshData.drive(onNext: { items in
            self.tableData.accept(self.tableData.value + items)
        }).disposed(by: dependency.disposeBag)
    }
}
