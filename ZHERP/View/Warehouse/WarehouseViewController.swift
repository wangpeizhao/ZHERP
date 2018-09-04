//
//  WarehouseViewController.swift
//  ZHERP
//
//  Created by MrParker on 2018/8/21.
//  Copyright © 2018年 MrParker. All rights reserved.
//

import UIKit
import SnapKit

class WarehouseViewController: UIViewController {
    
    var tableView: UITableView!
    let CELL_IDENTIFY_ID = "CELL_IDENTIFY_ID"
    
    let dataArr = [
        ["name":"货品管理", "key":"goods","pic":"swift.png"],
        ["name":"仓库管理", "key":"warehouse","pic":"xcode.png"],
        ["name":"库位管理", "key":"location","pic":"java.png"],
        ["name":"分类管理", "key":"classify","pic":"php.png"],
        ["name":"供货商管理", "key":"supplier","pic":"c#.png"]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = Specs.color.white
        setNavBarTitle(view: self, title: "仓库")
        setNavBarBackBtn(view: self, title: "仓库", selector: #selector(actionBack))
        
        self._setup()
        
        // Do any additional setup after loading the view.
    }
    
    @objc func actionBack() {
        
    }
    
    private func _setup() {
        //创建表视图
        self.tableView = UITableView(frame: self.view.frame, style:.grouped)
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        //创建一个重用的单元格
        self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: CELL_IDENTIFY_ID)
        //去除单元格分隔线
//        self.tableView!.separatorStyle = .singleLine
        //去除表格上放多余的空隙
//        self.tableView!.contentInset = UIEdgeInsetsMake(-10, 0, 0, 0)
        self.tableView?.tableHeaderView = UIView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0.1))
        self.view.addSubview(self.tableView!)
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

extension WarehouseViewController: UITableViewDelegate, UITableViewDataSource {
    
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
        let memberView = UIView()
        memberView.backgroundColor = Specs.color.white
        
        // 头像
        let _avatar = UIImage(named: "bayMax")?.toCircleTailor()
        let memberAvatar = UIImageView(image: _avatar)
        memberView.addSubview(memberAvatar)
        memberAvatar.snp.makeConstraints{ (make) -> Void in
            make.left.equalTo(20)
            make.top.equalTo(10)
            make.width.height.equalTo(64)
        }
        
        // 店铺名称
        let platformTitle = UILabel()
        platformTitle.text = "Half Step 原创设计师平台"
        platformTitle.sizeToFit()
        platformTitle.textColor = Specs.color.gray
        platformTitle.font = Specs.font.regularBold
        memberView.addSubview(platformTitle)
        platformTitle.snp.makeConstraints{ (make) -> Void in
            make.left.equalTo(memberAvatar.snp.right).offset(15)
            make.top.equalTo(memberAvatar.snp.top).offset(5)
        }
        
        // VIP
        let platformVip = UILabel()
        platformVip.text = "VIP金牌店"
        platformVip.sizeToFit()
        platformVip.textColor = Specs.color.gray
        platformVip.font = Specs.font.smallBold
        memberView.addSubview(platformVip)
        platformVip.snp.makeConstraints{ (make) -> Void in
            make.left.equalTo(platformTitle.snp.left)
            make.top.equalTo(platformTitle.snp.bottom).offset(10)
        }
        
        return memberView
    }
    
    //设置分组头的高度
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 84
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "选项前往添加、更新、删除"
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
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_IDENTIFY_ID, for: indexPath)
        let _data = dataArr[indexPath.item]
        let reSize = CGSize(width: 32, height: 32)
        let _image = UIImage(named: _data["pic"]!)?.toCircleTailor()
        cell.imageView?.image = _image?.reSizeImage(reSize: reSize)
        cell.textLabel?.text = _data["name"]
        cell.textLabel?.font = Specs.font.regular
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        var _target = UIViewController()
        let key: String = dataArr[indexPath.item]["key"]!
        switch key {
        case "goods":
            _target = ZHQRCodeViewController()
        case "warehouse":
            _target = WarehouseManagerViewController()
        case "location":
            _target = WLocationViewController()
        case "classify":
            _target = SettingsViewController()
        case "supplier":
            _target = WSupplierManagerViewController()
        default:
            _target = GoodDetailViewController()
        }
        _target.hidesBottomBarWhenPushed = true
        _push(view: self, target: _target, rootView: false)
        
    }
}
