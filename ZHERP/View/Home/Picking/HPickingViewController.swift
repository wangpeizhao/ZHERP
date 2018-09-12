//
//  HPickingViewController.swift
//  ZHERP
//
//  Created by MrParker on 2018/9/8.
//  Copyright © 2018 MrParker. All rights reserved.
//

import UIKit
import MJRefresh
import SnapKit

class HPickingViewController: UIViewController , UIGestureRecognizerDelegate{
    
    var tableView: UITableView!
    let CELL_IDENTIFY_ID = "CELL_IDENTIFY_ID"
    var navHeight: CGFloat!
    var tabBarHeight: CGFloat!
    
    // 合计总价
    var _totalValue: UILabel!
    // 合计数量
    var _quantityValue: UILabel!
    
    var _HPickingView: HPickingView!
    
    var _tabBarCartView: UIView!
    // 阴影
    var cover: UIView!
    
    // 初始数据
    var valueArr = [String: String]()
    
    // 顶部刷新
    let header = MJRefreshNormalHeader()
    
    
    
    var dataArr : [Int: [String:String]] = [
        0: ["sn": "2018090612344519995",
         "suk": "CD_PPC01",
         "avatar": "bayMax",
         "warehouse": "深圳仓库",
         "price": "80000.88",
         "total": "987452.00",
         "quantity": "12",
         "stock": "5600",
         "name": "六神花露水001",
         "title": "美的（Midea）电饭煲 气动涡轮防溢 金属机身 圆灶釜内胆4L电饭锅MB-WFS4037",
        "cost": "2350.00", "location": "广州白马3434", "status": "-1"],
        1: ["sn": "2018090612344519995",
         "suk": "CD_PPC02",
         "avatar": "swift",
         "warehouse": "深圳仓库",
         "price": "80000.88",
         "total": "987452.00",
         "quantity": "12",
         "stock": "5600",
         "name": "六神花露水002",
         "title": "美的（Midea）电饭煲 气动涡轮防溢 金属机身 圆灶釜内胆4L电饭锅MB-WFS4037",
        "cost": "2350.00", "location": "广州白马3434", "status": "-1"],
        2: ["sn": "2018090612344519995",
         "suk": "CD_PPC03",
         "avatar": "php",
         "warehouse": "深圳仓库",
         "price": "80000.88",
         "total": "987452.00",
         "quantity": "12",
         "stock": "5600",
         "name": "六神花露水003",
         "title": "美的（Midea）电饭煲 气动涡轮防溢 金属机身 圆灶釜内胆4L电饭锅MB-WFS4037",
        "cost": "2350.00", "location": "广州白马3434", "status": "-1"],
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("HPickingViewController:->viewDidLoad()")
        
        self.view.backgroundColor = Specs.color.white
        setNavBarTitle(view: self, title: "正在拣货")
        setNavBarBackBtn(view: self, title: "", selector: #selector(actionBack))
        
        // 设置右侧按钮1(扫码)
        let rightBarBtnScan = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(actionScan))
        rightBarBtnScan.image = UIImage(named: "scan")
        rightBarBtnScan.tintColor = Specs.color.white
        
        // 设置右侧按钮2(筛选)
        let rightBarBtnRefresh = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(actionEdit))
        rightBarBtnRefresh.image = UIImage(named: "edit")
        rightBarBtnRefresh.tintColor = Specs.color.white
        self.navigationItem.rightBarButtonItems = [rightBarBtnScan,rightBarBtnRefresh]
        
        self._setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("HPickingViewController:->viewWillAppear()")
        super.viewWillAppear(animated)
        
        self.tableView.reloadData()
    }
    
    @objc func actionEdit() {
        self.cover.isHidden = false
        self._tabBarCartView.isHidden = false
    }
    
    @objc func actionClose() {
        self._tabBarCartView.isHidden = true
    }
    
    @objc func actionSave() {
        
    }
    
    @objc func actionBack() {
        
    }
    
    @objc func actionScan() {
        let _ZHQRCode = ZHQRCodeViewController()
        _ZHQRCode.actionType = "picking"
        _push(view: self, target: _ZHQRCode, rootView: false)
    }
    
    @objc func actionRefresh() {
        self.tableView!.mj_header.beginRefreshing()
//        self.tableView.reloadData()
    }
    
    @objc func actionCart() {
        if self.valueArr["total"]! == "0.00" || Int(self.valueArr["quantity"]!)! == 0 {
            _alert(view: self, message: "购物车还是空呢，请先拣货")
            return
        }
        let _target = HPickingCompleteViewController()
        _push(view: self, target: _target, rootView: false)
    }
    
    @objc func actionSearch() {
        let _target = SearchViewController()
        _target.navBarTitle = "搜索货品"
        _target.searchBarPlaceholder = "按货品名称或编号搜索"
        _target.searchType = "picking"
        _push(view: self, target: _target, rootView: false)
    }
    
    @objc func clickedMoreBtn(_ sender: UIButton) {
        
    }
    // 方法
    @objc func tapCover(_ tapCover : UITapGestureRecognizer){
        self.cover.isHidden = true
        self._tabBarCartView.isHidden = true
    }
    
    @objc func longPressAction(recognizer: UILongPressGestureRecognizer)  {
        if recognizer.state == UIGestureRecognizerState.began {
            print("UIGestureRecognizerStateBegan");
        }
        if recognizer.state == UIGestureRecognizerState.changed {
            print("UIGestureRecognizerStateChanged");
        }
        if recognizer.state == UIGestureRecognizerState.ended {
            print("UIGestureRecognizerStateEnded");
            // tableView.isEditing = !tableView.isEditing
            if tableView.isEditing == true {
                tableView.isEditing = false
            } else {
                // tableView.isEditing = true
//                setNavBarRightBtn(view: self, title: "保存", selector: #selector(actionSave))
                self.setEditing(true,animated: true)
            }
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
    
    //初始化数据
    func refreshItemData(append: Bool) {
        let count = self.dataArr.count
        let imagePaths = ["java","php","html","react","ruby","swift","xcode","bayMax","c#"]
        for i in 0...2 {
            let index = arc4random_uniform(UInt32(imagePaths.count))
            let _imagePath = imagePaths[Int(index)]
            self.dataArr[count + i] = ["avatar": _imagePath,
                                       "sn": "2018090612344519995",
                                       "suk": "AB_PPC\(count + i)",
                "warehouse": "深圳仓库",
                "price": "80000.88",
                "total": "987452.00",
                "quantity": "12",
                "stock": "5600",
                "name": "六神花露水003",
                "title": "美的（Midea）电饭煲 气动涡轮防溢 金属机身 圆灶釜内胆4L电饭锅MB-WFS4037",
                "cost": "2350.00", "location": "广州白马3434", "status": "-1"]
        }
    }
    
    fileprivate func initData() {
        if self.valueArr.count == 0 {
            self.valueArr = [
                "quantity": "12",
                "total": "56740.00"
            ]
        }
    }
    
    fileprivate func _setup() {
        self.navHeight = self.navigationController?.navigationBar.frame.maxY
        self.tabBarHeight = self.tabBarController?.tabBar.bounds.size.height
        
        self.initData()
        
        searchBarBtn(view: self, navHeight: self.navHeight, placeholder: "按货品名称或编号搜索", action: #selector(actionSearch))
        
        self._HPickingView = HPickingView()
        _HPickingView.tabBarHeight = self.tabBarHeight
        self.addChildViewController(_HPickingView)
        
        let _frame = CGRect(x: 0, y: self.navHeight + SearchBtnHeight, width: ScreenWidth, height: ScreenHeight - self.navHeight - self.tabBarHeight - SearchBtnHeight)
        self.tableView = UITableView(frame: _frame, style: .grouped)
        
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: CELL_IDENTIFY_ID)
        self.tableView!.register(SimpleBasicsCell.self, forCellReuseIdentifier: SimpleBasicsCell.identifier)
        self.tableView?.register(UINib(nibName: "GoodTableViewCell", bundle: nil), forCellReuseIdentifier: CELL_IDENTIFY_ID)
        self.tableView!.tableHeaderView = UIView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0.1))
        self.view.addSubview(self.tableView!)
        
        // 长按启动删除、移动排序功能
        let longPress = UILongPressGestureRecognizer.init(target: self, action: #selector(longPressAction))
        longPress.delegate = self
        longPress.minimumPressDuration = 1
        self.tableView!.addGestureRecognizer(longPress)
        
        //下拉刷新相关设置
        self.header.setTitle("下拉可以刷新", for: .idle)
        self.header.setTitle("松开立即刷新", for: .pulling)
        self.header.setTitle("正在刷新数据...", for: .refreshing)
        self.header.lastUpdatedTimeLabel.text = "最后更新"
        self.header.setTitle("没有更多数据啦~", for: .noMoreData)
        self.header.setRefreshingTarget(self, refreshingAction: #selector(OrderAllViewController.headerRefresh))
        self.tableView!.mj_header = self.header
        
        self.cover = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight))
        self.cover.backgroundColor = normalRGBA(r: 0, g: 0, b: 0, a: 0.3)
        self.cover.isHidden = true
        self.view.addSubview(self.cover)
        
        // 弹出阴影层 手势
        let tapCover = UITapGestureRecognizer(target: self, action: #selector(tapCover(_:)))
        self.cover.addGestureRecognizer(tapCover)
        
        self._setTabBarCart()
        // Do any additional setup after loading the view.
    }
    
    fileprivate func _setTabBarCart() {
        // tabBarView
        let _tabBarView = UIView()
        _tabBarView.backgroundColor = UIColor.orange
        self.view.addSubview(_tabBarView)
        _tabBarView.snp.makeConstraints { (make) -> Void in
            make.left.right.equalTo(0)
            make.bottom.equalTo(0)
            make.height.equalTo(self.tabBarHeight)
            make.width.equalTo(ScreenWidth)
        }
        
        let _HPickingView = self._HPickingView.cartDetailView(cartData: self.valueArr)
        _tabBarView.addSubview(_HPickingView)
        self._HPickingView._submitAdd.addTarget(self, action: #selector(actionCart), for: .touchUpInside)
        
        self._tabBarCartView = UIView()
        self.view.addSubview(self._tabBarCartView)
        self._tabBarCartView.snp.makeConstraints { (make) -> Void in
            make.left.right.equalTo(0)
            make.bottom.equalTo(_tabBarView.snp.top).offset(-250)
            make.height.equalTo(self.tabBarHeight * 2)
            make.width.equalTo(ScreenWidth)
        }
        let _HPickingCartEditView = self._HPickingView.cartEditView(cartData: self.valueArr)
        self._HPickingView._cartCancelBtn.addTarget(self, action: #selector(actionClose), for: .touchUpInside)
        self._tabBarCartView.isHidden = true
        self._tabBarCartView.backgroundColor = UIColor.orange
        self._tabBarCartView.addSubview(_HPickingCartEditView)
    }
//
//    public func _reloadData() {
//        self.tableView!.reloadData()
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension HPickingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArr.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ""
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    //设置分组头的高度
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "点击编辑按钮可修改总价；长按或向左滑可删除。"
    }
    
    //设置分组尾的高度
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return self.dataArr.count == 0 ? 0 : 30
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    //创建各单元显示内容(创建参数indexPath指定的单元）
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let count = self.dataArr.count
        let sectionNo = count - indexPath.row - 1
        
        let cell: GoodTableViewCell = tableView.dequeueReusableCell(withIdentifier: CELL_IDENTIFY_ID, for: indexPath) as! GoodTableViewCell
        if !(self.dataArr[sectionNo]?.isEmpty)! {
            var _data = self.dataArr[sectionNo]!
            
            cell.avatar.image = UIImage(named: _data["avatar"]!)
            cell.suk.text = _data["suk"]
            cell.name.text = _data["name"]
            cell.stock.text = _data["stock"]
            cell.cost.text = _data["cost"]
            cell.location.text = _data["location"]
            cell.price.text = _data["price"]
            cell.accessoryType = .disclosureIndicator
        }
        cell.tag = indexPath.row
        cell.moreBtn.tag = indexPath.row
        cell.moreBtn.addTarget(self, action: #selector(clickedMoreBtn(_:)), for: .touchUpInside)
        
        return cell
    }
    
    // UITableViewDelegate 方法，处理列表项的选中事件
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
//        let _data = self.dataArr[indexPath.item]
        
//        let _target = HAllocatingViewController()
//        _target.navTitle = "调货记录"
//        _target.valueArr = [
////            "id": _data["id"],
//            "orderId": _data["orderId"],
//            "sn": "ZHG20180908123456987",
//            "name": "汤臣倍健多种维生素",
//            "warehouse": "广州仓库",
//            "wId": "2",
//            "transferred": "深圳仓库",
//            "quantity": "100",
//            "outWarehouse": "10000",
//            "inWarehouse": "200",
//            "employees": "王培照",
//            "datetime": _data["datetime"]
//            ] as! [String : String]
//        
//        _push(view: self, target: _target, rootView: false)
    }
}
