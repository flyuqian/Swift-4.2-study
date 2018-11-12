//
//  WellComeRxController.swift
//  strx
//
//  Created by IOS3 on 2018/11/12.
//  Copyright © 2018 IOS3. All rights reserved.
//

import UIKit
import RxSwift

//歌曲结构体
struct Music {
    let name: String //歌名
    let singer: String //演唱者
    
    init(name: String, singer: String) {
        self.name = name
        self.singer = singer
    }
}

//实现 CustomStringConvertible 协议，方便输出调试
extension Music: CustomStringConvertible {
    var description: String {
        return "name：\(name) singer：\(singer)"
    }
}

fileprivate struct MusicListViewModel {
    let data = Observable.just([
        Music(name: "无条件", singer: "陈奕迅"),
        Music(name: "你曾是少年", singer: "S.H.E"),
        Music(name: "从前的我", singer: "陈洁仪"),
        Music(name: "在木星", singer: "朴树"),
        ])
}

class WellComeRxController: BaseController {
    
    let tableView = UITableView(frame: .zero, style: .plain)
    fileprivate let musicListViewModel = MusicListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(tableView)
        tableView.frame = contentFrame
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "musicCell")
        
       
        
        musicListViewModel.data
            .bind(to: tableView.rx.items(cellIdentifier: "musicCell")) {
                _, music, cell in
                cell.textLabel?.text = music.name
                cell.detailTextLabel?.text = music.singer
            }.disposed(by: disposeBag)
        
        
        tableView.rx.modelSelected(Music.self).subscribe(onNext: { (music) in
            print(music)
        }).disposed(by: disposeBag)
    }
    

   

}
