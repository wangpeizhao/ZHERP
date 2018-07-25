//
//  SettingViewController.swift
//  ZHERP
//
//  Created by MrParker on 2018/7/23.
//  Copyright © 2018 MrParker. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController,UITableViewDataSource ,UITableViewDelegate{
    
    var tableView: UITableView?
    var dataArray: Dictionary<Int, [[String]]>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = Specs.color.white
        
        // set bar
        setNavBarTitle(view: self, title: "设置")
        
        // set back btn
        let selector: Selector = #selector(actionBack)
        setNavBarBackBtn(view: self, title: "设置", selector: selector)
        
        //初始化数据，放在属性列表文件里
        self.dataArray =  [
            0:[[String]]([
                ["security","账号与安全"]]),
            1:[[String]]([
                ["notify","新消息通知"],
                ["privacy","隐私"],
                ["common","通用"]]),
            2:[[String]]([
                ["feedback","帮助与反馈"],
                ["about","关于纵横"],
                ["version","当前版本"]]),
            3:[[String]]([
                ["logout","退出登录"]]),
        ];
        //创建表视图
        self.tableView = UITableView(frame:self.view.frame, style:.grouped)
        //去除表格上放多余的空隙
        self.tableView!.contentInset = UIEdgeInsetsMake(-10, 0, 0, 0)
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        //创建一个重用的单元格
        self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: "SettingCell")
        self.tableView!.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.tableView!)
        
    }
    
    @objc func actionBack() {
        self.hidesBottomBarWhenPushed = false
        print("MemberViewController actionBack ")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return (self.dataArray?.count)!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let dataSection = self.dataArray![section]
        return dataSection!.count
    }
    
    //设置分组尾的高度
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }
    
    //将分组尾设置为一个空的View
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //为了提供表格显示性能，已创建完成的单元需重复使用
        let identify: String = "SettingCell"
        let sectionNo = indexPath.section
        let cell: UITableViewCell?
        var data = self.dataArray?[sectionNo]!
        let _data = data![indexPath.row as Int]
        //同一形式的单元格重复使用，在声明时已注册
        if _data[0] == "version" {
            cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: identify)
            cell?.accessoryType = .disclosureIndicator
            cell?.detailTextLabel?.text = "v1.0.0"
        } else if _data[0] == "logout" {
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: identify)
            cell?.textLabel?.centerXAnchor.constraint(equalTo: (cell?.centerXAnchor)!).isActive = true
            cell?.textLabel?.textAlignment = .center
            cell?.textLabel?.textColor = Specs.color.red
            cell?.accessoryType = .none
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: identify, for: indexPath)
            cell?.accessoryType = .disclosureIndicator
        }
        
        cell?.textLabel?.text = _data[1]
        cell?.textLabel?.font = UIFont.systemFont(ofSize: Specs.fontSize.regular)
        cell?.detailTextLabel?.font = UIFont.systemFont(ofSize: Specs.fontSize.regular)
        
        return cell!
    }
    
    // UITableViewDelegate 方法，处理列表项的选中事件
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.tableView!.deselectRow(at: indexPath, animated: true)
        let modelForRow = self.dataArray![indexPath.section]![indexPath.row]
        let action: String = modelForRow[0]
        if !action.isEmpty {
            switch action {
            case "notify":
                self.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(NotifyViewController(), animated: true)
                break;
            case "logout":
                _confirm(view: self, title: "提示", message: "确定要退出吗？", handler: logout)
                break
            default: break
                
            }
        }
    }
    
    func logout(_: UIAlertAction)->Void {
        _logout()
        _open(view: self, vcName: "login", withNav: false)
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
