//
//  SMemberManagerViewController.swift
//  ZHERP
//
//  Created by MrParker on 2018/9/5.
//  Copyright © 2018年 MrParker. All rights reserved.
//

import UIKit

class SMemberManagerViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var tableView: UITableView!
    let CELL_IDENTIFY_ID = "CELL_IDENTIFY_ID"
    
    var dataArr = [
        ["nickname":"Parker", "id":"1", "roleName": "老板", "rid":"1"],
        ["nickname":"王培照", "id":"2", "roleName": "店长", "rid":"2"],
        ["nickname":"陈啟英", "id":"3", "roleName": "店员", "rid":"3"],
        ["nickname":"Wang Peizhao", "id":"4", "roleName": "发货员", "rid":"4"],
        ["nickname":"Chi-ying Chen", "id":"5", "roleName": "收银员", "rid":"5"]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = Specs.color.white
        setNavBarTitle(view: self, title: "员工管理")
        setNavBarBackBtn(view: self, title: "员工管理", selector: #selector(actionBack))
        
        setNavBarRightBtn(view: self, title: "添加", selector: #selector(actionAdd))
        
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
        let _target = SMemberOperateViewController()
        _target.navTitle = "添加"
        _target.hidesBottomBarWhenPushed = true
        _push(view: self, target: _target, rootView: false)
    }
    
    @objc func actionSave() {
        setNavBarRightBtn(view: self, title: "添加", selector: #selector(actionAdd))
        self.tableView.isEditing = false
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
        let longPress = UILongPressGestureRecognizer.init(target: self, action: #selector(longPressAction))
        longPress.delegate = self
        longPress.minimumPressDuration = 1
        self.tableView!.addGestureRecognizer(longPress)
        
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

extension SMemberManagerViewController: UITableViewDelegate, UITableViewDataSource {
    
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
        return "点击可进行编辑；长按可进行删除及上下拖动排序。"
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
        let cell = UITableViewCell(style: .value1, reuseIdentifier: CELL_IDENTIFY_ID)
        
        cell.textLabel?.text = _data["nickname"]
        cell.textLabel?.font = Specs.font.regular
        
        cell.detailTextLabel?.text = _data["roleName"]
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
        let _target = SMemberOperateViewController()
        _target.navTitle = _data["nickname"]
        _target.valueArr = _data
        _target.callBackAssign = {(assignValue: [String: String]) -> Void in
            self.dataArr[indexPath.item]["nickname"] = assignValue["nickname"]
            self.dataArr[indexPath.item]["roleName"] = assignValue["roleName"]
            tableView.reloadData()
        }
        _target.hidesBottomBarWhenPushed = true
        _push(view: self, target: _target, rootView: false)
        
    }

    // Edit mode 点击左上角的“edit”按钮  列表左侧出现删除按钮
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: true)
    }

    // Delete mode 点击删除按钮或者按住列表向左滑动 直接删除
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            self.dataArr.remove(at: (indexPath as NSIndexPath).row)
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        }
    }

    // Move mode
    // canMoveRowAt 这 func 可有可无
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return self.isEditing
    }
    // 移动列表+保存
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let todo = self.dataArr.remove(at: (sourceIndexPath as NSIndexPath).row)
        self.dataArr.insert(todo, at: (destinationIndexPath as NSIndexPath).row)
    }
}
