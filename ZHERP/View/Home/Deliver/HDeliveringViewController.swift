//
//  HDeliveringViewController.swift
//  ZHERP
//
//  Created by MrParker on 2018/9/17.
//  Copyright © 2018年 MrParker. All rights reserved.
//

import UIKit
import SnapKit

class HDeliveringViewController: UIViewController {
    
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
    var _initData: HDeliverModel?
    
    // 是否是添加货品调配
    var _isAdd: Bool!
    
    // 添加时选择入仓的仓库名称
    var warehouseName: String = ""
    
    // 添加时选择入仓仓库的库存
    var warehouseStock: String = ""
    
    let writableTextFields = ["expressCompany", "expressNumber", "expressNote", "receiver", "receiverPhone", "receiverDetail"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(hex: 0xf7f7f7)
        setNavBarTitle(view: self, title: self.navTitle != nil ? self.navTitle: "发货")
        setNavBarBackBtn(view: self, title: "", selector: #selector(actionBack))
        
        self._setup()
        // Do any additional setup after loading the view.
    }
    
    @objc func actionBack()->Void {
        _back(view: self)
    }
    
    @objc func actionSuccess(_: UIAlertAction)->Void {
        for i in 0..<(self.navigationController?.viewControllers.count)! {
            if self.navigationController?.viewControllers[i].isKind(of: HDeliverViewController.self) == true {
                _ = self.navigationController?.popToViewController(self.navigationController?.viewControllers[i] as! HDeliverViewController, animated: true)
                break
            }
        }
    }
    
    @objc func actionTextField(_ sender: UITextField) {
        sender.resignFirstResponder()
//        self._initData?.quantity = sender.text!
    }
    
    @objc func actionSave() {
        if (self._initData?.receiver == "") {
            _alert(view: self, message: "请先填写收件人")
            return
        }
//        if (self._initData?.quantity == "") {
//            _alert(view: self, message: "请先填写调入库存数量")
//            return
//        }
//        if Int((self._initData?.outWarehouse)!)! < Int((self._initData?.quantity)!)! {
//            _alert(view: self, message: "调入库存数量不能大于调出库库存")
//            return
//        }
        if (self.callBackAssign != nil) {
            if (self.valueArr["maxId"] != nil) {
                self.valueArr["id"] = self.valueArr["maxId"]
            }
            self.callBackAssign!(self.valueArr)
        }
        _alert(view: self, message: "提交成功", handler: actionSuccess)
    }
    
    private func _setup() {
        self.initData()
        //创建表视图
        self.tableView = UITableView(frame: self.view.frame, style: .grouped)
        
        //处理键盘遮挡问题
        if (self._isAdd) {
            let tvc: UITableViewController = UITableViewController(style: .grouped)
            self.addChildViewController(tvc)
            self.tableView = tvc.tableView
        }
        
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: CELL_IDENTIFY_ID)
        self.tableView!.register(SimpleBasicsCell.self, forCellReuseIdentifier: SimpleBasicsCell.identifier)
        
        if (self._isAdd) {
            // 可填写
            self.tableView?.register(UINib(nibName: "SMemberOperateTableViewCell", bundle: nil), forCellReuseIdentifier: "SMemberOperateTableViewCell")
            // 按钮
            self.tableView?.register(UINib(nibName: "HDeliveringTableViewCell", bundle: nil), forCellReuseIdentifier: "HDeliveringTableViewCell")
        }
        
        self.tableView?.tableHeaderView = UIView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0.01))
        self.view.addSubview(self.tableView!)
    }
    
    private func initData() {
        self._isAdd = self.valueArr["datetime"] == nil
        
        self._initData = HDeliverModel(id: 0, orderId: "", orderAmount: "", orderRealPaid: "", orderTime: "", expressCompany: "", expressNumber: "", expressNote: "", receiver: "", receiverPhone: "", receiverRegion: "", receiverDetail: "", employee: "", datetime: dateFromString(SYSTEM_DATETIME, format: "yyyy-MM-dd HH:mm:ss")!)
        
        if self.valueArr["datetime"] == nil {
            self.valueArr["datetime"] = SYSTEM_DATETIME
        }
        self.valueArr["province"] = "广东"
        self.valueArr["city"] = "广州"
        self.valueArr["area"] = "越秀"
        self._initData?.id = self.valueArr["id"] != nil ? Int(self.valueArr["id"]!)! : 0
        self._initData?.orderId = self.valueArr["orderId"] != nil ? self.valueArr["orderId"]! : "201809171531342345"
        self._initData?.orderAmount = self.valueArr["orderAmount"] != nil ? self.valueArr["orderAmount"]! : "3000.00"
        self._initData?.orderRealPaid = self.valueArr["orderRealPaid"] != nil ? self.valueArr["orderRealPaid"]! : "2500.00"
        self._initData?.orderTime = self.valueArr["orderTime"] != nil ? self.valueArr["orderTime"]! : "2018-09-17 15:31:34"
        self._initData?.expressCompany = self.valueArr["expressCompany"] != nil ? self.valueArr["expressCompany"]! : ""
        self._initData?.expressNumber = self.valueArr["expressNumber"] != nil ? self.valueArr["expressNumber"]! : ""
        self._initData?.expressNote = self.valueArr["expressNote"] != nil ? self.valueArr["expressNote"]! : ""
        self._initData?.receiver = self.valueArr["receiver"] != nil ? self.valueArr["receiver"]! : ""
        self._initData?.receiverPhone = self.valueArr["receiverPhone"] != nil ? self.valueArr["receiverPhone"]! : ""
        if self._isAdd {
            self._initData?.receiverRegion = self.valueArr["receiverRegion"] != nil ? self.valueArr["receiverRegion"]! : "未选择"
        } else {
            self._initData?.receiverRegion = "\(self.valueArr["province"] ?? ""),\(self.valueArr["city"] ?? ""),\(self.valueArr["area"] ?? "")"
        }
        self._initData?.receiverDetail = self.valueArr["receiverDetail"] != nil ? self.valueArr["receiverDetail"]! : ""
        self._initData?.employee = self.valueArr["employee"] != nil ? self.valueArr["employee"]! : "王培照"
        self._initData?.datetime = dateFromString(self.valueArr["datetime"]!, format: "yyyy-MM-dd HH:mm:ss")!
        
        self.dataArr = [
            [
                "title": "订单信息",
                "rows": [
                    ["title":"订单编号", "key":"orderId", "value": self._initData?.orderId],
                    ["title":"订单金额/实付", "key":"orderAmountPaid", "value": "\(self._initData?.orderAmount ?? "")/\(self._initData?.orderRealPaid ?? "")"],
                    ["title":"订单时间", "key":"orderTime", "value": self._initData?.orderId]
                ]
            ],
            [
                "title": "收件人",
                "rows": [
                    ["title":"收件人", "key":"receiver", "value": self._initData?.receiver, "placeholder": "请输入收件人姓名"],
                    ["title":"收件电话", "key":"receiverPhone", "value": self._initData?.receiverPhone, "placeholder": "请输入收件人联系电话号码"],
                    ["title":"收件地区", "key":"receiverRegion", "value": self._initData?.receiverRegion],
                    ["title":"详细地址", "key":"receiverDetail", "value": self._initData?.receiverDetail, "placeholder": "请详细到街道、门牌"],
                ]
            ],
            [
                "title": "快递信息",
                "rows": [
                    ["title":"快递公司", "key":"expressCompany", "value": self._initData?.expressCompany, "placeholder": "请输入快递公司"],
                    ["title":"快递单号", "key":"expressNumber", "value": self._initData?.expressNumber, "placeholder": "收件人的备注"],
                    ["title":"备注", "key":"expressNote", "value": self._initData?.expressNote, "placeholder": "快递备注"]
                ]
            ],
            [
                "title": "发件信息",
                "rows": [
                    ["title":"发件员工", "key":"employee", "value": self._initData?.employee],
                    ["title":"发件时间", "key":"datetime", "value": stringFromDate((self._initData?.datetime)!, format: "yyyy-MM-dd HH:mm:ss")]
                ]
            ],
            [
                "title": "别忘了点击提交按钮喔",
                "rows": [
                    ["title":"提交", "key":"submit", "value": ""]
                ]
            ]
        ]
        
        if self._isAdd {
            self.dataArr.removeAt(indexes: [3])
        } else {
            
        }
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
    
    deinit {
        //移除监听
        NotificationCenter.default.removeObserver(self)
    }
    
}

extension HDeliveringViewController: UITableViewDelegate, UITableViewDataSource {
    
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
        if self._isAdd == true && indexPath.section == self.dataArr.count - 1 {
            return SelectCellHeight + 10
        }
        return SelectCellHeight
    }
    
    //设置分组头的高度
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        if self._isAdd == true && section == self.dataArr.count - 1 {
            return "别忘了点击提交按钮喔"
        }
        return ""
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if self._isAdd == true || section != self.dataArr.count - 1 {
            return UIView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0.01))
        }
        let memberView = UIView()
        memberView.backgroundColor = UIColor.white
        
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
        if self._isAdd == false && section == self.dataArr.count - 1 {
            return 80
        }
        return 10
    }
    
    //创建各单元显示内容(创建参数indexPath指定的单元）
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let _row = self._rowModel(at: indexPath)
        let key: String = _row["key"]!
        
        if key == "submit" {
            let cell: HDeliveringTableViewCell = tableView.dequeueReusableCell(withIdentifier: "HDeliveringTableViewCell") as! HDeliveringTableViewCell
            cell.cellBtn.setTitle("提交", for: .normal)
            cell.cellBtn.setTitleColor(Specs.color.white, for: UIControlState())
            cell.cellBtn.backgroundColor = Specs.color.main
            cell.cellBtn.layer.cornerRadius = Specs.border.radius
            cell.cellBtn.addTarget(self, action: #selector(actionSave), for: .touchUpInside)
            return cell
        }
        
        if (self._isAdd == true && self.writableTextFields.contains(key)) {
            let cell: SMemberOperateTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SMemberOperateTableViewCell") as! SMemberOperateTableViewCell
            cell.TextFieldLabel.text = _row["title"]
            cell.TextFieldLabel.sizeToFit()
            cell.TextFieldLabel.font = Specs.font.regular
            
            cell.TextFieldValue.tag = indexPath.row
            cell.TextFieldValue.text = _row["value"]
            cell.TextFieldValue.textColor = Specs.color.black
            cell.TextFieldValue.placeholder = _row["placeholder"]
            cell.TextFieldValue.clearButtonMode = UITextFieldViewMode.always
            cell.TextFieldValue.adjustsFontSizeToFitWidth = true
            cell.TextFieldValue.returnKeyType = UIReturnKeyType.done
            if key == "receiverPhone" {
                cell.TextFieldValue.keyboardType = UIKeyboardType.numberPad
            }
            cell.TextFieldValue.delegate = self
            
//          cell.TextFieldValue.addTarget(self, action: #selector(actionTextField(_:)), for: UIControlEvents.editingDidEnd)
            cell.accessoryType = .none
            return cell
        }
        
        var cell = UITableViewCell()
        cell = tableView.dequeueReusableCell(withIdentifier: SimpleBasicsCell.identifier, for: indexPath)
        
        cell.textLabel?.text = _row["title"]
        cell.textLabel?.font = Specs.font.regular
        
        cell.detailTextLabel?.text = _row["value"]
        
        if self._isAdd == true && key == "transferred" && self.warehouseName != "" {
            cell.detailTextLabel?.text = self.warehouseName
        }
        
        if self._isAdd == true && key == "inWarehouse" && self.warehouseStock != "" {
            cell.detailTextLabel?.text = self.warehouseStock
        }
        
        if self._isAdd == true && key == "receiverRegion" {
            cell.detailTextLabel?.text = self._initData?.receiverRegion
        }
        
        cell.detailTextLabel?.font = Specs.font.regular
        
        let _edit = ["employee", "datetime", "orderId", "orderAmountPaid", "orderTime"]
        if (self._isAdd == false || _edit.contains(key)) {
            cell.accessoryType = .none
        } else {
            cell.accessoryType = .disclosureIndicator
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if self._isAdd == false {
            return
        }
        
        let _row = self._rowModel(at: indexPath)
        let key: String = _row["key"]!
        if "transferred" == key {
            let _target = WLocationDeatilViewController()
//            _target.isSelectList = true
//            _target.navTitle = "选择入仓仓库"
//            if self._initData?.wId != 0 {
//                _target.selectedIds.append((self._initData?.wId)!)
//            }
//            _target.callBackAssignArray = {(assignValue: [String: String]) -> Void in
//                if (!assignValue.isEmpty) {
//                    self._initData?.wId = Int(assignValue["id"]!)!
//                    self._initData?.warehouse = assignValue["name"]!
//                    self.warehouseName = assignValue["name"]!
//                    self.warehouseStock = "500"
//                    //                    tableView.reloadData()
//                    tableView.reloadRows(at: [indexPath], with: .automatic)
//                }
//            }
            _push(view: self, target: _target, rootView: false)
            return
        }
        
        if "receiverRegion" == key {
            let _target = AddressPickerViewController(province: self.valueArr["province"]!, city: self.valueArr["city"]!, area: self.valueArr["area"]!)
            _target.callBackAssign = {(assignValue: String) -> Void in
                if (!assignValue.isEmpty) {
                    self.valueArr[key] = assignValue
                    let _region : Array = assignValue.components(separatedBy: " ")
                    self.valueArr["province"] = _region[0]
                    self.valueArr["city"] = _region[1]
                    self.valueArr["area"] = _region[2]
//                    tableView.reloadData()
                    self._initData?.receiverRegion = assignValue
                    tableView.reloadRows(at: [indexPath], with: .automatic)
                }
            }
            _target.setAddressPickerView(view: self)
            return
        }
    }
}

extension HDeliveringViewController: UITextFieldDelegate {
    // 输入框询问是否可以编辑 true 可以编辑  false 不能编辑
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    // 输入框结束编辑状态
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.actionTextField(textField)
    }
    // 输入框按下键盘 return 收回键盘
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.actionTextField(textField)
        return true
    }
}
