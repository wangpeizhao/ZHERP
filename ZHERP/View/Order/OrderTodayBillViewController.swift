//
//  OrderTodayBillViewController.swift
//  ZHERP
//
//  Created by MrParker on 2018/9/5.
//  Copyright © 2018 MrParker. All rights reserved.
//

import UIKit

class OrderTodayBillViewController: UIViewController, UIGestureRecognizerDelegate {

    var tableView: UITableView!
    let CELL_IDENTIFY_ID = "CELL_IDENTIFY_ID"
    var selectedCellIndexPaths: [IndexPath] = []
    
    let dataArr = [
        ["name":"微信支付-自主", "id":"1", "detail": "\n买家通过微信支付完成交易后，货款将自动结算至商家微信支付账号。(未完成微信公众号支付绑定的不能使用)"],
        ["name":"允许到点自提(需付款)", "id":"2", "detail": "\n买家通过线上下单时，可选择指定的自提店面进行上门提货，需要至少设置一个自提门店才能选择此项"],
        ["name":"允许到点自提(需付款)", "id":"2", "detail": "\n买家通过线上下单时，可选择指定的自提店面进行上门提货，需要至少设置一个自提门店才能选择此项"],
        ["name":"允许到点自提(需付款)", "id":"2", "detail": "\n买家通过线上下单时，可选择指定的自提店面进行上门提货，需要至少设置一个自提门店才能选择此项"],
        ["name":"允许到点自提(需付款)", "id":"2", "detail": "\n买家通过线上下单时，可选择指定的自提店面进行上门提货，需要至少设置一个自提门店才能选择此项"],
        ["name":"允许到点自提(需付款)", "id":"2", "detail": "\n买家通过线上下单时，可选择指定的自提店面进行上门提货，需要至少设置一个自提门店才能选择此项"],
        ["name":"允许到点自提(需付款)", "id":"2", "detail": "\n买家通过线上下单时，可选择指定的自提店面进行上门提货，需要至少设置一个自提门店才能选择此项"],
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavBarTitle(view: self, title: "今日账单")
        setNavBarBackBtn(view: self, title: "今日账单", selector: #selector(actionBack))
        setNavBarRightBtn(view: self, title: "历史账单", selector: #selector(actionHistory))
        
        self._setUp()
        // Do any additional setup after loading the view.
    }
    
    @objc func actionBack() {
        
    }
    
    @objc func actionHistory() {
        let _target = OrderBillsViewController()
        _target.hidesBottomBarWhenPushed = true
        _push(view: self, target: _target, rootView: false)
    }
    
    private func _setUp() {
        //创建表视图
        self.tableView = UITableView(frame: self.view.frame, style: .grouped)
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: CELL_IDENTIFY_ID)
        self.tableView!.register(SimpleBasicsCell.self, forCellReuseIdentifier: SimpleBasicsCell.identifier)
        // 可填写
        self.tableView?.register(UINib(nibName: "OrderTodayBillTableViewCell", bundle: nil), forCellReuseIdentifier: "OrderTodayBillTableViewCell")
        self.tableView!.tableHeaderView = UIView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 20))
//        //表格在编辑状态下允许多选
//        self.tableView!.allowsMultipleSelectionDuringEditing = true
//        self.tableView!.setEditing(true, animated:true)
        self.view.addSubview(self.tableView!)
        
        // 长按启动删除、移动排序功能
        let longPress = UILongPressGestureRecognizer.init(target: self, action: #selector(longPressAction))
        longPress.delegate = self
        longPress.minimumPressDuration = 1
        self.tableView!.addGestureRecognizer(longPress)
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
            _alert(view: self, message: "Copy Success")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


extension OrderTodayBillViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataArr.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ""
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.selectedCellIndexPaths.contains(indexPath) {
            return 150
        }
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    //设置分组头的高度
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        if section == self.dataArr.count - 1 {
            return "今日账单；点击可展开更多；长按复制交易单号。"
        }
        return ""
    }
    
    //设置分组尾的高度
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 30
    }
    
    //创建各单元显示内容(创建参数indexPath指定的单元）
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let _data = dataArr[indexPath.item]
        let cell: OrderTodayBillTableViewCell = tableView.dequeueReusableCell(withIdentifier: "OrderTodayBillTableViewCell") as! OrderTodayBillTableViewCell
        cell.layer.masksToBounds = true
//        cell.textLabel?.text = _data["name"]
//
//        cell.detailTextLabel?.text = _data["detail"]
//        cell.detailTextLabel?.textColor = Specs.color.gray
//
//        cell.detailTextLabel?.frame.origin.y = (cell.detailTextLabel?.frame.origin.y)! + 15
//
//        cell.detailTextLabel?.numberOfLines = 3
        
        return cell
    }
    
    // UITableViewDelegate 方法，处理列表项的选中事件
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView!.deselectRow(at: indexPath, animated: false)
        if let index = self.selectedCellIndexPaths.index(of: indexPath) {
            self.selectedCellIndexPaths.remove(at: index)
        }else{
            self.selectedCellIndexPaths.append(indexPath)
        }
        //强制改变高度
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
}
