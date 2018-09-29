//
//  HDeliverViewController.swift
//  ZHERP
//
//  Created by MrParker on 2018/9/17.
//  Copyright © 2018年 MrParker. All rights reserved.
//

import UIKit
import MJRefresh

class HDeliverViewController: UIViewController {
    
    var tableView: UITableView!
    let CELL_IDENTIFY_ID = "CELL_IDENTIFY_ID"
    
    // 顶部刷新
    let header = MJRefreshNormalHeader()
    // 底部刷新
    let footer = MJRefreshAutoNormalFooter()
    
    var dataArr = [
        ["id": "123", "expressNumber": "SH345678932", "expressInfo": "15622299006/王培照"],
        ["id": "123", "expressNumber": "SH345678932", "expressInfo": "15622299006/王培照"],
        ["id": "123", "expressNumber": "SH345678932", "expressInfo": "15622299006/王培照"],
        ["id": "123", "expressNumber": "SH345678932", "expressInfo": "15622299006/王培照"],
        ["id": "123", "expressNumber": "SH345678932", "expressInfo": "15622299006/王培照"],
        ["id": "123", "expressNumber": "SH345678932", "expressInfo": "15622299006/王培照"],
        ["id": "123", "expressNumber": "SH345678932", "expressInfo": "15622299006/王培照"],
        ["id": "123", "expressNumber": "SH345678932", "expressInfo": "15622299006/王培照"],
        ["id": "123", "expressNumber": "SH345678932", "expressInfo": "15622299006/王培照"],
        ["id": "123", "expressNumber": "SH345678932", "expressInfo": "15622299006/王培照"],
        ["id": "123", "expressNumber": "SH345678932", "expressInfo": "15622299006/王培照"],
        ["id": "123", "expressNumber": "SH345678932", "expressInfo": "15622299006/王培照"],
        ["id": "123", "expressNumber": "SH345678932", "expressInfo": "15622299006/王培照"],
        ["id": "123", "expressNumber": "SH345678932", "expressInfo": "15622299006/王培照"],
        ["id": "123", "expressNumber": "SH345678932", "expressInfo": "15622299006/王培照"],
        ["id": "123", "expressNumber": "SH345678932", "expressInfo": "15622299006/王培照"],
        ["id": "123", "expressNumber": "SH345678932", "expressInfo": "15622299006/王培照"],
        ["id": "123", "expressNumber": "SH345678932", "expressInfo": "15622299006/王培照"],
        ["id": "123", "expressNumber": "SH345678932", "expressInfo": "15622299006/王培照"],
        ["id": "123", "expressNumber": "SH345678932", "expressInfo": "15622299006/王培照"],
        ["id": "123", "expressNumber": "SH345678932", "expressInfo": "15622299006/王培照"],
        ["id": "123", "expressNumber": "SH345678932", "expressInfo": "15622299006/王培照"],
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = Specs.color.white
        setNavBarTitle(view: self, title: "发货记录")
        setNavBarBackBtn(view: self, title: "", selector: #selector(actionBack))
        setNavBarRightBtn(view: self, title: "发货", selector: #selector(actionDelivery))
        
        self._setup()
    }
    
    @objc func actionDelivery() {
        let _target = HDeliveringViewController()
        _push(view: self, target: _target, rootView: false)
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
    
    //顶部下拉刷新
    @objc func headerRefresh(){
        print("下拉刷新:\(self.dataArr.count).")
        sleep(1)
        //重现生成数据
        refreshItemData(append: false)
        
        // self.tableView?.mj_header.endRefreshing(.)
        if (self.dataArr.count > 6) {
            DispatchQueue.main.async {
                // 主线程中
                // elf.tableView!.mj_header.state = MJrefreshno
            }
        }
        //重现加载表格数据
        self.tableView!.reloadData()
        //结束刷新
        self.tableView!.mj_header.endRefreshing()
    }
    
    //刷新数据
    func refreshItemData(append: Bool) {
        for i in 0...2 {
            let _data = ["id": "123\(i)", "expressNumber": "20180903132356\(i)", "expressInfo": "13533615794/王培照"]
            if (append) {
                self.dataArr.append(_data)
            } else {
                self.dataArr.insert(_data, at: 0)
            }
        }
    }
    
    @objc func actionBack() {
        
    }
    
    @objc func actionInventory() {
        let _target = HInventoryTakingViewController()
        _target.hidesBottomBarWhenPushed = true
        _push(view: self, target: _target, rootView: false)
    }
    
    func _setup() {
        self.tableView = UITableView(frame: self.view.frame, style: .grouped)
        
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: CELL_IDENTIFY_ID)
        self.tableView!.register(SimpleBasicsCell.self, forCellReuseIdentifier: SimpleBasicsCell.identifier)
        self.tableView!.tableHeaderView = UIView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0.1))
        self.view.addSubview(self.tableView!)
        
        //下拉刷新相关设置
        self.header.setTitle("下拉可以刷新", for: .idle)
        self.header.setTitle("松开立即刷新", for: .pulling)
        self.header.setTitle("正在刷新数据...", for: .refreshing)
        self.header.lastUpdatedTimeLabel.text = "最后更新"
        self.header.setTitle("没有更多数据啦~", for: .noMoreData)
        self.header.setRefreshingTarget(self, refreshingAction: #selector(OrderAllViewController.headerRefresh))
        self.tableView!.mj_header = self.header
        
        // 上拉刷新
        self.footer.setRefreshingTarget(self, refreshingAction: #selector(footerRefresh))
        self.tableView?.mj_footer = self.footer
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension HDeliverViewController: UITableViewDelegate, UITableViewDataSource {
    
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
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    //创建各单元显示内容(创建参数indexPath指定的单元）
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let _data = dataArr[indexPath.item]
        let cell = tableView.dequeueReusableCell(withIdentifier: SimpleBasicsCell.identifier, for: indexPath)
        
        cell.textLabel?.text = "快递单号：\(_data["expressNumber"]!)"
        cell.textLabel?.font = Specs.font.regular
        
        cell.detailTextLabel?.text = _data["expressInfo"]
        cell.detailTextLabel?.font = Specs.font.regular
        
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    // UITableViewDelegate 方法，处理列表项的选中事件
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let _data = dataArr[indexPath.item]
        
        let _target = HDeliveringViewController()
        _target.valueArr = [
            "id": _data["id"],
            "orderId": "20180908123456987",
            "orderAmount": "2500.00",
            "orderRealPaid": "2500.00",
            
            "expressCompany": "顺丰快递",
            "expressNumber": "EX122343545k",
            "expressNote": "麻烦掌柜的快点发货",
            "receiver": "王先生",
            "receiverPhone": "13533615794",
            "province": "广东",
            "city": "广州",
            "area": "越秀",
            "receiverDetail": "站南路16号白马大厦九楼",
            
            "employees": "王培照",
            "datetime": "2018-09-08 12:34:56"
            ] as! [String : String]

        _push(view: self, target: _target, rootView: false)
    }
}
