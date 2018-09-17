//
//  SMemberRoleManagerViewController.swift
//  ZHERP
//
//  Created by MrParker on 2018/9/5.
//  Copyright © 2018年 MrParker. All rights reserved.
//

import UIKit

class SMemberRoleManagerViewController: UIViewController { // , UIGestureRecognizerDelegate
    
    var tableView: UITableView!
    let CELL_IDENTIFY_ID = "CELL_IDENTIFY_ID"
    
    var dataArr = [
        ["name":"老板", "id":"1", "alias": "Big Boss"],
        ["name":"店长", "id":"2", "alias": "店长"],
        ["name":"店员", "id":"3", "alias": "店员"],
        ["name":"发货员", "id":"4", "alias": "发货员"],
        ["name":"收银员", "id":"5", "alias": "收银员"]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = Specs.color.white
        setNavBarTitle(view: self, title: "员工角色")
        setNavBarBackBtn(view: self, title: "员工角色", selector: #selector(actionBack))
        
//        setNavBarRightBtn(view: self, title: "添加", selector: #selector(actionAdd))
        
        self._setup()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView!.reloadData()
    }
    
    @objc func actionBack() {
        
    }
    
    @objc func actionAdd() {
        let _target = WarehouseDetailViewController()
        _target.navTitle = "添加"
        _target.hidesBottomBarWhenPushed = true
        _push(view: self, target: _target, rootView: false)
    }
    
    @objc func actionSave() {
        setNavBarRightBtn(view: self, title: "添加", selector: #selector(actionAdd))
        self.tableView.isEditing = false
//        print(self.dataArr)
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
        
        // 长按启动删除、移动排序功能
//        let longPress = UILongPressGestureRecognizer.init(target: self, action: #selector(longPressAction))
//        longPress.delegate = self
//        longPress.minimumPressDuration = 1
//        self.tableView!.addGestureRecognizer(longPress)
        
    }
    
    private func _setAssignValue(value: inout [String: String]) {
        let maxId = self._getMaxId()
        value["id"] = String(maxId + 1)
    }
    
    private func _getMaxId() -> Int {
        var idArr = [Int]()
        for item in self.dataArr {
            idArr.append(Int(item["id"]!)!)
        }
        let maxId = minMax(arr: idArr)
        return maxId.1
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
            // tableView.isEditing = !tableView.isEditing
            if tableView.isEditing == true {
                tableView.isEditing = false
            } else {
                // tableView.isEditing = true
                setNavBarRightBtn(view: self, title: "保存", selector: #selector(actionSave))
                self.setEditing(true,animated: true)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension SMemberRoleManagerViewController: UITableViewDelegate, UITableViewDataSource {
    
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
        return SelectCellHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    //设置分组头的高度
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "点击可编辑员工角色名；如需要添加员工角色，请联系纵横科技。"
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
        let _data = self.dataArr[indexPath.item]
//        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_IDENTIFY_ID, for: indexPath)
        let cell = UITableViewCell(style: .value1, reuseIdentifier: CELL_IDENTIFY_ID)
        
        cell.textLabel?.text = _data["alias"]
        cell.textLabel?.font = Specs.font.regular
        
        cell.detailTextLabel?.text = _data["name"]
        cell.detailTextLabel?.font = Specs.font.regular
        
        cell.tag = Int(_data["id"]!)!
        
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        var _data = self.dataArr[indexPath.item]
        if (_data["maxId"] != nil) {
            _data["maxId"] = nil
        }
        let _target = WarehouseDetailViewController()
        _target.navTitle = _data["name"]
        _target.value = _data["alias"]
        _target.callBackAssign = {(assignValue: String) -> Void in
            self.dataArr[indexPath.item]["alias"] = assignValue
            tableView.reloadData()
        }
        _target.hidesBottomBarWhenPushed = true
        _push(view: self, target: _target, rootView: false)
        
    }
}
