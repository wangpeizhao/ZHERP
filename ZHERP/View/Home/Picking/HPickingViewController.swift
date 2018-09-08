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

class HPickingViewController: UIViewController {
    
    var tableView: UITableView!
    let CELL_IDENTIFY_ID = "CELL_IDENTIFY_ID"
    var navHeight: CGFloat!
    var tabBarHeight: CGFloat!
    
    // 合计总价
    var _totalValue: UILabel!
    // 合计数量
    var _quantityValue: UILabel!
    
    // 顶部刷新
    let header = MJRefreshNormalHeader()
    
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
        setNavBarTitle(view: self, title: "正在拣货")
        setNavBarBackBtn(view: self, title: "", selector: #selector(actionBack))
        
        // 设置右侧按钮1(扫码)
        let rightBarBtnScan = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(actionScan))
        rightBarBtnScan.image = UIImage(named: "scan")
        rightBarBtnScan.tintColor = Specs.color.white
        
        // 设置右侧按钮2(筛选)
        let rightBarBtnRefresh = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(actionRefresh))
        rightBarBtnRefresh.image = UIImage(named: "refresh")
        rightBarBtnRefresh.tintColor = Specs.color.white
        self.navigationItem.rightBarButtonItems = [rightBarBtnScan,rightBarBtnRefresh]
        
        self._setup()
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
        _ZHQRCode.actionType = "picking"
        _push(view: self, target: _ZHQRCode, rootView: false)
    }
    
    @objc func actionRefresh() {
        self.tableView!.mj_header.beginRefreshing()
//        self.tableView.reloadData()
    }
    
    @objc func actionCart() {
        if self._totalValue.text == "0" || self._quantityValue.text == "0" {
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
    
    fileprivate func _setup() {
        self.navHeight = self.navigationController?.navigationBar.frame.maxY
        self.tabBarHeight = self.tabBarController?.tabBar.bounds.size.height
        
        searchBarBtn(view: self, navHeight: self.navHeight, placeholder: "按货品名称或编号搜索", action: #selector(actionSearch))
        
        let _frame = CGRect(x: 0, y: self.navHeight + SearchBtnHeight, width: ScreenWidth, height: ScreenHeight - self.navHeight - self.tabBarHeight)
        self.tableView = UITableView(frame: _frame, style: .grouped)
        
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
        
        
        self._setTabBarCart()
        // Do any additional setup after loading the view.
    }
    
    fileprivate func _setTabBarCart() {
        // 购物车View
        let _cartView = UIView()
        _cartView.backgroundColor = Specs.color.white
        self.view.addSubview(_cartView)
        _cartView.snp.makeConstraints { (make) -> Void in
            make.left.right.equalTo(0)
            make.bottom.equalTo(0)
            make.height.equalTo(self.tabBarHeight)
            make.width.equalTo(ScreenWidth)
        }
        
        // 总价view
        let _cartDetailView = UIView()
        self.view.addSubview(_cartDetailView)
        _cartDetailView.snp.makeConstraints { (make) -> Void in
            make.left.bottom.equalTo(0)
            make.height.equalTo(self.tabBarHeight)
            make.width.equalTo(ScreenWidth / 3 * 2)
        }
        
        // Separator
        let _separator = UILabel()
        _separator.backgroundColor = Specs.color.gray
        _cartDetailView.addSubview(_separator)
        _separator.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(_cartDetailView.snp.top)
            make.left.right.equalTo(0)
            make.width.equalTo(_cartDetailView.snp.width)
            make.height.equalTo(1)
        }
        
        // cart
        let _cartShopping = UIView()
        _cartShopping.backgroundColor = UIColor(patternImage: UIImage(named:"cart")!)
        _cartDetailView.addSubview(_cartShopping)
        _cartShopping.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(10)
            make.top.equalTo(_cartDetailView.snp.top).offset(2)
            make.width.height.equalTo(48)
        }
        
        // Quantity View
        let _width = 25.0
        let _cartQuantityView = UIView()
        _cartQuantityView.backgroundColor = UIColor.red
        _cartQuantityView.layer.cornerRadius = CGFloat(_width / 2)
        _cartQuantityView.layer.masksToBounds = true
        _cartShopping.addSubview(_cartQuantityView)
        _cartQuantityView.snp.makeConstraints { (make) -> Void in
            make.right.equalTo(10)
            make.top.equalTo(_cartDetailView.snp.top).offset(-5)
            make.width.height.equalTo(_width)
        }
        
        // Quantity Value
        self._quantityValue = UILabel()
        self._quantityValue.text = "10"
        self._quantityValue.sizeToFit()
        self._quantityValue.textAlignment = .center
        self._quantityValue.font = Specs.font.regular
        self._quantityValue.textColor = Specs.color.white
        _cartQuantityView.addSubview(self._quantityValue)
        self._quantityValue.snp.makeConstraints { (make) -> Void in
            make.center.equalTo(_cartQuantityView)
        }
        
        // 总价 Label
        let _totalLabel = UILabel()
        _totalLabel.text = "合计：￥"
        _totalLabel.sizeToFit()
        _totalLabel.textAlignment = .left
        _totalLabel.font = Specs.font.regular
        _totalLabel.textColor = Specs.color.black
        _cartDetailView.addSubview(_totalLabel)
        _totalLabel.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(_cartShopping.snp.right).offset(30)
            make.centerY.equalTo(_cartDetailView)
            make.height.equalTo(20)
        }
        
        // 总价 Value
        self._totalValue = UILabel()
        self._totalValue.text = "0.00"
        self._totalValue.sizeToFit()
        self._totalValue.textAlignment = .left
        self._totalValue.font = UIFont.systemFont(ofSize: 25.0)
        self._totalValue.textColor = Specs.color.black
        _cartDetailView.addSubview(self._totalValue)
        self._totalValue.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(_totalLabel.snp.right).offset(0)
            make.centerY.equalTo(_cartDetailView)
            make.height.equalTo(20)
        }
        
        // 提交按钮View
        let _cartBtnView = UIView()
        self.view.addSubview(_cartBtnView)
        _cartBtnView.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(_cartDetailView.snp.right)
            make.right.bottom.equalTo(0)
            make.height.equalTo(self.tabBarHeight)
            make.width.equalTo(ScreenWidth / 3 - 1)
        }
        
        // Btn
        let _btn = UIButton()
        _btn.setTitle("提 交", for: .normal)
        _btn.setTitleColor(Specs.color.white, for: UIControlState())
        _btn.backgroundColor = Specs.color.main
        _btn.addTarget(self, action: #selector(actionCart), for: .touchUpInside)
        _cartBtnView.addSubview(_btn)
        _btn.snp.makeConstraints { (make) -> Void in
            make.left.right.bottom.equalTo(0)
            make.width.equalTo(_cartBtnView.snp.width)
            make.height.equalTo(_cartBtnView.snp.height)
        }
        
    }

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
