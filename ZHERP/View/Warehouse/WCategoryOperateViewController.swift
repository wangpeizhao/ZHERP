//
//  WCategoryOperateViewController.swift
//  ZHERP
//
//  Created by MrParker on 2018/9/4.
//  Copyright © 2018 MrParker. All rights reserved.
//

import UIKit

class WCategoryOperateViewController: UIViewController {
    
    let Id: Int = 0
    var navTitle: String? = nil
    var valueArr = [String: String]()
    var tableView: UITableView!
    let CELL_IDENTIFY_ID = "CELL_IDENTIFY_ID"
    
    var addressPickerView: UIViewController!
    
    var callBackAssign: assignArrayClosure?
    
    let dataArr = [
        ["title":"分类名称", "key":"name", "value":"未填写"],
        ["title":"所属分类", "key":"category", "value":"未选择"]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(hex: 0xf7f7f7)
        setNavBarTitle(view: self, title: self.navTitle!)
        setNavBarBackBtn(view: self, title: "", selector: #selector(actionBack))
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
                _alert(view: self, message: "请完整填写分类信息")
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
    
    private func _setup() {
        //创建表视图
        self.tableView = UITableView(frame: self.view.frame, style: .grouped)
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: CELL_IDENTIFY_ID)
        self.tableView!.register(SimpleBasicsCell.self, forCellReuseIdentifier: SimpleBasicsCell.identifier)
        self.tableView?.tableHeaderView = UIView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0.1))
        self.view.addSubview(self.tableView!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension WCategoryOperateViewController: UITableViewDelegate, UITableViewDataSource {
    
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
        return 48
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    //设置分组头的高度
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "填写完整后不要忘了点击保存喔。"
    }
    
    //设置分组尾的高度
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 30
    }
    
    //将分组尾设置为一个空的View
    //    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    //        return UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    //    }
    
    //创建各单元显示内容(创建参数indexPath指定的单元）
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let _data = dataArr[indexPath.item]
        let key: String = dataArr[indexPath.item]["key"]!
        //        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_IDENTIFY_ID, for: indexPath)
        //        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: CELL_IDENTIFY_ID)
        var cell = UITableViewCell()
        cell = tableView.dequeueReusableCell(withIdentifier: SimpleBasicsCell.identifier, for: indexPath)
        
        cell.textLabel?.text = _data["title"]
        cell.textLabel?.font = Specs.font.regular
        var detailTextLabel: String = ""
        switch key {
        case "name":
            detailTextLabel = !(self.valueArr["name"]?.isEmpty)! ? self.valueArr["name"]! : _data["value"]!
        case "category":
            detailTextLabel = !(self.valueArr["pName"]?.isEmpty)! ? self.valueArr["pName"]! : _data["value"]!
        default:
            detailTextLabel = ""
        }
        cell.detailTextLabel?.text = detailTextLabel
        cell.detailTextLabel?.font = Specs.font.regular
        
        cell.tag = indexPath.row
        
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let _data = dataArr[indexPath.item]
        let key: String = dataArr[indexPath.item]["key"]!
        
        let _target = WLocationDeatilViewController()
        
        _target.navTitle = _data["title"]
        switch key {
        case "name":
            _target.placeholder = "最多输入十五个字"
            _target.value = (self.valueArr["name"] != nil) ? self.valueArr["name"] : _data["value"]
            _target.callBackAssign = {(assignValue: String) -> Void in
                if (!assignValue.isEmpty) {
                    self.valueArr[key] = assignValue
                    tableView.reloadData()
                }
            }
        case "category":
            _target.isSelectList = true
            if self.valueArr["wId"] != "" {
                _target.selectedIds.append(Int(self.valueArr["wId"]!)!)
            }
            _target.callBackAssignArray = {(assignValue: [String: String]) -> Void in
                if (!assignValue.isEmpty) {
                    self.valueArr["wId"] = assignValue["id"]!
                    self.valueArr[key] = assignValue["name"]!
                    tableView.reloadData()
                }
            }
        default:
            _target.Id = indexPath.row + 1
        }
        _target.hidesBottomBarWhenPushed = true
        _push(view: self, target: _target, rootView: false)
        
    }
}
