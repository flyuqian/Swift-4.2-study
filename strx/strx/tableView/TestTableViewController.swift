//
//  TestTableViewController.swift
//  strx
//
//  Created by IOS3 on 2018/11/21.
//  Copyright © 2018 IOS3. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TestTableViewController: BaseController {
    
    
    
    func test1() {
        let tableView = UITableView(frame: CGRect(x: 0, y: 88, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), style: .plain)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView)
        
        let items = Observable.just([
            "文本输入框的用法",
            "开关按钮的用法",
            "进度条的用法",
            "文本标签的用法",
            ])
        
        items.bind(to: tableView.rx.items){
            tableView, row, element in
            if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") {
                cell.textLabel?.text = "\(row): \(element)"
                return cell
            }
            return UITableViewCell()
        }.disposed(by: disposeBag)
        
        // tableView cell 选中
        tableView.rx.itemSelected.subscribe(onNext: {
            indexPath in
            print("选中的 indexPath为: \(indexPath)")
        }).disposed(by: disposeBag)
        
        // tableView model 选中
        tableView.rx.modelSelected(String.self).subscribe(onNext: { item in
            print("选中的标题为: \(item)")
        }).disposed(by: disposeBag)
     
        // tableView 单元格相应
        Observable.zip(tableView.rx.itemSelected, tableView.rx.modelSelected(String.self))
            .bind { indexPath, item in
                print("\(indexPath) - \(item)")
        }.disposed(by: disposeBag)
        
        // 与上边对应的还有, itemDeselected modelDeselected
        
        // 单元格删除事件
        tableView.rx.itemDeleted.subscribe(onNext: {
            indexPath in
            print("删除的选项: \(indexPath)")
        }).disposed(by: disposeBag)
        tableView.rx.modelDeleted(String.self).subscribe(onNext: {
            item in
            print("删除的model: \(item)")
        }).disposed(by: disposeBag)
        
        
        // 单元格移动
        tableView.rx.itemMoved.subscribe(onNext: {
            source, destination in
            print("source: \(source) - destination: \(destination)")
        }).disposed(by: disposeBag)
        
        // 单元格插入事件响应
        tableView.rx.itemInserted.subscribe(onNext: { indexPath in
            print("插入: \(indexPath)")
        }).disposed(by: disposeBag)
        
        //获取点击的尾部图标的索引
        tableView.rx.itemAccessoryButtonTapped.subscribe({ [weak self] indexPath in
            print("尾部项的indexPath为：\(indexPath)")
        }).disposed(by: disposeBag)
        
        //单元格将要显示出来的事件响应
        tableView.rx.willDisplayCell.subscribe(onNext: { cell, indexPath in
            print("将要显示单元格indexPath为：\(indexPath)")
            print("将要显示单元格cell为：\(cell)\n")
            
        }).disposed(by: disposeBag)
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        test1()
        
    }
    

    

}
