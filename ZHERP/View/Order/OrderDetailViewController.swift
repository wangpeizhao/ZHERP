//
//  OrderDetailViewController.swift
//  ZHERP
//
//  Created by MrParker on 2018/7/15.
//  Copyright © 2018 MrParker. All rights reserved.
//

import UIKit

enum orderStatus {
    case active // 未付款
    case cancel // 已取消
    case paid // 已付款
    case delivered // 已发货
    case refund // 已退货
}

struct orderStatusTxt {
    var statusTxt: String
    init(status: orderStatus) {
        switch status {
        case .active:
            self.statusTxt = "未付款"
        case .cancel:
            self.statusTxt = "已取消"
        case .paid:
            self.statusTxt = "已付款"
        case .delivered:
            self.statusTxt = "已发货"
        case .refund:
            self.statusTxt = "已退货"
        }
    }
}

class OrderDetailViewController: UIViewController {
    
    var tableView: UITableView!
    let CELL_IDENTIFY_ID = "CELL_IDENTIFY_ID"
    
    // 初始数据
    var valueArr = [String: String]()
    
    // 字段数据
    var dataArr = [[String: Any]]()
    
    // 数据model
    var _initData: OrderModel?
    
    var _orderStatus: orderStatus?
    
    var orderType: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(hex: 0xf7f7f7)
        setNavBarTitle(view: self, title: "订单详情")
        setNavBarBackBtn(view: self, title: "", selector: #selector(actionBack))
        
        self._setup()
        
        // Do any additional setup after loading the view.
    }
    
    @objc func actionBack()->Void {
        _back(view: self)
    }
    
    @objc func actionCollection() {
        let _target = HPickingCompleteViewController()
        _target.navTitle = "订单收款"
        _push(view: self, target: _target, rootView: false)
    }
    
    @objc func actionDeliver() {
        let _target = HDeliveringViewController()
        _push(view: self, target: _target, rootView: false)
    }
    
    @objc func actionRefund() {
        _confirm(view: self, title: "提示", message: "此操作只是更改该订单状态为‘已退款’，并不会产生资金流动；请直接与顾客协商处理资金问题。", handler: actionChangeStatus)
    }
    
    func actionChangeStatus(alert: UIAlertAction) {
        _tip(view: self, title: "订单状态更改成功")
    }
    
    private func _setup() {
        self.initData()
        //创建表视图
        self.tableView = UITableView(frame: self.view.frame, style: .grouped)
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: CELL_IDENTIFY_ID)
        self.tableView!.register(SimpleBasicsCell.self, forCellReuseIdentifier: SimpleBasicsCell.identifier)
        self.tableView?.register(UINib(nibName: "OrderDetailTableViewCell", bundle: nil), forCellReuseIdentifier: CELL_IDENTIFY_ID)
        
        self.tableView?.tableHeaderView = UIView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0.01))
        self.view.addSubview(self.tableView!)
    }
    
    private func initData() {
        
//        let dateTime = dateFromString(SYSTEM_DATETIME, format: "yyyy-MM-dd HH:mm:ss")!
        
        self._initData = OrderModel(orderId: "", orderTime: "", orderStatus: "", orderTotal: "", orderCoupon: "", orderAmount: "", orderQuantity: "", orderEmployee: "", receiver: "", receiverPhone: "", receiverRegion: "", receiverDetail: "", expressCompany: "", expressNumber: "", expressNote: "", expressEmployee: "", expressDatetime: "")
        
        if self.valueArr["orderType"] != nil {
            self.orderType = self.valueArr["orderType"]
        }
        
        if self.valueArr["orderTime"] == nil {
            self.valueArr["orderTime"] = SYSTEM_DATETIME
        }
        if self.valueArr["expressDatetime"] == nil {
            self.valueArr["expressDatetime"] = SYSTEM_DATETIME
        }
        self._initData?.orderId = self.valueArr["orderId"] != nil ? self.valueArr["orderId"]! : ""
        self._initData?.orderTime = self.valueArr["orderTime"] != nil ? self.valueArr["orderTime"]! : ""
        self._initData?.orderStatus = self.valueArr["orderStatus"] != nil ? self.valueArr["orderStatus"]! : "paid"
        self._initData?.orderTotal = self.valueArr["orderTotal"] != nil ? self.valueArr["orderTotal"]! : ""
        self._initData?.orderTotal = self.valueArr["orderTotal"] != nil ? self.valueArr["orderTotal"]! : ""
        self._initData?.orderCoupon = self.valueArr["orderCoupon"] != nil ? self.valueArr["orderCoupon"]! : ""
        self._initData?.orderAmount = self.valueArr["orderAmount"] != nil ? self.valueArr["orderAmount"]! : ""
        self._initData?.orderQuantity = self.valueArr["orderQuantity"] != nil ? self.valueArr["orderQuantity"]! :"0"
        self._initData?.orderEmployee = self.valueArr["orderEmployee"] != nil ? self.valueArr["orderEmployee"]! : ""
        self._initData?.receiver = self.valueArr["receiver"] != nil ? self.valueArr["receiver"]! : ""
        self._initData?.receiverPhone = self.valueArr["receiverPhone"] != nil ? self.valueArr["receiverPhone"]! : ""
        self._initData?.receiverRegion = self.valueArr["receiverRegion"] != nil ? self.valueArr["receiverRegion"]! : ""
        self._initData?.receiverDetail = self.valueArr["receiverDetail"] != nil ? self.valueArr["receiverDetail"]! : ""
        self._initData?.expressCompany = self.valueArr["expressCompany"] != nil ? self.valueArr["expressCompany"]! : ""
        self._initData?.expressNumber = self.valueArr["expressNumber"] != nil ? self.valueArr["expressNumber"]! : ""
        self._initData?.expressNote = self.valueArr["expressNote"] != nil ? self.valueArr["expressNote"]! : ""
        self._initData?.expressEmployee = self.valueArr["expressEmployee"] != nil ? self.valueArr["expressEmployee"]! : ""
        self._initData?.expressDatetime = self.valueArr["expressDatetime"] != nil ? self.valueArr["expressDatetime"]! : ""

        // 订单状态
        self._setOrderStatus(status: (self._initData?.orderStatus)!)
        self._setRightActionBtn(status: self._orderStatus!)
        let _orderStatusTxt = orderStatusTxt(status: self._orderStatus!)
        setNavBarTitle(view: self, title: "订单详情(\(_orderStatusTxt.statusTxt))")
        
        let orderDetails = [
            ["title": "咕噜咕噜电风扇", "sn": "ZH12343434224", "price": "123.45", "quantity": "100"],
            ["title": "咕噜咕噜充电宝", "sn": "ZH12345645657", "price": "234223", "quantity": "90"],
            ["title": "咕噜咕噜饮水杯", "sn": "ZH14634345466", "price": "167.05", "quantity": "1"],
            ["title": "咕噜咕噜羊肉串", "sn": "ZH10045040545", "price": "983.00", "quantity": "2"],
            ["title": "咕噜咕噜采芝纸巾", "sn": "ZH24344566776", "price": "188.40", "quantity": "7"],
        ]
        
        self.dataArr = [
            [
                "title": "订单信息",
                "rows": [
                    ["title":"订单编号", "key":"orderId", "value": self._initData?.orderId],
                    ["title":"订单时间", "key":"orderTime", "value": self._initData?.orderTime],
                    ["title":"订单总额", "key":"orderTotal", "value": self._initData?.orderTotal],
                    ["title":"优惠金额", "key":"orderCoupon", "value": self._initData?.orderCoupon],
                    ["title":"实收金额", "key":"orderAmount", "value": self._initData?.orderAmount],
                    ["title":"订单数量", "key":"orderQuantity", "value": self._initData?.orderQuantity],
                    ["title":"收款员工", "key":"orderEmployee", "value": self._initData?.orderEmployee],
                ]
            ],
            [
                "title": "订单明细",
                "rows": orderDetails
            ],
            [
                "title": "收件人",
                "rows": [
                    ["title":"收件人", "key":"receiver", "value": self._initData?.receiver],
                    ["title":"收件电话", "key":"receiverPhone", "value": self._initData?.receiverPhone],
                    ["title":"收件地区", "key":"receiverRegion", "value": self._initData?.receiverRegion],
                    ["title":"详细地址", "key":"receiverDetail", "value": self._initData?.receiverDetail],
                ]
            ],
            [
                "title": "快递信息",
                "rows": [
                    ["title":"快递公司", "key":"expressCompany", "value": self._initData?.expressCompany],
                    ["title":"快递单号", "key":"expressNumber", "value": self._initData?.expressNumber],
                    ["title":"备注", "key":"expressNote", "value": self._initData?.expressNote]
                ]
            ],
            [
                "title": "发件信息",
                "rows": [
                    ["title":"发件员工", "key":"expressEmployee", "value": self._initData?.expressEmployee],
                    ["title":"发件时间", "key":"expressDatetime", "value": self._initData?.expressDatetime]
                ]
            ],
        ]
        
        if self._orderStatus == .active {
            self.dataArr.removeAt(indexes: [3, 4])
        }
    }
    
    fileprivate func _setOrderStatus(status: String) {
        switch status {
        case "active":
            self._orderStatus = .active
        case "cancel":
            self._orderStatus = .cancel
        case "paid":
            self._orderStatus = .paid
        case "delivered":
            self._orderStatus = .delivered
        case "refund":
            self._orderStatus = .refund
        default:
            break
        }
    }
    
    fileprivate func _setRightActionBtn(status: orderStatus) {
        switch status {
        case .active:
            setNavBarRightBtn(view: self, title: "收款", selector: #selector(actionCollection))
        case .cancel:
            break
        case .paid:
            if self.orderType == "refund" {
                setNavBarRightBtn(view: self, title: "确定退款", selector: #selector(actionRefund))
            } else {
                setNavBarRightBtn(view: self, title: "发货", selector: #selector(actionDeliver))
            }
        case .delivered:
            break
        case .refund:
            break
        }
    }
    
    fileprivate func _rowsModel(at section: Int) -> [Any] {
        return self.dataArr[section]["rows"] as! [Any]
    }
    
    fileprivate func _rowModel(at indexPath: IndexPath) -> [String: String] {
        return self._rowsModel(at: indexPath.section)[indexPath.row] as! [String : String]
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        self.navigationController?.setToolbarHidden(true, animated: false)
//        
//    }
//    
//    override func viewWillDisappear(_ animated: Bool) {
//        self.navigationController?.setToolbarHidden(false, animated: false)
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension OrderDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataArr.count;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self._rowsModel(at: section).count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return (self.dataArr[section]["title"]! as! String)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 1 ? SelectCellHeight + 10 : SelectCellHeight
    }
    
    //设置分组头的高度
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return ""
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section != self.dataArr.count - 1 {
            return UIView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0.01))
        }
        let memberView = UIView()
        memberView.backgroundColor = UIColor.clear
        
        let _btn = UIButton(frame: CGRect(x: 20, y: 20, width: ScreenWidth - 40, height: 40))
        _btn.layer.cornerRadius = Specs.border.radius
        _btn.layer.masksToBounds = true
        _btn.titleLabel?.font = UIFont.systemFont(ofSize: Specs.fontSize.regular)

        _btn.setTitle("返回", for: .normal)
        _btn.setTitleColor(Specs.color.black, for: UIControlState())
        _btn.backgroundColor = Specs.color.white
        _btn.layer.borderWidth = 1
        _btn.layer.borderColor = UIColor(hex: 0xdddddd).cgColor //UIColor.lightGray.cgColor
        _btn.addTarget(self, action: #selector(actionBack), for: .touchUpInside)
        
        memberView.addSubview(_btn)
        
        return memberView
    }
    
    //设置分组尾的高度
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == self.dataArr.count - 1 {
            return 80
        }
        return 0
    }
    
    //创建各单元显示内容(创建参数indexPath指定的单元）
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let _row = self._rowModel(at: indexPath)
//        let key: String = _row["key"]!
        
        if indexPath.section == 1 {
            let cell: OrderDetailTableViewCell = tableView.dequeueReusableCell(withIdentifier: CELL_IDENTIFY_ID, for: indexPath) as! OrderDetailTableViewCell
            cell.titleLabel.text = _row["title"]
            cell.titleLabel.sizeToFit()
            cell.priceLabel.text = "单价/数量：" + _row["price"]! + "/" + _row["quantity"]!
            cell.priceLabel.sizeToFit()
            cell.accessoryType = .none
            return cell
        }
        var cell = UITableViewCell()
        cell = tableView.dequeueReusableCell(withIdentifier: SimpleBasicsCell.identifier, for: indexPath)
        cell.textLabel?.text = _row["title"]
        cell.textLabel?.font = Specs.font.regular
        
        cell.detailTextLabel?.text = _row["value"]
        
        cell.detailTextLabel?.font = Specs.font.regular
        
        cell.accessoryType = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
