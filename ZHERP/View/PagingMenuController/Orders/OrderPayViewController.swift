//
//  OrderAllViewController.swift
//  ZHERP
//
//  Created by MrParker on 2018/7/29.
//  Copyright © 2018 MrParker. All rights reserved.
//

import UIKit
import MJRefresh

class OrderPayViewController: UIViewController {
    
    var tableView: UITableView!
    let CELL_IDENTIFY_ID = "CELL_IDENTIFY_ID"
    
    var navHeight: CGFloat!
    var tabBarHeight: CGFloat!
    // 顶部刷新
    let header = MJRefreshNormalHeader()
    // 底部刷新
    let footer = MJRefreshAutoNormalFooter()
    
    var dataArr = [
        ["imagePath": "html", "suk": "AB_PPC01", "title": "六神花露水001", "price": "17.50","orderId": "ZH201808242256"],
        ["imagePath": "java", "suk": "BC_PPC02", "title": "六神花露水002", "price": "17.50","orderId": "ZH201808242256"],
        ["imagePath": "bayMax", "suk": "CD_PPC03", "title": "六神花露水003", "price": "17.50","orderId": "ZH201808242256"],
        ["imagePath": "php", "suk": "DE_PPC04", "title": "六神花露水004", "price": "17.50","orderId": "ZH201808242256"],
        ["imagePath": "bayMax", "suk": "EF_PPC05", "title": "六神花露水005", "price": "17.50","orderId": "ZH201808242256"],
        ["imagePath": "react", "suk": "FG_PPC06", "title": "六神花露水006", "price": "17.50","orderId": "ZH201808242256"],
        ["imagePath": "ruby", "suk": "GH_PPC07", "title": "六神花露水007", "price": "17.50","orderId": "ZH201808242256"],
        ["imagePath": "swift", "suk": "HI_PPC08", "title": "六神花露水008", "price": "17.50","orderId": "ZH201808242256"],
        ["imagePath": "xcode", "suk": "IJ_PPC09", "title": "六神花露水009", "price": "17.50","orderId": "ZH201808242256"],
        ["imagePath": "bayMax", "suk": "JK_PPC10", "title": "六神花露水010", "price": "17.50","orderId": "ZH201808242256"],
        ["imagePath": "bayMax", "suk": "KL_PPC11", "title": "六神花露水011", "price": "17.50","orderId": "ZH201808242256"]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = Specs.color.white
        
        self._setup()
        
        // Do any additional setup after loading the view.
    }
    
    private func _setup() {
        self.navHeight = GlobalNavHeight
        self.tabBarHeight = GlobalTabBarHeight
        
        refreshItemData()
        
        // 创建表视图
        self.tableView = UITableView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight - self.navHeight - self.tabBarHeight - 29), style:.grouped)
        
        // delegate
        let _delegate = OrderDelegateDataSource()
        _delegate.dataArr = self.dataArr
        _delegate.CELL_IDENTIFY_ID = self.CELL_IDENTIFY_ID
        self.addChildViewController(_delegate)
        
        self.tableView!.delegate = _delegate
        self.tableView!.dataSource = _delegate
        
        self.tableView!.backgroundColor = Specs.color.white
        self.navigationController?.navigationBar.isTranslucent = false
        self.automaticallyAdjustsScrollViewInsets = false
        self.tableView?.tableHeaderView = UIView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0.1))
        self.tableView?.register(UINib(nibName: "OrderTableViewCell", bundle: nil), forCellReuseIdentifier: CELL_IDENTIFY_ID)
        self.view.addSubview(self.tableView!)
        self.tableView!.translatesAutoresizingMaskIntoConstraints = false
        
        //下拉刷新相关设置
        header.setTitle("下拉可以刷新", for: .idle)
        header.setTitle("松开立即刷新", for: .pulling)
        header.setTitle("正在刷新数据...", for: .refreshing)
        header.lastUpdatedTimeLabel.text = "最后更新"
        header.setTitle("没有更多数据啦~", for: .noMoreData)
        header.setRefreshingTarget(self, refreshingAction: #selector(OrderAllViewController.headerRefresh))
        self.tableView!.mj_header = header
        
        // 上拉刷新
        footer.setRefreshingTarget(self, refreshingAction: #selector(footerRefresh))
        self.tableView?.mj_footer = footer
    }
    
    @objc func footerRefresh(){
        print("上拉刷新")
        self.tableView?.mj_footer.endRefreshing()
        // 2次后模拟没有更多数据
        if (self.dataArr.count > 10) {
            footer.endRefreshingWithNoMoreData()
        }
    }
    
    //顶部下拉刷新
    @objc func headerRefresh(){
        sleep(1)
        //重现生成数据
        refreshItemData()
        
        if (self.dataArr.count > 6) {
            DispatchQueue.main.async {
                // 主线程中
                //                self.tableView!.mj_header.state = MJrefreshno
            }
            
        }
        //重现加载表格数据
        self.tableView!.reloadData()
        //结束刷新
        self.tableView!.mj_header.endRefreshing()
    }
    
    //初始化数据
    func refreshItemData() {
        let count = self.dataArr.count
        let imagePaths = ["java","php","html","react","ruby","swift","xcode","bayMax","c#"]
        
        for i in 0...2 {
            let index = arc4random_uniform(UInt32(imagePaths.count))
            let _imagePath = imagePaths[Int(index)]
            self.dataArr.append(["imagePath": _imagePath, "suk": "QQ_PPC_\(count + i)", "title": "六神花露水\(count + i)", "price": "17.50","orderId": "ZH201808242256"])
        }
    }
    
    @objc func actionBack() {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
