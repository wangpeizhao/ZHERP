//
//  SPaymentManagerViewController.swift
//  ZHERP
//
//  Created by MrParker on 2018/9/5.
//  Copyright © 2018 MrParker. All rights reserved.
//

import UIKit

class SPaymentManagerViewController: UIViewController {

    var tableView: UITableView!
    let CELL_IDENTIFY_ID = "CELL_IDENTIFY_ID"
    
    let dataArr = [
        ["name":"微信支付-自主", "id":"1", "detail": "\n买家通过微信支付完成交易后，货款将自动结算至商家微信支付账号。(未完成微信公众号支付绑定的不能使用)"],
        ["name":"允许到点自提(需付款)", "id":"2", "detail": "\n买家通过线上下单时，可选择指定的自提店面进行上门提货，需要至少设置一个自提门店才能选择此项"],
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavBarTitle(view: self, title: "支付设置")
        setNavBarRightBtn(view: self, title: "保存", selector: #selector(actionSave))
        
        self._setUp()
        // Do any additional setup after loading the view.
    }
    
    @objc func actionSave() {
        _back(view: self)
    }
    
    private func _setUp() {
        //创建表视图
        self.tableView = UITableView(frame: self.view.frame, style: .grouped)
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: CELL_IDENTIFY_ID)
        self.tableView!.register(SimpleBasicsCell.self, forCellReuseIdentifier: SimpleBasicsCell.identifier)
        self.tableView!.tableHeaderView = UIView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0.1))
        //表格在编辑状态下允许多选
        self.tableView!.allowsMultipleSelectionDuringEditing = true
        self.tableView!.setEditing(true, animated:true)
        self.view.addSubview(self.tableView!)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension SPaymentManagerViewController: UITableViewDelegate, UITableViewDataSource {
    
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
        return SelectCellHeight * 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    //设置分组头的高度
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "请设置支付方式"
    }
    
    //设置分组尾的高度
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 30
    }
    
    //创建各单元显示内容(创建参数indexPath指定的单元）
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let _data = dataArr[indexPath.item]
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: CELL_IDENTIFY_ID)
        
        cell.textLabel?.text = _data["name"]
        
        cell.detailTextLabel?.text = _data["detail"]
        cell.detailTextLabel?.textColor = Specs.color.gray
        
        cell.detailTextLabel?.frame.origin.y = (cell.detailTextLabel?.frame.origin.y)! + 15
        
        cell.detailTextLabel?.numberOfLines = 3
        
        cell.isSelected = true
        
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

