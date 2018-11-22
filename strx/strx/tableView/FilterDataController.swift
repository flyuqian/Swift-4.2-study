//
//  FilterDataController.swift
//  strx
//
//  Created by IOS3 on 2018/11/22.
//  Copyright © 2018 IOS3. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources


class FilterDataController: BaseController {
    
    
    
    func testFilter() {
        
        let tableView = UITableView(frame: CGRect(x: 0, y: 88, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), style: .plain)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView)
        
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        btn.setTitle("刷新", for: .normal)
        btn.setTitleColor(.blue, for: .normal)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: btn)
        
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 56))
        tableView.tableHeaderView = searchBar
        
        // 请求数据
        func getRandomResult() -> Observable<[SectionModel<String, Int>]> {
            print("正在请求数据...")
            let items = (0..<5).map {_ in
                Int(arc4random())
            }
            let observable = Observable.just([SectionModel(model: "s", items: items)])
            return observable.delay(2, scheduler: MainScheduler.instance)
        }
        
        // 过滤数据
        func filterResult(data: [SectionModel<String, Int>]) -> Observable<[SectionModel<String, Int>]> {
            return searchBar.rx.text.orEmpty
                .debounce(0.5, scheduler: MainScheduler.instance)
                .flatMapLatest { query -> Observable<[SectionModel<String, Int>]> in
                    print("正在筛选数据 条件为: \(query)")
                    if query.isEmpty {
                        return Observable.just(data)
                    }
                    else {
                        var newData: [SectionModel<String, Int>] = []
                        for sectionModel in data {
                            let items = sectionModel.items.filter{ "\($0)".contains(query) }
                            newData.append(SectionModel(model: sectionModel.model, items: items))
                        }
                        return Observable.just(newData)
                    }
            }
        }
        
        
        
        let randomResult = btn.rx.tap.asObservable()
            .startWith(())
            .flatMapLatest(getRandomResult)
            .flatMap(filterResult)
            .share(replay: 1, scope: SubjectLifetimeScope.forever)
        let datasource = RxTableViewSectionedReloadDataSource<SectionModel<String, Int>>(configureCell: {
            ds, tv, ip, element in
            let cell = tv.dequeueReusableCell(withIdentifier: "Cell", for: ip)
            cell.textLabel?.text = "条目\(ip.row)：\(element)"
            return cell
        })
        randomResult.bind(to: tableView.rx.items(dataSource: datasource))
            .disposed(by: disposeBag)
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        testFilter()
    }
    

   

}
