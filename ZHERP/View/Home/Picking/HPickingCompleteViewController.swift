//
//  HPickingCompleteViewController.swift
//  ZHERP
//
//  Created by MrParker on 2018/9/8.
//  Copyright © 2018 MrParker. All rights reserved.
//

import UIKit

class HPickingCompleteViewController: UIViewController {

    var tableView: UITableView!
    let CELL_IDENTIFY_ID = "CELL_IDENTIFY_ID"
    var navHeight: CGFloat!
    var tabBarHeight: CGFloat!
    
    // 初始数据
    var valueArr = [String: String]()
    
    var _HPickingCompleteView: HPickingCompleteView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = Specs.color.white
        setNavBarTitle(view: self, title: "完成拣货")
        setNavBarBackBtn(view: self, title: "", selector: #selector(actionBack))
        
        // 设置右侧按钮
        let rightBarBtnRefresh = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(actionRefresh))
        rightBarBtnRefresh.image = UIImage(named: "refresh")
        rightBarBtnRefresh.tintColor = Specs.color.white
        self.navigationItem.rightBarButtonItems = [rightBarBtnRefresh]
        
        self._setup()
        // Do any additional setup after loading the view.
    }
    
    @objc func actionBack() {
        
    }
    
    @objc func actionRefresh() {
        
    }
    
    @objc func actionSubmitAdd() {
        
    }
    
    fileprivate func _setup() {
        self.navHeight = self.navigationController?.navigationBar.frame.maxY
        self.tabBarHeight = self.tabBarController?.tabBar.bounds.size.height
        
        let _frame = CGRect(x: 0, y: self.navHeight, width: ScreenWidth, height: ScreenHeight - self.navHeight - self.tabBarHeight)
        self.tableView = UITableView(frame: _frame, style: .grouped)
        
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: CELL_IDENTIFY_ID)
        self.tableView!.tableHeaderView = UIView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0.1))
        self.view.addSubview(self.tableView!)
        
        self._setUp()
    }
    
    fileprivate func _setUp() {
        self.initData()
        
        self._HPickingCompleteView = HPickingCompleteView()
        self._HPickingCompleteView.frameHeight = ScreenHeight - self.navHeight - self.tabBarHeight
    }
    
    fileprivate func initData() {
        if self.valueArr.count == 0 {
            self.valueArr = [
                "orderId": "201809101454560090",
                "orderTime": "2018-09-10 14:54:56",
                "total": "56740.00"
            ]
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension HPickingCompleteViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let _mainView = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight))
        
        _mainView.addSubview(self._HPickingCompleteView.mainView(initData: self.valueArr))
        return _mainView
    }
    
    //设置分组头的高度
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return (ScreenWidth - 80) / 2 + 220
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "付款成功后直接进入店主微信/支付宝账户"
    }
    
    //设置分组尾的高度
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 30
    }
    
    //创建各单元显示内容(创建参数indexPath指定的单元）
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: CELL_IDENTIFY_ID)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

