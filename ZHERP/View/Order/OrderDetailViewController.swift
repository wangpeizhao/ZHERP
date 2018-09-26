//
//  OrderDetailViewController.swift
//  ZHERP
//
//  Created by MrParker on 2018/7/15.
//  Copyright © 2018 MrParker. All rights reserved.
//

import UIKit

class OrderDetailViewController: UIViewController {
    
    var tableView: UITableView!
    let CELL_IDENTIFY_ID = "CELL_IDENTIFY_ID"
    var navTitle: String!
    
    // 初始数据
    var valueArr = [String: String]()
    
    // 回调赋值
    var callBackAssign: assignArrayClosure?
    
    // 字段数据
    var dataArr = [[String: Any]]()
    
    // 数据model
    var _initData: HAllocatingModel?
    
    // 是否是添加货品调配
    var _isAdd: Bool!
    
    // 添加时选择入仓的仓库名称
    var warehouseName: String = ""
    
    // 添加时选择入仓仓库的库存
    var warehouseStock: String = ""
    
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
    
    private func _setup() {
        self.initData()
        //创建表视图
        self.tableView = UITableView(frame: self.view.frame, style: .grouped)
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: CELL_IDENTIFY_ID)
        self.tableView!.register(SimpleBasicsCell.self, forCellReuseIdentifier: SimpleBasicsCell.identifier)
        
        self.tableView?.tableHeaderView = UIView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0.01))
        self.view.addSubview(self.tableView!)
    }
    
    private func initData() {
        self._isAdd = self.valueArr["datetime"] == nil
        
        self._initData = HAllocatingModel(id: 0, orderId: "", sn: "", name: "", warehouse: "", wId: 0, transferred: "", quantity: "", outWarehouse: "", inWarehouse: "", employee: "", datetime: dateFromString(SYSTEM_DATETIME, format: "yyyy-MM-dd HH:mm:ss")!)
        
        if self.valueArr["datetime"] == nil {
            self.valueArr["datetime"] = SYSTEM_DATETIME
        }
        self._initData?.id = self.valueArr["id"] != nil ? Int(self.valueArr["id"]!)! : 0
        self._initData?.orderId = self.valueArr["orderId"] != nil ? self.valueArr["orderId"]! : ""
        self._initData?.sn = self.valueArr["sn"] != nil ? self.valueArr["sn"]! : ""
        self._initData?.name = self.valueArr["name"] != nil ? self.valueArr["name"]! : ""
        self._initData?.warehouse = self.valueArr["warehouse"] != nil ? self.valueArr["warehouse"]! : ""
        self._initData?.wId = self.valueArr["wId"] != nil ? Int(self.valueArr["wId"]!)! : 0
        self._initData?.transferred = self.valueArr["transferred"] != nil ? self.valueArr["transferred"]! : "未选择"
        self._initData?.quantity = self.valueArr["quantity"] != nil ? self.valueArr["quantity"]! : ""
        self._initData?.outWarehouse = self.valueArr["outWarehouse"] != nil ? self.valueArr["outWarehouse"]! : "0"
        self._initData?.inWarehouse = self.valueArr["inWarehouse"] != nil ? self.valueArr["inWarehouse"]! : "0"
        self._initData?.employee = self.valueArr["employee"] != nil ? self.valueArr["employee"]! : "0"
        self._initData?.datetime = dateFromString(self.valueArr["datetime"]!, format: "yyyy-MM-dd HH:mm:ss")!
        
        self.dataArr = [
            [
                "title": "订单信息",
                "rows": [
                    ["title":"订单编号", "key":"orderId", "value": self._initData?.orderId],
                    ["title":"订单时间", "key":"orderTime", "value": self._initData?.orderId],
                    ["title":"订单总额", "key":"sn", "value": self._initData?.sn],
                    ["title":"优惠金额", "key":"name", "value": self._initData?.name],
                    ["title":"实收金额", "key":"warehouse", "value": self._initData?.warehouse],
                    ["title":"收款员工", "key":"employee", "value": self._initData?.employee],
                ]
            ],
            [
                "title": "订单明细",
                "rows": [
                    ["title":"订单编号", "key":"orderId", "value": self._initData?.orderId],
                    ["title":"订单编号", "key":"orderId", "value": self._initData?.orderId],
                    ["title":"订单编号", "key":"orderId", "value": self._initData?.orderId],
                    ["title":"订单编号", "key":"orderId", "value": self._initData?.orderId],
                    ["title":"订单编号", "key":"orderId", "value": self._initData?.orderId],
                    ["title":"订单编号", "key":"orderId", "value": self._initData?.orderId],
                    ["title":"订单编号", "key":"orderId", "value": self._initData?.orderId],
                    ["title":"订单编号", "key":"orderId", "value": self._initData?.orderId],
                    ["title":"订单编号", "key":"orderId", "value": self._initData?.orderId],
                    ["title":"订单编号", "key":"orderId", "value": self._initData?.orderId],
                    ["title":"订单编号", "key":"orderId", "value": self._initData?.orderId],
                ]
            ],
            [
                "title": "收件人",
                "rows": [
                    ["title":"收件人", "key":"receiver", "value": self._initData?.orderId, "placeholder": "请输入收件人姓名"],
                    ["title":"收件电话", "key":"receiverPhone", "value": self._initData?.orderId, "placeholder": "请输入收件人联系电话号码"],
                    ["title":"收件地区", "key":"receiverRegion", "value": self._initData?.orderId],
                    ["title":"详细地址", "key":"receiverDetail", "value": self._initData?.orderId, "placeholder": "请详细到街道、门牌"],
                ]
            ],
            [
                "title": "快递信息",
                "rows": [
                    ["title":"快递公司", "key":"expressCompany", "value": self._initData?.orderId, "placeholder": "请输入快递公司"],
                    ["title":"快递单号", "key":"expressNumber", "value": self._initData?.orderId, "placeholder": "请输入快递单号"],
                    ["title":"备注", "key":"expressNote", "value": self._initData?.orderId, "placeholder": "快递备注"]
                ]
            ],
            [
                "title": "发件信息",
                "rows": [
                    ["title":"发件员工", "key":"employee", "value": self._initData?.employee],
                    ["title":"发件时间", "key":"datetime", "value": stringFromDate((self._initData?.datetime)!, format: "yyyy-MM-dd HH:mm:ss")]
                ]
            ],
        ]
        
    }
    
    fileprivate func _rowsModel(at section: Int) -> [Any] {
        return self.dataArr[section]["rows"] as! [Any]
    }
    
    fileprivate func _rowModel(at indexPath: IndexPath) -> [String: String] {
        return self._rowsModel(at: indexPath.section)[indexPath.row] as! [String : String]
    }
    
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
        return (self.dataArr[section]["title"] as! String)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SelectCellHeight
    }
    
    //设置分组头的高度
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        if self._isAdd == true && section == self.dataArr.count - 1 {
            return "" //别忘了点击提交按钮喔
        }
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
            return 60
        }
        return 0
    }
    
    //创建各单元显示内容(创建参数indexPath指定的单元）
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let _row = self._rowModel(at: indexPath)
        let key: String = _row["key"]!
        
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
