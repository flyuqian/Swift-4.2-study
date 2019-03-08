//
//  TTBReloadC.swift
//  strx
//
//  Created by IOS3 on 2019/3/4.
//  Copyright © 2019 IOS3. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class TTBReloadC: BaseController {
    
    var tableView: UITableView!
    var reloadItem: UIBarButtonItem!
    var stopItem: UIBarButtonItem!
    var searchBar: UISearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        func initialTableView() {
            tableView = UITableView(frame: view.frame, style: .plain)
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
            view.addSubview(tableView)
        }
        
        func initialNavigation() {
            stopItem = UIBarButtonItem(title: "停止", style: .plain, target: self, action: nil)
            reloadItem = UIBarButtonItem(title: "刷新", style: .plain, target: self, action:nil)
            self.navigationItem.rightBarButtonItems = [stopItem, reloadItem];
        }
        func addSearchBar() {
            searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 56))
            tableView.tableHeaderView = searchBar
        }
        
        func getRandomResult() -> Observable<[SectionModel<String, Int>]> {
            print("正在请求数据")
            let items = (0..<7).map { _ in
                Int(arc4random())
            }
            let observable = Observable.just([SectionModel(model: "S", items: items)])
            return observable.delay(2, scheduler: MainScheduler.instance)
        }
        
        func filterResult(data: [SectionModel<String, Int>]) -> Observable<[SectionModel<String, Int>]> {
            return searchBar.rx.text.orEmpty
                .flatMapLatest {
                    query -> Observable<[SectionModel<String, Int>]> in
                    print("正在筛选数据, 条件: \(query)")
                    if query.isEmpty {
                        return Observable.just(data)
                    }
                    else {
                        var new: [SectionModel<String, Int>] = []
                        for sectionModel in data {
                            let items = sectionModel.items.filter{ "\($0)".contains(query)}
                            new.append(SectionModel(model: sectionModel.model, items: items))
                        }
                        return Observable.just(new)
                    }
            }
        }
        
        func test1() {
            let randomResult = reloadItem.rx.tap.asObservable()
                .throttle(1, scheduler: MainScheduler.instance)
                .startWith(())
                // .flatMapLatest(getRandomResult)
                .flatMapLatest { [weak self] in
                    getRandomResult().takeUntil(self!.stopItem.rx.tap)
                }
                .flatMap(filterResult)
                .share(replay: 1)
            let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, Int>>(configureCell: {ds, tv, ip, elem in
                let cell = tv.dequeueReusableCell(withIdentifier: "cell", for: ip)
                cell.textLabel?.text = "条目\(ip.row): \(elem)"
                return cell
            })
            randomResult.bind(to: tableView.rx.items(dataSource: dataSource))
                .disposed(by: disposeBag)
        }
        
        initialTableView()
        initialNavigation()
        addSearchBar()
        test1()
    }
    
    
}

