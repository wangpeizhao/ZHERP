//
//  SMemberLoginLogsViewController.swift
//  ZHERP
//
//  Created by MrParker on 2018/9/13.
//  Copyright © 2018年 MrParker. All rights reserved.
//

import UIKit
import MJRefresh

class SMemberLoginLogsViewController: UIViewController {

    var uId: Int!
    var tableView: UITableView!
    let CELL_IDENTIFY_ID = "CELL_IDENTIFY_ID"
    // 底部刷新
    let footer = MJRefreshAutoNormalFooter()
    
    var dataArr = [
        ["loginTime":"2018-09-13 09:21:31", "ip":"217.0.0.1"],
        ["loginTime":"2018-09-13 09:21:31", "ip":"217.0.0.1"],
        ["loginTime":"2018-09-13 09:21:31", "ip":"217.0.0.1"],
        ["loginTime":"2018-09-13 09:21:31", "ip":"217.0.0.1"],
        ["loginTime":"2018-09-13 09:21:31", "ip":"217.0.0.1"],
        ["loginTime":"2018-09-13 09:21:31", "ip":"217.0.0.1"],
        ["loginTime":"2018-09-13 09:21:31", "ip":"217.0.0.1"],
        ["loginTime":"2018-09-13 09:21:31", "ip":"217.0.0.1"],
        ["loginTime":"2018-09-13 09:21:31", "ip":"217.0.0.1"],
        ["loginTime":"2018-09-13 09:21:31", "ip":"217.0.0.1"],
        ["loginTime":"2018-09-13 09:21:31", "ip":"217.0.0.1"],
        ["loginTime":"2018-09-13 09:21:31", "ip":"217.0.0.1"],
        ["loginTime":"2018-09-13 09:21:31", "ip":"217.0.0.1"],
        ["loginTime":"2018-09-13 09:21:31", "ip":"217.0.0.1"],
        ["loginTime":"2018-09-13 09:21:31", "ip":"217.0.0.1"],
        ["loginTime":"2018-09-13 09:21:31", "ip":"217.0.0.1"],
        ["loginTime":"2018-09-13 09:21:31", "ip":"217.0.0.1"],
        ["loginTime":"2018-09-13 09:21:31", "ip":"217.0.0.1"],
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavBarTitle(view: self, title: "登录记录")
        
        self._setUp()

        // Do any additional setup after loading the view.
    }
    
    private func _setUp() {
        //创建表视图
        self.tableView = UITableView(frame: self.view.frame, style: .grouped)
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: CELL_IDENTIFY_ID)
        self.tableView!.register(SimpleBasicsCell.self, forCellReuseIdentifier: SimpleBasicsCell.identifier)
        self.tableView!.tableHeaderView = UIView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0.1))
        self.view.addSubview(self.tableView!)
        
        // 上拉刷新
        self.footer.setRefreshingTarget(self, refreshingAction: #selector(footerRefresh))
        self.tableView?.mj_footer = self.footer
    }
    
    @objc func footerRefresh(){
        print("上拉刷新:\(self.dataArr.count).")
        sleep(1)
        //        self.tableView?.mj_footer.endRefreshing()
        //重现生成数据
        refreshItemData(append: true)
        if (self.dataArr.count > 6) {
            DispatchQueue.main.async {
                // 主线程中
                // elf.tableView!.mj_header.state = MJrefreshno
            }
        }
        self.tableView!.reloadData()
        self.tableView?.mj_footer.endRefreshing()
        // 2次后模拟没有更多数据
        if (self.dataArr.count > 50) {
            footer.endRefreshingWithNoMoreData()
        }
    }
    
    //初始化数据
    func refreshItemData(append: Bool = true) {
        for _ in 0...2 {
            let _data = ["loginTime": "2018-09-03 13:23:56", "ip": "121.33.75.146"]
            if (append) {
                self.dataArr.append(_data)
            } else {
                self.dataArr.insert(_data, at: 0)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension SMemberLoginLogsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArr.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ""
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SelectCellHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    //设置分组头的高度
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return ""
    }
    
    //设置分组尾的高度
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    //创建各单元显示内容(创建参数indexPath指定的单元）
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let _data = dataArr[indexPath.item]
        let cell = UITableViewCell(style: .value1, reuseIdentifier: CELL_IDENTIFY_ID)
        
        cell.textLabel?.text = _data["loginTime"]
        
        cell.detailTextLabel?.text = _data["ip"]
        
        return cell
    }
    
    // UITableViewDelegate 方法，处理列表项的选中事件
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
//        let _data = dataArr[indexPath.item]
        //        print(_data)
        //        _back(view: self)
    }
    
}
