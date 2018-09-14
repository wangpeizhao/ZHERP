//
//  HAllocatingViewController.swift
//  ZHERP
//
//  Created by MrParker on 2018/9/8.
//  Copyright © 2018 MrParker. All rights reserved.
//

import UIKit
import MJRefresh

class HAllocateViewController: UIViewController {
    
    var tableView: UITableView!
    let CELL_IDENTIFY_ID = "CELL_IDENTIFY_ID"
    
    // 顶部刷新
    let header = MJRefreshNormalHeader()
    // 底部刷新
    let footer = MJRefreshAutoNormalFooter()
    
    var dataArr = [
        ["datetime": "2018-09-06 13:23:56", "id": "516", "orderId": "2018090612344519995"],
        ["datetime": "2018-08-06 13:23:56", "id": "4456", "orderId": "2018090612344529997"],
        ["datetime": "2018-07-06 13:23:56", "id": "536", "orderId": "2018090612344539997"],
        ["datetime": "2018-06-06 13:23:56", "id": "560", "orderId": "2018090612344599900"],
        ["datetime": "2018-05-06 13:23:56", "id": "569", "orderId": "2018090612344598800"],
        ["datetime": "2018-04-06 13:23:56", "id": "7656", "orderId": "2018090612344534567"],
        ["datetime": "2018-03-06 13:23:56", "id": "256", "orderId": "2018090612344556453"],
        ["datetime": "2018-02-06 13:23:56", "id": "596", "orderId": "2018090612344556900"],
        ["datetime": "2018-01-06 13:23:56", "id": "1256", "orderId": "2018090612344596667"],
        ["datetime": "2018-09-05 13:23:56", "id": "23456", "orderId": "2018090612344593325"],
        ["datetime": "2018-09-04 13:23:56", "id": "5t56", "orderId": "2018090612344599664"],
        ["datetime": "2018-09-03 13:23:56", "id": "509096", "orderId": "2018090612344599544"],
        ["datetime": "2018-04-06 13:23:56", "id": "7656", "orderId": "2018090612344534567"],
        ["datetime": "2018-03-06 13:23:56", "id": "256", "orderId": "2018090612344556453"],
        ["datetime": "2018-02-06 13:23:56", "id": "596", "orderId": "2018090612344556900"],
        ["datetime": "2018-01-06 13:23:56", "id": "1256", "orderId": "2018090612344596667"],
        ["datetime": "2018-09-05 13:23:56", "id": "23456", "orderId": "2018090612344593325"],
        ["datetime": "2018-09-04 13:23:56", "id": "5t56", "orderId": "2018090612344599664"],
        ["datetime": "2018-09-03 13:23:56", "id": "509096", "orderId": "2018090612344599544"],
        ["datetime": "2018-04-06 13:23:56", "id": "7656", "orderId": "2018090612344534567"],
        ["datetime": "2018-03-06 13:23:56", "id": "256", "orderId": "2018090612344556453"],
        ["datetime": "2018-02-06 13:23:56", "id": "596", "orderId": "2018090612344556900"],
        ["datetime": "2018-01-06 13:23:56", "id": "1256", "orderId": "2018090612344596667"],
        ["datetime": "2018-09-05 13:23:56", "id": "23456", "orderId": "2018090612344593325"],
        ["datetime": "2018-09-04 13:23:56", "id": "5t56", "orderId": "2018090612344599664"],
        ["datetime": "2018-09-03 13:23:56", "id": "509096", "orderId": "2018090612344599544"],
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = Specs.color.white
        setNavBarTitle(view: self, title: "调货记录")
        setNavBarBackBtn(view: self, title: "", selector: #selector(actionBack))
        
        // 设置右侧按钮1(扫码)
        let rightBarBtnScan = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(actionScan))
        rightBarBtnScan.image = UIImage(named: "scan")
        rightBarBtnScan.tintColor = Specs.color.white
        
        // 设置右侧按钮2(筛选)
        let rightBarBtnScreening = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(actionScreening))
        rightBarBtnScreening.image = UIImage(named: "screening")
        rightBarBtnScreening.tintColor = Specs.color.white
        self.navigationItem.rightBarButtonItems = [rightBarBtnScan,rightBarBtnScreening]
        
        self._setup()
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
            let _data = ["datetime": "2018-09-03 13:23:56", "id": "509096", "orderId": "201809061234459954\(i)"]
            if (append) {
                self.dataArr.append(_data)
            } else {
                self.dataArr.insert(_data, at: 0)
            }
        }
    }
    
    @objc func actionBack() {
        
    }
    
    @objc func actionScan() {
        let _ZHQRCode = ZHQRCodeViewController()
        _ZHQRCode.actionType = "allocating"
        _push(view: self, target: _ZHQRCode, rootView: false)
    }
    
    @objc func actionScreening() {
        let _target = SearchViewController()
        _target.navBarTitle = "搜索货品"
        _target.searchBarPlaceholder = "按货品名称或编号搜索"
        _target.searchType = "allocating"
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

extension HAllocateViewController: UITableViewDelegate, UITableViewDataSource {
    
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
        
        cell.textLabel?.text = "单据号：\(_data["orderId"]!)"
        cell.textLabel?.font = Specs.font.regular
        
        cell.detailTextLabel?.text = _data["datetime"]
        cell.detailTextLabel?.font = Specs.font.regular
        
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    // UITableViewDelegate 方法，处理列表项的选中事件
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let _data = dataArr[indexPath.item]
        
        let _target = HAllocatingViewController()
        _target.navTitle = "调货记录"
        _target.valueArr = [
            "id": _data["id"],
            "orderId": _data["orderId"],
            "sn": "ZHG20180908123456987",
            "name": "汤臣倍健多种维生素",
            "warehouse": "广州仓库",
            "wId": "2",
            "transferred": "深圳仓库",
            "quantity": "100",
            "outWarehouse": "10000",
            "inWarehouse": "200",
            "employees": "王培照",
            "datetime": _data["datetime"]
        ] as! [String : String]
        
        _push(view: self, target: _target, rootView: false)
    }
}
