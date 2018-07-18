//
//  ViewController.swift
//  RxMoyaRxSwiftCopy
//
//  Created by MrParker on 2018/7/14.
//  Copyright © 2018 MrParker. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import ObjectMapper

class ViewController: UIViewController {
    //显示频道列表的tableView
    var tableView:UITableView!
    
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //创建表视图
        self.tableView = UITableView(frame:self.view.frame, style:.plain)
        //创建一个重用的单元格
        self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.view.addSubview(self.tableView!)
        
        
        //豆瓣网络请求服务
        let networkService = PostProvider()
        
        let data = networkService.loadChannels()
        //        print(data)
        
        //将数据绑定到表格
        data.bind(to: tableView.rx.items) { (tableView, row, element) in
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
            cell.textLabel?.text = "\(element.name!)"
            cell.accessoryType = .disclosureIndicator
            return cell
            }.disposed(by: disposeBag)
        
        //单元格点击
        tableView.rx.modelSelected(Channel.self)
            .map{ $0.channelId! }
            .flatMap(networkService.loadFirstSong)
            .subscribe(onNext: {[weak self] song in
                //将歌曲信息弹出显示
                let message = "歌手：\(song.artist!)\n歌曲：\(song.title!)"
                self?.showAlert(title: "歌曲信息", message: message)
            }).disposed(by: disposeBag)
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //显示消息
    func showAlert(title:String, message:String){
        let alertController = UIAlertController(title: title,
                                                message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
}

