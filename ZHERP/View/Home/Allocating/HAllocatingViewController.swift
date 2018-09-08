//
//  HAllocatingViewController.swift
//  ZHERP
//
//  Created by MrParker on 2018/9/8.
//  Copyright © 2018 MrParker. All rights reserved.
//

import UIKit
import SnapKit

class HAllocatingViewController: UIViewController {
    
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
        setNavBarTitle(view: self, title: self.navTitle != nil ? self.navTitle: "货品调配")
        setNavBarBackBtn(view: self, title: "", selector: #selector(actionBack))
        
        self._setup()
        
        // Do any additional setup after loading the view.
    }
    
    @objc func actionBack()->Void {
        _back(view: self)
    }
    
    @objc func actionSuccess(_: UIAlertAction)->Void {
        _back(view: self)
    }
    
    @objc func actionTextField(_ sender: UITextField) {
        print(sender.text!)
        sender.resignFirstResponder()
        self._initData?.quantity = sender.text!
    }
    
    @objc func actionSave() {
        if (self._initData?.wId == 0) {
            _alert(view: self, message: "请先选择入仓仓库")
            return
        }
        if (self._initData?.quantity == "") {
            _alert(view: self, message: "请先填写调入库存数量")
            return
        }
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
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: CELL_IDENTIFY_ID)
        self.tableView!.register(SimpleBasicsCell.self, forCellReuseIdentifier: SimpleBasicsCell.identifier)
        // 可填写
        self.tableView?.register(UINib(nibName: "SMemberOperateTableViewCell", bundle: nil), forCellReuseIdentifier: "SMemberOperateTableViewCell")
        self.tableView?.tableHeaderView = UIView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 10.0))
        self.view.addSubview(self.tableView!)
    }
    
    private func initData() {
        self._isAdd = self.valueArr["datetime"] == nil
        
        self._initData = HAllocatingModel(id: 0, orderId: "", sn: "", name: "", warehouse: "", wId: 0, transferred: "", quantity: "", outWarehouse: "", inWarehouse: "", datetime: dateFromString(SYSTEM_DATETIME, format: "yyyy-MM-dd HH:mm:ss")!)
        
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
        self._initData?.datetime = dateFromString(self.valueArr["datetime"]!, format: "yyyy-MM-dd HH:mm:ss")!
        
        self.dataArr = [
            [
                "rows": [
                    ["title":"调配编号", "key":"orderId", "value": self._initData?.orderId]
                ]
            ],
            [
                "rows": [
                    ["title":"货品编号", "key":"sn", "value": self._initData?.sn],
                    ["title":"货品名称", "key":"name", "value": self._initData?.name],
                    ["title":"所属仓库", "key":"warehouse", "value": self._initData?.warehouse]
                ]
            ],
            [
                "rows": [
                    ["title":"调入仓库", "key":"transferred", "value": self._initData?.transferred],
                    ["title":"调入数量", "key":"quantity", "value": self._initData?.quantity, "placeholder": "请输入大于0的整数"]
                ]
            ],
            [
                "rows": [
                    ["title":"出仓剩余库存", "key":"outWarehouse", "value": self._initData?.outWarehouse],
                    ["title":"入仓剩余库存", "key":"inWarehouse", "value": self._initData?.inWarehouse],
                ]
            ],
            [
                "rows": [
                    ["title":"调货时间", "key":"datetime", "value": stringFromDate((self._initData?.datetime)!, format: "yyyy-MM-dd HH:mm:ss")]
                ]
            ]
        ]
        
        if self._isAdd {
            self.dataArr.removeAt(indexes: [0, 4])
        } else {
            self.dataArr.removeAt(indexes: [3])
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
    
}

extension HAllocatingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataArr.count;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self._rowsModel(at: section).count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ""
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SelectCellHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0.01))
    }
    
    //设置分组头的高度
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        if self._isAdd == true && section == self.dataArr.count - 1 {
            return "别忘了点击提交按钮喔"
        }
        return ""
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section != self.dataArr.count - 1 {
            return UIView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0.01))
        }
        let memberView = UIView()
        memberView.backgroundColor = UIColor.clear
        
        let tipLabel = UILabel()
        tipLabel.text = self._isAdd == true ? "别忘了点击提交按钮喔。" : ""
        tipLabel.textColor = UIColor(hex: 0x666666)
        tipLabel.font = Specs.font.small
        tipLabel.sizeToFit()
        memberView.addSubview(tipLabel)
        tipLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(10)
            make.left.equalTo(20)
        }
        
        let _btn = UIButton(frame: CGRect(x: 20, y: 40, width: ScreenWidth - 40, height: 40))
        _btn.layer.cornerRadius = Specs.border.radius
        _btn.layer.masksToBounds = true
        _btn.titleLabel?.font = UIFont.systemFont(ofSize: Specs.fontSize.regular)
        
        if self._isAdd == true {
            _btn.setTitle("提交", for: .normal)
            _btn.setTitleColor(Specs.color.white, for: UIControlState())
            _btn.backgroundColor = Specs.color.main
            _btn.addTarget(self, action: #selector(actionSave), for: .touchUpInside)
        } else {
            _btn.setTitle("返回", for: .normal)
            _btn.setTitleColor(Specs.color.black, for: UIControlState())
            _btn.backgroundColor = Specs.color.white
            _btn.layer.borderWidth = 1
            _btn.layer.borderColor = UIColor(hex: 0xdddddd).cgColor //UIColor.lightGray.cgColor
            _btn.addTarget(self, action: #selector(actionBack), for: .touchUpInside)
        }
        
        memberView.addSubview(_btn)
        
        return memberView
    }
    
    //设置分组尾的高度
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == self.dataArr.count - 1 {
            return 120
        }
        return 0
    }
    
    //创建各单元显示内容(创建参数indexPath指定的单元）
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let _row = self._rowModel(at: indexPath)
        let key: String = _row["key"]!
        
        let textFields = ["quantity"]
        if (self._isAdd == true && textFields.contains(key)) {
            let cell: SMemberOperateTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SMemberOperateTableViewCell") as! SMemberOperateTableViewCell
            cell.TextFieldLabel.text = _row["title"]
            cell.TextFieldLabel.sizeToFit()
            cell.TextFieldLabel.font = Specs.font.regular
            
            cell.TextFieldValue.text = _row["value"]
            cell.TextFieldValue.textColor = Specs.color.black
            cell.TextFieldValue.placeholder = _row["placeholder"]
            cell.TextFieldValue.clearButtonMode = UITextFieldViewMode.always
            cell.TextFieldValue.adjustsFontSizeToFitWidth = true
            cell.TextFieldValue.returnKeyType = UIReturnKeyType.done
            cell.TextFieldValue.keyboardType = UIKeyboardType.numberPad
            cell.TextFieldValue.delegate = self
            
//            cell.TextFieldValue.addTarget(self, action: #selector(actionTextField(_:)), for: UIControlEvents.editingDidEnd)
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
        
        cell.detailTextLabel?.font = Specs.font.regular
        
        let _edit = ["transferred"]
        if (self._isAdd == true && _edit.contains(key)) {
            cell.accessoryType = .disclosureIndicator
        } else {
            cell.accessoryType = .none
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
            _target.isSelectList = true
            _target.navTitle = "选择入仓仓库"
            if self._initData?.wId != 0 {
                _target.selectedIds.append((self._initData?.wId)!)
            }
            _target.callBackAssignArray = {(assignValue: [String: String]) -> Void in
                if (!assignValue.isEmpty) {
                    self._initData?.wId = Int(assignValue["id"]!)!
                    self._initData?.warehouse = assignValue["name"]!
                    self.warehouseName = assignValue["name"]!
                    self.warehouseStock = "500"
                    tableView.reloadData()
//                    tableView.reloadRows(at: [indexPath], with: .automatic)
                }
            }
            _push(view: self, target: _target, rootView: false)
            return
        }
    }
}

extension HAllocatingViewController: UITextFieldDelegate {

    // 输入框询问是否可以编辑 true 可以编辑  false 不能编辑
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("我要开始编辑了...")
        return true
    }
    // 该方法代表输入框已经可以开始编辑  进入编辑状态
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("我正在编辑状态中...")
    }
    // 输入框将要将要结束编辑
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print("我即将编辑结束...")
        return true
    }
    // 输入框结束编辑状态
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("我已经结束编辑状态...")
    } // 文本框是否可以清除内容
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
    // 输入框按下键盘 return 收回键盘
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
        self.actionTextField(textField)
        return true
    }
    // 该方法当文本框内容出现变化时 及时获取文本最新内容
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        return true
    }
}
