//
//  WCategoryManagerViewController.swift
//  ZHERP
//
//  Created by MrParker on 2018/9/4.
//  Copyright © 2018 MrParker. All rights reserved.
//

import UIKit

class WCategoryManagerViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var tableView: UITableView!
    let CELL_IDENTIFY_ID = "CELL_IDENTIFY_ID"
    
    var dataArr = [
        ["name":"男装", "id":"1", "depth": "1", "pId": "0"],
        ["name":"T恤", "id":"2", "depth": "2", "pId": "1"],
        ["name":"短袖T恤", "id":"3", "depth": "3", "pId": "2"],
        ["name":"红色短袖T恤", "id":"4", "depth": "4", "pId": "3"],
        ["name":"白色短袖T恤", "id":"5", "depth": "4", "pId": "3"],
        ["name":"珍珠白短袖T恤", "id":"8", "depth": "5", "pId": "5"],
        ["name":"长袖T恤", "id":"6", "depth": "3", "pId": "2"],
        ["name":"女装", "id":"7", "depth": "1", "pId": "0"],
        ["name":"连衣裙", "id":"9", "depth": "2", "pId": "7"],
        ["name":"短袖连衣裙", "id":"10", "depth": "3", "pId": "9"],
        ["name":"长裙连衣裙", "id":"11", "depth": "3", "pId": "9"],
        ["name":"衬衫", "id":"12", "depth": "2", "pId": "7"],
        ["name":"短袖衬衫", "id":"13", "depth": "3", "pId": "12"],
        ["name":"童装", "id":"14", "depth": "1", "pId": "0"],
        ["name":"裤子", "id":"15", "depth": "2", "pId": "14"],
        ["name":"长裤", "id":"16", "depth": "3", "pId": "15"],
        ["name":"裙子", "id":"17", "depth": "2", "pId": "14"],
        ["name":"连衣裙", "id":"18", "depth": "3", "pId": "17"]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Specs.color.white
        setNavBarTitle(view: self, title: "分类管理")
        setNavBarBackBtn(view: self, title: "分类管理", selector: #selector(actionBack))
        
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
        let maxId = self._getMaxId()
        let _target = WCategoryOperateViewController()
        _target.navTitle = "添加"
        _target.valueArr = ["name":"", "id": "0", "depth":"0", "pId": "0", "maxId": String(maxId + 1)]
        _target.hidesBottomBarWhenPushed = true
        self._setCallbackAssign(view: _target)
        _push(view: self, target: _target, rootView: false)
    }
    
    @objc func actionSave() {
        setNavBarRightBtn(view: self, title: "添加", selector: #selector(actionAdd))
        self.tableView.isEditing = false
        print(self.dataArr)
    }
    
    @objc func clickedAdd(_ sender: UIButton) {
        let _indexPath: IndexPath = IndexPath(row: sender.tag, section: 0)
        let _cell: WCategoryManagerTableViewCell = self.tableView.cellForRow(at: _indexPath as IndexPath) as! WCategoryManagerTableViewCell
        
        let categoryId = _cell.tag
        let pName: String = self._getNameByPid(pid: categoryId)
        
        let maxId = self._getMaxId()
        let _target = WCategoryOperateViewController()
        _target.navTitle = "添加"
        _target.valueArr = ["name":"", "id": "0", "depth":"0", "pId": String(categoryId), "pName": pName, "maxId": String(maxId + 1)]
        _target.hidesBottomBarWhenPushed = true
        self._setCallbackAssign(view: _target)
        _push(view: self, target: _target, rootView: false)
        
//        print(categoryId)
    }
    
    private func _setup() {
        //创建表视图
        self.tableView = UITableView(frame: self.view.frame, style: .grouped)
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
//        self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: CELL_IDENTIFY_ID)
//        self.tableView!.register(SimpleBasicsCell.self, forCellReuseIdentifier: SimpleBasicsCell.identifier)
        self.tableView?.register(UINib(nibName: "WCategoryManagerTableViewCell", bundle: nil), forCellReuseIdentifier: CELL_IDENTIFY_ID)
        self.tableView?.tableHeaderView = UIView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0.1))
        self.view.addSubview(self.tableView!)
        
        // 长按启动删除、移动排序功能
        let longPress = UILongPressGestureRecognizer.init(target: self, action: #selector(longPressAction))
        longPress.delegate = self
        longPress.minimumPressDuration = 1
        self.tableView!.addGestureRecognizer(longPress)
        
    }
    
    private func _setCallbackAssign(view: WCategoryOperateViewController) {
        view.callBackAssign = {(assignValue: [String: String]) -> Void in
            if (assignValue.isEmpty) {
                return
            }
            
            if assignValue["maxId"] != nil {// add
                self.dataArr.append(assignValue)
            } else {// edit
                var _row: Int = 0
                var i = 0
                for item in self.dataArr {
                    if (item["id"] == assignValue["id"]!) {
                        _row = i
                        break
                    }
                    i = i + 1
                }
                self.dataArr.remove(at: _row)
                self.dataArr.insert(assignValue, at: _row)
            }
            self.tableView.reloadData()
        }
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
    
    private func _getNameByPid(pid: Int) -> String{
        if self.dataArr.count == 0 {
            return "顶级"
        }
        for item in self.dataArr {
            if Int(item["id"]!) == pid {
                return item["name"]!
            }
        }
        return "顶级"
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

extension WCategoryManagerViewController: UITableViewDelegate, UITableViewDataSource {
    
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
        return "点击可进行编辑；长按可进行删除及上下拖动排序。"
    }
    
    //设置分组尾的高度
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 30
    }
    
    //创建各单元显示内容(创建参数indexPath指定的单元）
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let _data = self.dataArr[indexPath.item]
        
//        var cell = UITableViewCell()
//        cell = tableView.dequeueReusableCell(withIdentifier: SimpleBasicsCell.identifier, for: indexPath)
//        cell.textLabel?.text = _data["name"]
//        cell.textLabel?.font = Specs.font.regular
//        cell.indentationLevel =  (Int(_data["depth"]!)! - 1)  //缩进层级
//        cell.indentationWidth = 15  //每次缩进寛
        
        let cell: WCategoryManagerTableViewCell = tableView.dequeueReusableCell(withIdentifier: CELL_IDENTIFY_ID, for: indexPath) as! WCategoryManagerTableViewCell
        cell.accessoryType = .disclosureIndicator

        cell.categoryLabel.text = _data["name"]
        cell.categoryLabel.font = Specs.font.regular
        cell.categoryLabel.tag = Int(_data["depth"]!)!
        cell.categoryLabel.sizeToFit()
        cell.categoryLabel.frame.origin.x = CGFloat(20 * (Int(_data["depth"]!)!))
        
        cell.categoryBtn.tag = indexPath.row
        
        cell.categoryBtn.addTarget(self, action: #selector(clickedAdd(_:)), for: .touchUpInside)
        
//        //初始化点击事件
//        let tap = UITapGestureRecognizer.init(target:self,action:#selector(clickedAdd(_:)))
//        //保存数据到视图中
//        cell.categoryBtn.inputView?.setValue(_data["id"]!, forKey:"categoryId")
//        //视图绑定tap事件
//        cell.categoryBtn.addGestureRecognizer(tap)
        
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
        _data["pName"] = self._getNameByPid(pid: Int(_data["pId"]!)!)
        let _target = WCategoryOperateViewController()
        self._setCallbackAssign(view: _target)
        _target.navTitle = _data["name"]
        _target.valueArr = _data
        _target.hidesBottomBarWhenPushed = true
        _push(view: self, target: _target, rootView: false)
        
    }
    
    // Edit mode 点击左上角的“edit”按钮  列表左侧出现删除按钮
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: true)
        
        // tableView.endEditing(true)
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
