//
//  HInventoryTakingViewController.swift
//  ZHERP
//
//  Created by MrParker on 2018/9/14.
//  Copyright © 2018 MrParker. All rights reserved.
//

import UIKit
import SnapKit

class HInventoryTakingViewController: UIViewController {
    
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
    var _initData: HInventoryTakingModel?
    
    // 是否是添加货品调配
    var _isAdd: Bool!
    
    // 添加时选择货品分类
    var categoryName: String = ""
    // 添加时选择所属仓库
    var warehouseName: String = ""
    // 添加时选择所属库位
    var locationName: String = ""
    
    // 添加时选择入仓仓库的库存
    var warehouseStock: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(hex: 0xf7f7f7)
        setNavBarTitle(view: self, title: self.navTitle != nil ? self.navTitle: "盘点货品")
        setNavBarBackBtn(view: self, title: "盘点货品", selector: #selector(actionBack))
        
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
        //        print(sender.text!)
        sender.resignFirstResponder()
    }
    
    @objc func actionSave() {
        if (self._initData?.cId == 0) {
            _alert(view: self, message: "请先选择货品分类")
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
        
        self._initData = HInventoryTakingModel(id: 0, category: "", cId: 0, warehouse: "", wId: 0, location: "", lId: 0, employee: "", datetime: dateFromString(SYSTEM_DATETIME, format: "yyyy-MM-dd HH:mm:ss")!)
        
        if self.valueArr["datetime"] == nil {
            self.valueArr["datetime"] = SYSTEM_DATETIME
        }
        self._initData?.id = self.valueArr["id"] != nil ? Int(self.valueArr["id"]!)! : 0
        self._initData?.category = self.valueArr["category"] != nil ? self.valueArr["category"]! : "未选择(必选项)"
        self._initData?.cId = self.valueArr["cId"] != nil ? Int(self.valueArr["cId"]!)! : 0
        self._initData?.warehouse = self.valueArr["warehouse"] != nil ? self.valueArr["warehouse"]! : "未选择(选填项)"
        self._initData?.wId = self.valueArr["wId"] != nil ? Int(self.valueArr["wId"]!)! : 0
        self._initData?.location = self.valueArr["location"] != nil ? self.valueArr["location"]! : "未选择(选填项)"
        self._initData?.lId = self.valueArr["lId"] != nil ? Int(self.valueArr["lId"]!)! : 0
        self._initData?.employee = self.valueArr["employee"] != nil ? self.valueArr["employee"]! : "没上次盘点记录"
        self._initData?.datetime = dateFromString(self.valueArr["datetime"]!, format: "yyyy-MM-dd HH:mm:ss")!
        
        self.dataArr = [
            [
                "rows": [
                    ["title":"货品分类", "key":"category", "value": self._initData?.category],
                ]
            ],
            [
                "rows": [
                    ["title":"所属仓库", "key":"warehouse", "value": self._initData?.warehouse],
                    ["title":"所属库位", "key":"location", "value": self._initData?.location],
                ]
            ],
            [
                "rows": [
                    ["title":"上次盘点时间", "key":"datetime", "value": stringFromDate((self._initData?.datetime)!, format: "yyyy-MM-dd HH:mm:ss")],
                    ["title":"上次盘点员工", "key":"employee", "value": self._initData?.employee]
                ]
            ]
        ]
        
        if self.valueArr["employee"] == nil || (self.valueArr["employee"]?.isEmpty)! {
//            self.dataArr.removeLast()
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

extension HInventoryTakingViewController: UITableViewDelegate, UITableViewDataSource {
    
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
        tipLabel.text = self._isAdd == true ? "货品分类为必填；所属仓库、所属库位为选填。" : ""
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
            _btn.setTitle("开始盘点", for: .normal)
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
        
        var cell = UITableViewCell()
        cell = tableView.dequeueReusableCell(withIdentifier: SimpleBasicsCell.identifier, for: indexPath)
        
        cell.textLabel?.text = _row["title"]
        cell.textLabel?.font = Specs.font.regular
        
        cell.detailTextLabel?.text = _row["value"]
        
        if key == "category" && self.categoryName != "" {
            cell.detailTextLabel?.text = self.categoryName
        }
        if key == "warehouse" && self.warehouseName != "" {
            cell.detailTextLabel?.text = self.warehouseName
        }
        if key == "location" && self.locationName != "" {
            cell.detailTextLabel?.text = self.locationName
        }
        cell.detailTextLabel?.font = Specs.font.regular
        
        let _textField = ["datetime", "employee"]
        if (_textField.contains(key)) {
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
        
        let _target = HInventoryDetailViewController()
        switch key {
        case "category":
            _target.dataType = .category
            _target.navTitle = "选择货品分类"
            if self._initData?.cId != 0 {
                _target.selectedIds.append((self._initData?.cId)!)
            }
        case "warehouse":
            _target.dataType = .warehouse
            _target.navTitle = "选择所属仓库"
            if self._initData?.wId != 0 {
                _target.selectedIds.append((self._initData?.wId)!)
            }
        case "location":
            _target.dataType = .location
            _target.navTitle = "选择所属库位"
            if self._initData?.lId != 0 {
                _target.selectedIds.append((self._initData?.lId)!)
            }
        default:
            break
        }
        _target.callBackAssignArray = {(assignValue: [String: String]) -> Void in
            if (!assignValue.isEmpty) {
                switch _target.dataType {
                case .category:
                    self._initData?.cId = Int(assignValue["id"]!)!
                    self._initData?.category = assignValue["name"]!
                    self.categoryName = assignValue["name"]!
                case .warehouse:
                    self._initData?.wId = Int(assignValue["id"]!)!
                    self._initData?.warehouse = assignValue["name"]!
                    self.warehouseName = assignValue["name"]!
                case .location:
                    self._initData?.lId = Int(assignValue["id"]!)!
                    self._initData?.location = assignValue["name"]!
                    self.locationName = assignValue["name"]!
                default:
                    break
                }
                
                tableView.reloadData()
            }
        }
        _push(view: self, target: _target, rootView: false)
        return
    }
}
