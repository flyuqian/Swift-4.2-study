//
//  EditTableController.swift
//  strx
//
//  Created by IOS3 on 2018/11/22.
//  Copyright © 2018 IOS3. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources


class EditTableController: BaseController {
    
    
    /*
     （1）程序启动后表格会自动加载 5 条随机数据。点击“刷新”按钮则又重新生成 5 条数据并显示。
     （2）点击“加号”图标后，会在当前数据集的末尾添加一条随机数据并显示。
     （3）点击单元格左侧的“减号”图标则可以将该行数据删除。
     （4）拖动单元格右侧的控制图标可以改变显示顺序。
     */
    
    // 定义操作指令
    enum TableEditingCommand {
        case setItems(items: [String])                  // 设置数据
        case addItem(item: String)                      // 新增数据
        case moveItem(from: IndexPath, to: IndexPath)   // 移动数据
        case deleteItem(IndexPath)                      // 删除数据
    }

    // 定义 viewModel
    struct TableViewModel {
        fileprivate var items: [String]
        
        init(items: [String] = []) {
            self.items = items
        }
        
        func execute(command: TableEditingCommand) -> TableViewModel {
            switch command {
            case .setItems(items: let items):
                print("设置表格数据")
                return TableViewModel(items: items)
                
            case .addItem(item: let item):
                print("新增数据")
                var items = self.items
                items.append(item)
                return TableViewModel(items: items)
                
            case .moveItem(let from, let to):
                print("移动数据项")
                var items = self.items
                items.insert(items.remove(at: from.row), at: to.row)
                return TableViewModel(items: items)
                
            case .deleteItem(let indexPath):
                print("删除数据项")
                var items = self.items
                items.remove(at: indexPath.row)
                return TableViewModel(items: items)
            }
        }
    }
    
    
    
    func testEdit() {
        // 数据请求
        func getRandomResult() -> Observable<[String]> {
            print("正在请求数据...")
            let items = (0..<5).map {_ in
                "\(Int(arc4random()))"
            }
            let observable = Observable.just(items)
            return observable
        }
        
        func dataSource() -> RxTableViewSectionedAnimatedDataSource<AnimatableSectionModel<String, String>> {
            return RxTableViewSectionedAnimatedDataSource(
                animationConfiguration: AnimationConfiguration(insertAnimation: .top, reloadAnimation: .fade, deleteAnimation: .left),
                configureCell: { ds, tv, ip, it in
                    let cell = tv.dequeueReusableCell(withIdentifier: "Cell", for: ip)
                    cell.textLabel?.text = "条目: \(it)"
                    return cell
                },
                canEditRowAtIndexPath: {_, _ in
                    return true
                },
                canMoveRowAtIndexPath: { _, _ in
                    return true
                }
            )
        }
        
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        btn.setTitle("刷新", for: .normal)
        btn.setTitleColor(.blue, for: .normal)
        let btn2 = UIButton(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        btn2.setTitle("增加", for: .normal)
        btn2.setTitleColor(.blue, for: .normal)
        self.navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: btn2), UIBarButtonItem(customView: btn)]
        
        let tableView = UITableView(frame: CGRect(x: 0, y: 88, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), style: .plain)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView)
        tableView.setEditing(true, animated: true)
        
        
        
        let initialVM = TableViewModel()
        
        let refreshCommand = btn.rx.tap.asObservable()
            .startWith(())
            .flatMapFirst(getRandomResult)
            .map(TableEditingCommand.setItems)
        
        let addCommand = btn2.rx.tap.asObservable()
            .map { "\(arc4random())" }
            .map(TableEditingCommand.addItem)
        
        let moveCommand = tableView.rx.itemMoved
            .map(TableEditingCommand.moveItem)
        
        let deleteCommand = tableView.rx.itemDeleted.asObservable()
            .map(TableEditingCommand.deleteItem)
        
        
        
        Observable.of(refreshCommand, addCommand, moveCommand, deleteCommand)
            .merge()
            .scan(initialVM) { (vm: TableViewModel, command: TableEditingCommand) -> TableViewModel in
                return vm.execute(command: command)
            }
            .startWith(initialVM)
            .map { [AnimatableSectionModel(model: "", items: $0.items)] }
            .share(replay: 1, scope: SubjectLifetimeScope.forever)
            .bind(to: tableView.rx.items(dataSource: dataSource()))
            .disposed(by: disposeBag)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        testEdit()
    }
    

    

}
