//
//  HomeController.swift
//  strx
//
//  Created by IOS3 on 2018/11/12.
//  Copyright © 2018 IOS3. All rights reserved.
//

import UIKit



fileprivate struct JumpClassModel {
    let clzType: UIViewController.Type
    let title: String
    let subTitle: String
}
fileprivate struct SectionModel {
    let headerTitle: String
    let footerTitle: String
    let jumpClzs: [JumpClassModel]
}


class HomeController: UITableViewController {

    
    fileprivate var cellModels = [SectionModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialCellModels()
        
        self.title = "练习 hangge.com 的Rx"
    }

    

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return cellModels.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return cellModels[section].jumpClzs.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let title = cellModels[section].headerTitle
        if title.count > 0 {
            return title
        }
        return nil
    }
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        let title = cellModels[section].footerTitle
        if title.count > 0 {
            return title
        }
        return nil
    }
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let jc = cellModels[indexPath.section].jumpClzs[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "homecellid", for:
            indexPath)
        cell.textLabel?.text = jc.title
        cell.detailTextLabel?.text = jc.subTitle

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let jc = cellModels[indexPath.section].jumpClzs[indexPath.row]
        if jc.clzType == MoreCellStyleController.self {
            let vc = UIStoryboard(name: "TestTableView", bundle: nil).instantiateViewController(withIdentifier: "MoreCellStyleController")
            navigationController?.pushViewController(vc, animated: true)
        }
        else {
            let vc = jc.clzType.init()
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}



extension HomeController {
    func initialCellModels() {
        cellModels = [
            SectionModel(headerTitle: "初识 RxSwfit", footerTitle: "", jumpClzs: [
                JumpClassModel(clzType: WellComeRxController.self, title: "响应式编程与传统编程比较", subTitle: ""),
                ]),
            
            SectionModel(headerTitle: "RxSwfit 元素介绍", footerTitle: "", jumpClzs: [
                JumpClassModel(clzType: ObservableController.self, title: "Observable", subTitle: "Observable 介绍, 创建可观察序列"),
                JumpClassModel(clzType: ObservableActionController.self, title: "Observable 2", subTitle: "Observable订阅 事件监听, 订阅销毁"),
                JumpClassModel(clzType: Observer1Controller.self, title: "观察者 Observer -1", subTitle: "AnyObserver Binder"),
                JumpClassModel(clzType: Observer2Controller.self, title: "观察者 Observer -2", subTitle: "自定义可绑定属性"),
                JumpClassModel(clzType: SubjectsViewController.self, title: "Subjects", subTitle: ""),
                JumpClassModel(clzType: TransformingObservablesController.self, title: "变换操作符", subTitle: "buffer map flatMap scan ..."),
                JumpClassModel(clzType: FilterObservableController.self, title: "过滤操作符", subTitle: "filter take skip..."),
                JumpClassModel(clzType: ConditionOperatorsController.self, title: "条件和布尔操作符", subTitle: "amb takeWhile skipWhile..."),
                JumpClassModel(clzType: ComBineOpratorController.self, title: "结合操作符", subTitle: "startWith merge zip..."),
                JumpClassModel(clzType: MathOperatorsController.self, title: "算数&聚合操作符", subTitle: "toArray reduce concat..."),
                JumpClassModel(clzType: ConnectOperatorController.self, title: "连接操作符", subTitle: "connect publish replay muilticast..."),
                JumpClassModel(clzType: OtherOperatorController.self, title: "其他操作符", subTitle: "delay materialize timeout..."),
                ]),
            
            SectionModel(headerTitle: "错误处理 & 调试", footerTitle: "", jumpClzs: [
                JumpClassModel(clzType: ErrorHandlerController.self, title: "错误处理", subTitle: ""),
                JumpClassModel(clzType: DebugRxController.self, title: "调试", subTitle: ""),
                ]),
            
            SectionModel(headerTitle: "特征序列", footerTitle: "", jumpClzs: [
                JumpClassModel(clzType: TraitsSequence1Controller.self, title: "特征序列1", subTitle: "single completable maybe"),
                JumpClassModel(clzType: TraitsSequence2Controller.self, title: "特征序列2", subTitle: "Driver"),
                JumpClassModel(clzType: TraitsSequence3Controller.self, title: "特征序列3", subTitle: "ControlProperty ControlEvent"),
                ]),
            
            SectionModel(headerTitle: "调度器", footerTitle: "", jumpClzs: [
                JumpClassModel(clzType: SchedulersController.self, title: "调度器", subTitle: "调度器 subscribeOn observeOn"),
                ]),
            
            SectionModel(headerTitle: "UI控件拓展", footerTitle: "", jumpClzs: [
                JumpClassModel(clzType: TestUI_1_Controller.self, title: "UILabel", subTitle: "UI控件拓展1"),
                JumpClassModel(clzType: TestUI_2_Controller.self, title: "UITextField UITextView", subTitle: "UI控件拓展2"),
                JumpClassModel(clzType: TestUI_3_Controller.self, title: "UIButton .... 很多控件的 rx 属性", subTitle: "UI控件拓展3, 列出关键属性, 不写案例"),
                JumpClassModel(clzType: BothwayBindingController.self, title: "双向绑定", subTitle: ""),
                ]),
            
            SectionModel(headerTitle: "UITableView 的使用", footerTitle: "", jumpClzs: [
                JumpClassModel(clzType: TestTableViewController.self, title: "基本用法", subTitle: ""),
                JumpClassModel(clzType: RxDataSourceViewController.self, title: "RxDataSource 的使用", subTitle: ""),
                JumpClassModel(clzType: ReloadDataController.self, title: "tableView 刷新表格数据", subTitle: ""),
                JumpClassModel(clzType: FilterDataController.self, title: "表格数据的 搜索过滤", subTitle: ""),
                JumpClassModel(clzType: EditTableController.self, title: "可编辑表格", subTitle: ""),
                JumpClassModel(clzType: MoreCellStyleController.self, title: "不同类型的单元格混用", subTitle: ""),
                JumpClassModel(clzType: ChangeStyleController.self, title: "UITableView 的样式修改", subTitle: ""),
                ]),
            
            SectionModel(headerTitle: "UICollectionView 的使用", footerTitle: "", jumpClzs: [
                JumpClassModel(clzType: TestNormalCollectionController.self, title: "collectionView rx 基本用法", subTitle: ""),
                ]),
            
        ]
    }
}

