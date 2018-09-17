//
//  WSupplierOperateViewController.swift
//  ZHERP
//
//  Created by MrParker on 2018/9/4.
//  Copyright © 2018年 MrParker. All rights reserved.
//

import UIKit
import SnapKit

class WSupplierOperateViewController: UIViewController {
    
    let Id: Int = 0
    var navTitle: String? = nil
    var valueArr = [String: String]()
    var tableView: UITableView!
    let CELL_IDENTIFY_ID = "CELL_IDENTIFY_ID"
    
    var addressPickerView: UIViewController!
    
    var callBackAssign: assignArrayClosure?
    
    let dataArr = [
        ["title":"供应商名称", "key":"name","value":"未填写"],
        ["title":"供应商区域", "key":"region","value":"未选择"],
        ["title":"详细地址", "key":"detail","value":"未填写"],
        ["title":"联系人姓名", "key":"username","value":"未填写"],
        ["title":"联系人电话", "key":"telephone","value":"未填写"]
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
                _alert(view: self, message: "请完整填写供应商信息")
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
    
    @objc func actionCall() {
        self._shared_open(scheme: "tel://\(self.valueArr["telephone"]!)")
    }
    
    func _shared_open(scheme: String) {
        if let url = URL(string: scheme) {
            if #available(iOS 10, *) {
//                let options = [UIApplicationOpenURLOptionUniversalLinksOnly : true] // 打开URL
                UIApplication.shared.open(url, options: [:], completionHandler: { (success) in
                    print("Open \(scheme): \(success)")
                })
            } else {
                let success = UIApplication.shared.openURL(url)
                print("Open \(scheme): \(success)")
            }
        }
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

extension WSupplierOperateViewController: UITableViewDelegate, UITableViewDataSource {
    
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
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let memberView = UIView()
        memberView.backgroundColor = UIColor.clear
        
        let tipLabel = UILabel()
        tipLabel.text = "填写完整后不要忘了点击保存喔。"
        tipLabel.textColor = UIColor(hex: 0x666666)
        tipLabel.font = Specs.font.small
        tipLabel.sizeToFit()
        memberView.addSubview(tipLabel)
        tipLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(10)
            make.left.equalTo(20)
        }
        if (self.valueArr["telephone"]?.isEmpty)! {
            return memberView
        }
        
        let telephone: String = self.valueArr["telephone"]!
        let _btn = UIButton(frame: CGRect(x: 20, y: 40, width: ScreenWidth - 40, height: 40))
        _btn.setTitle("立即拨号(\(telephone))", for: .normal)
        _btn.setTitleColor(Specs.color.white, for: UIControlState())
        _btn.backgroundColor = Specs.color.main
        _btn.layer.cornerRadius = Specs.border.radius
        _btn.layer.masksToBounds = true
        _btn.titleLabel?.font = UIFont.systemFont(ofSize: Specs.fontSize.regular)
        _btn.addTarget(self, action: #selector(actionCall), for: .touchUpInside)
        memberView.addSubview(_btn)
        
        return memberView
    }
    
    //设置分组尾的高度
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 120
    }
    
    //创建各单元显示内容(创建参数indexPath指定的单元）
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let _data = dataArr[indexPath.item]
        let key: String = dataArr[indexPath.item]["key"]!

        var cell = UITableViewCell()
        cell = tableView.dequeueReusableCell(withIdentifier: SimpleBasicsCell.identifier, for: indexPath)
        
        cell.textLabel?.text = _data["title"]
        cell.textLabel?.font = Specs.font.regular
        var detailTextLabel: String = ""
        switch key {
        case "name":
            detailTextLabel = !(self.valueArr["name"]?.isEmpty)! ? self.valueArr["name"]! : _data["value"]!
        case "username":
            detailTextLabel = !(self.valueArr["username"]?.isEmpty)! ? self.valueArr["username"]! : _data["value"]!
        case "telephone":
            detailTextLabel = !(self.valueArr["telephone"]?.isEmpty)! ? self.valueArr["telephone"]! : _data["value"]!
        case "region":
            detailTextLabel = !(self.valueArr["region"]?.isEmpty)! ? self.valueArr["region"]! : _data["value"]!
        case "detail":
            detailTextLabel = !(self.valueArr["detail"]?.isEmpty)! ? self.valueArr["detail"]! : _data["value"]!
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
        
        if (key == "region") {
            let _target = AddressPickerViewController(province: self.valueArr["province"]!, city: self.valueArr["city"]!, area: self.valueArr["area"]!)
            _target.callBackAssign = {(assignValue: String) -> Void in
                if (!assignValue.isEmpty) {
                    self.valueArr[key] = assignValue
                    let _region : Array = assignValue.components(separatedBy: " ")
                    self.valueArr["province"] = _region[0]
                    self.valueArr["city"] = _region[1]
                    self.valueArr["area"] = _region[2]
                    tableView.reloadData()
                }
            }
            _target.setAddressPickerView(view: self)
            return
        }
        
        let _target = WarehouseDetailViewController()
        _target.navTitle = _data["title"]
        _target.callBackAssign = {(assignValue: String) -> Void in
            if (!assignValue.isEmpty) {
                self.valueArr[key] = assignValue
                tableView.reloadData()
            }
        }
        switch key {
        case "name":
            _target.placeholder = "最多输入十五个字"
            _target.value = (self.valueArr["name"] != nil) ? self.valueArr["name"] : _data["value"]
        case "username":
            _target.placeholder = "最多输入十五个字"
            _target.value = (self.valueArr["username"] != nil) ? self.valueArr["username"] : _data["value"]
        case "telephone":
            _target.placeholder = "请输入联系电话号码"
            _target._value.keyboardType = UIKeyboardType.phonePad
            _target._value.font = Specs.font.large
            _target.value = (self.valueArr["telephone"] != nil) ? self.valueArr["telephone"] : _data["value"]
        case "detail":
            _target.placeholder = "请输入仓库详细地址"
            _target.value = (self.valueArr["detail"] != nil) ? self.valueArr["detail"] : _data["value"]
        default:
            _target.Id = indexPath.row + 1
        }
        _target.hidesBottomBarWhenPushed = true
        _push(view: self, target: _target, rootView: false)
        
    }
}
