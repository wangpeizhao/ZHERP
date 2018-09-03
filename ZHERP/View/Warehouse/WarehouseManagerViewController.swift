//
//  WarehouseLocationViewController.swift
//  ZHERP
//
//  Created by MrParker on 2018/9/1.
//  Copyright © 2018 MrParker. All rights reserved.
//

import UIKit

class WarehouseManagerViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var tableView: UITableView!
    let CELL_IDENTIFY_ID = "CELL_IDENTIFY_ID"
    
    var dataArr = [
        ["name":"默认仓库", "id":"1", "region":"", "province":"广东", "city":"广州", "area":"海珠区", "detail":"海珠大街15号"],
        ["name":"东莞大仓", "id":"2", "region":"", "province":"广东", "city":"深圳", "area":"宝安区", "detail":"海珠大街11号"],
        ["name":"珠海大仓", "id":"3", "region":"", "province":"山东", "city":"日照", "area":"五莲县", "detail":"海珠大街101号"],
        ["name":"京东大东仓库", "id":"4", "region":"", "province":"福建", "city":"厦门", "area":"同安区", "detail":"海珠大街21号"],
        ["name":"中大轻纺交易仓", "id":"5", "region":"", "province":"广东", "city":"湛江", "area":"廉江", "detail":"萝岗大街10号"]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        navigationItem.leftBarButtonItem = editButtonItem
        self.view.backgroundColor = Specs.color.white
        setNavBarTitle(view: self, title: "仓库管理")
        setNavBarBackBtn(view: self, title: "仓库管理", selector: #selector(actionBack))
        
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
        let _target = WarehouseOperateViewController()
        _target.navTitle = "添加"
        _target.valueArr = ["name":"", "id": "0", "region":"", "province":"", "city":"", "area":"", "detail":"", "maxId": String(maxId + 1)]
        _target.hidesBottomBarWhenPushed = true
        self._setCallbackAssign(view: _target)
        _push(view: self, target: _target, rootView: false)
    }
    
    @objc func actionSave() {
        setNavBarRightBtn(view: self, title: "添加", selector: #selector(actionAdd))
        self.tableView.isEditing = false
        print(self.dataArr)
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
    
    private func _setCallbackAssign(view: WarehouseOperateViewController) {
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
    
    @objc func longPressAction(recognizer: UILongPressGestureRecognizer)  {
        if recognizer.state == UIGestureRecognizerState.began {
            print("UIGestureRecognizerStateBegan");
        }
        if recognizer.state == UIGestureRecognizerState.changed {
            print("UIGestureRecognizerStateChanged");
        }
        if recognizer.state == UIGestureRecognizerState.ended {
            print("UIGestureRecognizerStateEnded");
//            tableView.isEditing = !tableView.isEditing
            if tableView.isEditing == true {
                tableView.isEditing = false
            } else {
//                tableView.isEditing = true
                setNavBarRightBtn(view: self, title: "保存", selector: #selector(actionSave))
                self.setEditing(true,animated: true)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension WarehouseManagerViewController: UITableViewDelegate, UITableViewDataSource {
    
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
//        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_IDENTIFY_ID, for: indexPath)
//        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: CELL_IDENTIFY_ID)
        var cell = UITableViewCell()
        cell = tableView.dequeueReusableCell(withIdentifier: SimpleBasicsCell.identifier, for: indexPath)

        cell.textLabel?.text = _data["name"]
        cell.textLabel?.font = Specs.font.regular
        
        cell.detailTextLabel?.text = "\(_data["province"]!) \(_data["city"]!) \(_data["area"]!) \(_data["detail"]!)"
        cell.detailTextLabel?.font = Specs.font.regular
        
        cell.tag = Int(_data["id"]!)!
        
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        var _data = self.dataArr[indexPath.item]
        _data["region"] = "\(_data["province"]!) \(_data["city"]!) \(_data["area"]!)"
        if (_data["maxId"] != nil) {
            _data["maxId"] = nil
        }
        let _target = WarehouseOperateViewController()
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
        
//        tableView.endEditing(true)
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
