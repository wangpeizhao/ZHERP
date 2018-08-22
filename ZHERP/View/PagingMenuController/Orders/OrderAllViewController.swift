//
//  OrderAllViewController.swift
//  ZHERP
//
//  Created by MrParker on 2018/7/29.
//  Copyright © 2018 MrParker. All rights reserved.
//

import UIKit
import SnapKit
import MJRefresh

class OrderAllViewController: UIViewController {
    
    var navHeight: CGFloat!
    var tableView: UITableView?
    let identify: String = "OrderCell"
    // 顶部刷新
    let header = MJRefreshNormalHeader()
    // 底部刷新
    let footer = MJRefreshAutoNormalFooter()
    
    var dataArray : [Int: [String:String]] = [
        0: ["imagePath": "html", "suk": "AB_PPC01", "title": "六神花露水001", "price": "17.50"],
        1: ["imagePath": "java", "suk": "BC_PPC02", "title": "六神花露水002", "price": "17.50"],
        2: ["imagePath": "bayMax", "suk": "CD_PPC03", "title": "六神花露水003", "price": "17.50"],
        3: ["imagePath": "php", "suk": "DE_PPC04", "title": "六神花露水004", "price": "17.50"],
        4: ["imagePath": "bayMax", "suk": "EF_PPC05", "title": "六神花露水005", "price": "17.50"],
        5: ["imagePath": "react", "suk": "FG_PPC06", "title": "六神花露水006", "price": "17.50"],
        6: ["imagePath": "ruby", "suk": "GH_PPC07", "title": "六神花露水007", "price": "17.50"],
        7: ["imagePath": "swift", "suk": "HI_PPC08", "title": "六神花露水008", "price": "17.50"],
        8: ["imagePath": "xcode", "suk": "IJ_PPC09", "title": "六神花露水009", "price": "17.50"],
        9: ["imagePath": "bayMax", "suk": "JK_PPC10", "title": "六神花露水010", "price": "17.50"],
        10: ["imagePath": "bayMax", "suk": "KL_PPC11", "title": "六神花露水011", "price": "17.50"]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navHeight = self.navigationController?.navigationBar.frame.maxY
        
        refreshItemData()
        
//        print(self.dataArray)
        // 创建表视图
        self.tableView = UITableView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight - 130), style:.grouped)
        // 去除表格上放多余的空隙
        self.tableView!.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        self.tableView!.backgroundColor = Specs.color.white
        //去除单元格分隔线
//        self.tableView!.separatorStyle = .singleLine
        
        //        self.tableView!.rowHeight = UITableViewAutomaticDimension;
        
        //设置estimatedRowHeight属性默认值
        //        self.tableView.estimatedRowHeight = 44.0;
        //rowHeight属性设置为UITableViewAutomaticDimension
        //        self.tableView.rowHeight = UITableViewAutomaticDimension;
        
        //创建一个重用的单元格
        //        self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: identify)
        self.navigationController?.navigationBar.isTranslucent = false
        self.automaticallyAdjustsScrollViewInsets = false
        self.tableView?.tableHeaderView = UIView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0.1))
        self.tableView?.register(UINib(nibName: "OrderTableViewCell", bundle: nil), forCellReuseIdentifier: identify)
        self.view.addSubview(self.tableView!)
        self.tableView!.translatesAutoresizingMaskIntoConstraints = false
        
        //下拉刷新相关设置
//        UserDefaults.standard.set(Date(), forKey: MJRefreshHeaderLastTimeText)
        header.setTitle("下拉可以刷新", for: .idle)
        header.setTitle("松开立即刷新", for: .pulling)
        header.setTitle("正在刷新数据...", for: .refreshing)
//        header.lastUpdatedTimeLabel.isHidden = true
        header.lastUpdatedTimeLabel.text = "最后更新"
//        header.lastUpdatedTimeText = Date()
//        header.lastUpdatedTimeLabel.text = "最后更新"/
//        "MJRefreshHeaderLastTimeText" = "Last update:";
//        "MJRefreshHeaderDateTodayText" = "Today";
//        MJRefreshHeaderLastTimeText = ""
        header.setTitle("没有更多数据啦~", for: .noMoreData)
        header.setRefreshingTarget(self, refreshingAction: #selector(OrderAllViewController.headerRefresh))
        self.tableView!.mj_header = header
        // Do any additional setup after loading the view.
        
        
        
        // 上拉刷新
        footer.setRefreshingTarget(self, refreshingAction: #selector(footerRefresh))
        self.tableView?.mj_footer = footer
    }
    
    @objc func footerRefresh(){
        print("上拉刷新")
        self.tableView?.mj_footer.endRefreshing()
        // 2次后模拟没有更多数据
        if (self.dataArray.count > 10) {
            footer.endRefreshingWithNoMoreData()
        }
    }
    
    //顶部下拉刷新
    @objc func headerRefresh(){
        print("下拉刷新.")
        sleep(1)
        //重现生成数据
        refreshItemData()
        
//        self.tableView?.mj_header.endRefreshing(.)
        if (self.dataArray.count > 6) {
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
        let count = self.dataArray.count
        print("count:\(count)")
        for i in 0...2 {
            print(i)
            self.dataArray[count + i] = ["imagePath": "bayMax", "suk": "QQ_PPC_\(count + i)", "title": "六神花露水", "price": "17.50"]
        }
        print(self.dataArray)
    }
    
    @objc func actionBack() {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension OrderAllViewController: UITableViewDataSource ,UITableViewDelegate {
    
    
    //在本例中，只有一个分区
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    //返回表格行数（也就是返回控件数）
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    //设置分组头的高度
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0.1 : 8.0
    }
    
    //    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
    //        return "开启后，手机不会振动与发出提示音；如果设置为“只在夜间开启”，则只在22:00到08:00间生效"
    //    }
    
    //创建各单元显示内容(创建参数indexPath指定的单元）
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
            let count = self.dataArray.count
            let sectionNo = count - indexPath.row - 1
            print(sectionNo)
            let cell: OrderTableViewCell = tableView.dequeueReusableCell(withIdentifier: identify) as! OrderTableViewCell
            if !(self.dataArray[sectionNo]?.isEmpty)! {
                var _data = self.dataArray[sectionNo]!
                print(_data)
                //            let _data = data[indexPath.row as Int]
                //            //为了提供表格显示性能，已创建完成的单元需重复使用
                //            //同一形式的单元格重复使用，在声明时已注册
                
                cell.orderImage.image = UIImage(named: _data["imagePath"]!)
                cell.sukLabel.text = _data["suk"]
                cell.titleLabel.text = _data["title"]
                cell.priceLabel.text = _data["price"]
                cell.accessoryType = .disclosureIndicator
            }
            return cell
    }
    
    // UITableViewDelegate 方法，处理列表项的选中事件
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let sb = UIStoryboard(name:"Main", bundle: nil)
        let orderView = sb.instantiateViewController(withIdentifier: "OrderDetailViewController") as! OrderDetailViewController
        
        orderView.hidesBottomBarWhenPushed = true
        
        
        let count = self.dataArray.count
        let sectionNo = count - indexPath.row - 1
        var _data = self.dataArray[sectionNo]!
        orderView.navTitle = _data["suk"]
        orderView.order_image = _data["imagePath"]
        orderView.order_price = _data["price"]
        orderView.order_title = _data["title"]
        orderView.actionValue = ""
        
        let selector: Selector = #selector(actionBack)
        setNavBarBackBtn(view: self, title: "订单", selector: selector)
        _push(view: self, target: orderView, rootView: true)
    }
}
