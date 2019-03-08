//
//  TTable01C.swift
//  strx
//
//  Created by IOS3 on 2019/3/1.
//  Copyright © 2019 IOS3. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


class TTable01C: BaseController {

    
    //MARK: properties
    var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialTableView()
        test1()
    }
    
    func initialTableView() {
        tableView = UITableView(frame: view.frame, style: .plain)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
    }
    
    
    func test1() {
        let items = Observable.just([
            "文本输入框的用法",
            "开关按钮的用法",
            "进度条的用法",
            "文本标签的用法",
            ])
        items.bind(to: tableView.rx.items){ tv, row, ele in
            let cell = tv.dequeueReusableCell(withIdentifier: "cell")
            cell?.textLabel?.text = "\(row): \(ele)"
            return cell ?? UITableViewCell()
        }.disposed(by: disposeBag)
        
      
        tableView.rx.itemSelected.subscribe(onNext:{ ip in
            print("选中的 indexPath: \(ip)")
        }).disposed(by: disposeBag)
        Observable.zip(tableView.rx.itemSelected, tableView.rx.modelSelected(String.self))
            .bind{ ip, it in
                print("选中的 indexPath: \(ip), title: \(it)")
        }.disposed(by: disposeBag)
    }

}
