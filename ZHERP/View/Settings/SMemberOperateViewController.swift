//
//  SMemberOperateViewController.swift
//  ZHERP
//
//  Created by MrParker on 2018/9/5.
//  Copyright © 2018年 MrParker. All rights reserved.
//

import UIKit

class SMemberOperateViewController: UIViewController {
    
    let Id: Int = 0
    var navTitle: String? = nil
    var valueArr = [String: String]()
    var tableView: UITableView!
    let CELL_IDENTIFY_ID = "CELL_IDENTIFY_ID"
    
    var addressPickerView: UIViewController!
    
    var callBackAssign: assignArrayClosure?
    
    var dataArr = [[String: Any]]()
    
    var memberData: SMemberData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(hex: 0xf7f7f7)
        setNavBarTitle(view: self, title: self.navTitle!)
        setNavBarRightBtn(view: self, title: "保存", selector: #selector(actionSave))
        
        self._setup()
        
        // Do any additional setup after loading the view.
    }
    
    @objc func actionBack(_: UIAlertAction)->Void {
        _back(view: self)
    }
    
    @objc func actionSave() {
        for (_, item) in self.valueArr {
            if item.isEmpty {
                _alert(view: self, message: "请完整填写员工信息")
                return
            }
        }
        if (self.callBackAssign != nil) {
            if (self.valueArr["maxId"] != nil) {
                self.valueArr["id"] = self.valueArr["maxId"]
            }
            self.callBackAssign!(self.valueArr)
        }
        _alert(view: self, message: "提交成功", handler: actionBack)
    }
    
    @objc func actionSwitch(_ sender: UISwitch) {
        print("actionSwitch:\(sender.isOn)")
    }
    
    private func initData() {
        
        self.memberData = SMemberData(id: 0, avatar: "", username: "", rId: 0, realname: "", rolename: "", remark: "", status: false, lastLoginIp: "", lastLoginTime: dateFromString("2018-09-05")!)
        
        self.dataArr = [
            [
                "rows": [
                    ["title":"个人头像", "key":"avatar", "value":"bayMax"]
                ]
            ],
            [
                "rows": [
                    ["title":"登录账号", "key":"username", "value":"", "placeholder": "请填写登录账号(手机号码)"],
                    ["title":"登录密码", "key":"password", "value":"", "placeholder": "请填写登录密码(6~20个字符)"],
                    ["title":"所属角色", "key":"role", "value":"未选择"],
                ]
            ],
            [
                "rows": [
                    ["title":"真实姓名", "key":"realname", "value":"", "placeholder": "请填写员工真实姓名"],
                    ["title":"员工备注", "key":"remark", "value":"", "placeholder": "请填写员工备注"],
                ]
            ],
            [
                "rows": [
                    ["title":"账号状态", "key":"status", "value":"未填写"],
                ]
            ],
            [
                "rows": [
                    ["title":"最后登录IP", "key":"lastLoginIp", "value":"12.23.34.11"],
                    ["title":"最后登录时间", "key":"lastLoginTime", "value":"2018-09-05 14:28:59"],
                ]
            ]
        ]
        
        if self.valueArr["id"] == nil {
            self.dataArr.removeLast()
        } else {
            self.memberData?.id = Int(self.valueArr["id"]!)!
            self.memberData?.realname = self.valueArr["nickname"]!
            self.memberData?.rId = Int(self.valueArr["rid"]!)!
            self.memberData?.rolename = self.valueArr["roleName"]!
            self.memberData?.status = true
        }
    }
    
    fileprivate func _rowsModel(at section: Int) -> [Any] {
        return self.dataArr[section][MemberMenus.Rows] as! [Any]
    }
    
    fileprivate func _rowModel(at indexPath: IndexPath) -> [String: String] {
        return self._rowsModel(at: indexPath.section)[indexPath.row] as! [String : String]
    }
    
    private func _setup() {
        self.initData()
        //创建表视图
        self.tableView = UITableView(frame: self.view.frame, style: .grouped)
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: CELL_IDENTIFY_ID)
        self.tableView!.register(SimpleBasicsCell.self, forCellReuseIdentifier: SimpleBasicsCell.identifier)
        // 头像
        self.tableView!.register(UINib(nibName: "ImageRightTableViewCell", bundle: nil), forCellReuseIdentifier: "ImageRightTableViewCell")
        // 开关
        self.tableView?.register(UINib(nibName: "SwitchTableViewCell", bundle: nil), forCellReuseIdentifier: "SwitchTableViewCell")
        // 可填写
        self.tableView?.register(UINib(nibName: "SMemberOperateTableViewCell", bundle: nil), forCellReuseIdentifier: "SMemberOperateTableViewCell")
        self.tableView?.tableHeaderView = UIView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 10.0))
        self.view.addSubview(self.tableView!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension SMemberOperateViewController: UITableViewDelegate, UITableViewDataSource {
    
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
        let _row = self._rowModel(at: indexPath)
        let key: String = _row["key"]!
        
        if "avatar" == key {
            return 64.0
        }
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
        if section == self.dataArr.count - 1 {
            return "填写完整后不要忘了点击保存喔。"
        }
        return ""
    }
    
    //设置分组尾的高度
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == self.dataArr.count - 1 {
            return 30
        }
        return 0
    }
    
    //创建各单元显示内容(创建参数indexPath指定的单元）
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let _row = self._rowModel(at: indexPath)
        let key: String = _row["key"]!

        if "avatar" == key {
            let avatar = !(self.memberData?.avatar.isEmpty)! ? self.memberData?.avatar : "bayMax"
            let cell: ImageRightTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ImageRightTableViewCell") as! ImageRightTableViewCell
            cell.ImageLabel?.text = _row["title"]
            cell.ImageLabel?.font = Specs.font.regular
            cell.ImageTarget?.image = UIImage(named: avatar!)
            cell.accessoryType = .disclosureIndicator
            return cell
        }
        
        if "status" == key {
            let cell: SwitchTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SwitchTableViewCell") as! SwitchTableViewCell
            cell.SwitchLabel.text = _row["title"]
            cell.SwitchLabel.sizeToFit()
            cell.SwitchLabel.font = Specs.font.regular
            cell.SwitchWidget.isOn = (self.memberData?.status)!
            cell.SwitchWidget.addTarget(self, action: #selector(actionSwitch(_:)), for: .valueChanged)
            cell.accessoryType = .none
            return cell
        }
        
        
        let textFields = ["username", "password", "realname", "remark"]
        if (textFields.contains(key)) {
            let cell: SMemberOperateTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SMemberOperateTableViewCell") as! SMemberOperateTableViewCell
            cell.TextFieldLabel.text = _row["title"]
            cell.TextFieldLabel.sizeToFit()
            cell.TextFieldLabel.font = Specs.font.regular
            
            cell.TextFieldValue.returnKeyType = UIReturnKeyType.next
            switch key {
            case "username":
                cell.TextFieldValue.text = self.memberData?.username != "" ? self.memberData?.username : _row["value"]
            case "realname":
                cell.TextFieldValue.text = self.memberData?.realname != "" ? self.memberData?.realname : _row["value"]
            case "remark":
                cell.TextFieldValue.text = self.memberData?.remark != "" ? self.memberData?.remark : _row["value"]
                cell.TextFieldValue.returnKeyType = UIReturnKeyType.done
//                cell.TextFieldValue.addTarget(self, action: #selector(actionSave), for: .touchUpInside)
            default:
                cell.TextFieldValue.text = _row["value"]
            }
            cell.TextFieldValue.textColor = Specs.color.black
            cell.TextFieldValue.placeholder = _row["placeholder"]
            cell.TextFieldValue.clearButtonMode = UITextFieldViewMode.always
            cell.TextFieldValue.adjustsFontSizeToFitWidth = true
            cell.TextFieldValue.delegate = self
            cell.accessoryType = .none
            return cell
        }
        
        var cell = UITableViewCell()
        cell = tableView.dequeueReusableCell(withIdentifier: SimpleBasicsCell.identifier, for: indexPath)
        
        cell.textLabel?.text = _row["title"]
        cell.textLabel?.font = Specs.font.regular
        
        switch key {
        case "role":
            cell.detailTextLabel?.text = self.memberData?.rolename != "" ? self.memberData?.rolename : _row["value"]
        case "lastLoginIp":
            cell.detailTextLabel?.text = self.memberData?.lastLoginIp != "" ? self.memberData?.lastLoginIp : _row["value"]
        case "lastLoginTime":
            cell.detailTextLabel?.text = self.memberData?.lastLoginTime != nil ? stringFromDate((self.memberData?.lastLoginTime)!) : ""
        default:
            cell.detailTextLabel?.text = _row["value"]
        }
        cell.detailTextLabel?.font = Specs.font.regular
        
        let lastLogin = ["lastLoginIp", "lastLoginTime"]
        if (lastLogin.contains(key)) {
            cell.accessoryType = .none
        } else {
            cell.accessoryType = .disclosureIndicator
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let _row = self._rowModel(at: indexPath)
        let key: String = _row["key"]!
        
        if "avatar" == key {
            let title = valueArr["nickname"] != nil ? valueArr["nickname"] : "添加头像"
            setNavBarBackBtn(view: self, title: title!, selector: #selector(actionBack))
            let avatar = !(_row["value"]?.isEmpty)! ? _row["value"] : "bayMax"
            let _target = EditAvatarViewController()
            _target.personalTitle = title
            _target.personalValue = avatar
            _target.hidesBottomBarWhenPushed = true
            _push(view: self, target: _target, rootView: false)
            return
        }
        
        if "role" == key {
            setNavBarBackBtn(view: self, title: "", selector: #selector(actionBack))
            let _target = SMemberDetailViewController()
            _target.navTitle = "选择所属角色"
            _target.isSelectList = true
            if self.memberData?.rId != nil {
                _target.selectedIds.append((self.memberData?.rId)!)
            }
            _target.callBackAssignArray = {(assignValue: [String: String]) -> Void in
                if (!assignValue.isEmpty) {
                    self.memberData?.rId = Int(assignValue["id"]!)!
                    self.memberData?.rolename = assignValue["name"]!
                    tableView.reloadData()
                }
            }
            _target.hidesBottomBarWhenPushed = true
            _push(view: self, target: _target, rootView: false)
            return
        }
        
    }

}

extension SMemberOperateViewController: UITextFieldDelegate {
    
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
        textField.resignFirstResponder()
        return true
    }
    // 该方法当文本框内容出现变化时 及时获取文本最新内容
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        return true
    }
    
}
