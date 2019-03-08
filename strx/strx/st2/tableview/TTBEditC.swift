//
//  TTBEditC.swift
//  strx
//
//  Created by IOS3 on 2019/3/4.
//  Copyright © 2019 IOS3. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources



fileprivate enum TableEditingCommand {
    case setItems(items: [String])
    case addItem(item: String)
    case moveItem(from: IndexPath, to: IndexPath)
    case deleteItem(IndexPath)
}

fileprivate struct TableViewModel {
    var items: [String]
    init(items: [String] = []) {
        self.items = items
    }
    
    func execute(command: TableEditingCommand) -> TableViewModel {
        switch command {
        case .setItems(let items):
            print("设置表格数据")
            return TableViewModel(items: items)
        case .addItem(let item):
            print("新增数据项")
            var items = self.items
            items.append(item)
            return TableViewModel(items: items)
        case .moveItem(let from, let to):
            print("移动数据项")
            var items = self.items
            items.insert(items.remove(at: from.row), at: to.row)
            return TableViewModel(items: items)
        case .deleteItem(let idx):
            print("删除数据项")
            var items = self.items
            items.remove(at: idx.row)
            return TableViewModel(items: items)
        }
    }
}


class TTBEditC: BaseController {
    
    var tableView: UITableView!
    var reloadItem: UIBarButtonItem!
    var addItem: UIBarButtonItem!
    var editItem: UIBarButtonItem!
    var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        func initialTableView() {
            tableView = UITableView(frame: view.frame, style: .plain)
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
            view.addSubview(tableView)
        }
        
        func initialNavigation() {
            addItem = UIBarButtonItem(title: "增加", style: .plain, target: self, action: nil)
            reloadItem = UIBarButtonItem(title: "刷新", style: .plain, target: self, action:nil)
            editItem = UIBarButtonItem(title: "编辑", style: .plain, target: self, action:nil)
            self.navigationItem.rightBarButtonItems = [reloadItem, addItem, editItem];
        }
        
        initialTableView()
        initialNavigation()
        test1()
    }
    
    
    func test1() {
        
        editItem.rx.tap.asObservable()
            .bind { [weak self] in
                self?.tableView.setEditing(!(self?.tableView.isEditing ?? false), animated: true)
        }.disposed(by: disposeBag)
        
        
        let viewModel = TableViewModel()
        
        let refreshCommand = reloadItem.rx.tap.asObservable()
            .startWith(())
            .flatMapLatest(getRandomResult)
            .map(TableEditingCommand.setItems)
        
        let addCommand = addItem.rx.tap.asObservable()
            .map{ "\(arc4random())" }
            .map(TableEditingCommand.addItem)
        
        let movedCommand = tableView.rx.itemMoved
            .map(TableEditingCommand.moveItem)
        
        let deleteCommand = tableView.rx.itemDeleted.asObservable()
            .map(TableEditingCommand.deleteItem)
        
        Observable.of(refreshCommand, addCommand, movedCommand, deleteCommand)
            .merge()
            .scan(viewModel) { (vm, cmd) -> TableViewModel in
                return vm.execute(command: cmd)
            }
            .startWith(viewModel)
            .map{ [AnimatableSectionModel(model: "", items: $0.items)] }
            .share(replay: 1)
            .bind(to: tableView.rx.items(dataSource: dataSource()))
            .disposed(by: disposeBag)
    }
}


extension TTBEditC {
    func getRandomResult() -> Observable<[String]> {
        print("正在请求数据")
        let items = (0..<7).map { _ in
            "\(arc4random())"
        }
        let observable = Observable.just(items)
        return observable
    }
    
    func dataSource() -> RxTableViewSectionedAnimatedDataSource<AnimatableSectionModel<String, String>> {
        return RxTableViewSectionedAnimatedDataSource(
            //设置插入、删除、移动单元格的动画效果
            animationConfiguration: AnimationConfiguration(insertAnimation: .top,
                                                           reloadAnimation: .fade,
                                                           deleteAnimation: .left),
            configureCell: {
                (dataSource, tv, indexPath, element) in
                let cell = tv.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
                cell.textLabel?.text = "条目\(indexPath.row)：\(element)"
                return cell
        },
            canEditRowAtIndexPath: { _, _ in
                return true //单元格可删除
        },
            canMoveRowAtIndexPath: { _, _ in
                return true //单元格可移动
        })
    }
    
}
