//
//  NotifyViewController.swift
//  ZHERP
//
//  Created by MrParker on 2018/7/25.
//  Copyright © 2018 MrParker. All rights reserved.
//

import UIKit

class NotifyViewController: UIViewController, UITableViewDataSource ,UITableViewDelegate{
    
//    @IBOutlet weak var tableViewSwitch: UITableView!
//    @IBOutlet weak var tableView: UITableView!
//    @IBOutlet weak var tableView: UITableView!
    
    var tableView: UITableView?
    var dataArray: Dictionary<Int, [[String]]>?
    var headerData: Dictionary<Int, String>?
    var footerData: Dictionary<Int, String>?
    let identify: String = "NotifyCell"
    let identifySwitch: String = "tableViewCellSwitch"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = Specs.color.white
        
        setNavBarTitle(view: self, title: "新消息通知")
        
        //初始化数据，放在属性列表文件里
        self.dataArray =  [
            0:[[String]]([
                ["Receiving","接收新消息通知"]]),
            1:[[String]]([
                ["DisplayDetails","通知显示消息详情"]]),
            2:[[String]]([
                ["voice","声音"],
                ["Vibration","振动"]]),
            3:[[String]]([
                ["open","开启"],
                ["nighttime","只在夜间开启"],
                ["close","关闭"]]),
        ];
        self.footerData = [
            0: "如果你要关闭或开启纵横ERP的新消息通知,请在iPhone的“设置”-“通知”功能中,找到应用程序“纵横ERP”更改.",
            1: "关闭后,当收到纵横ERP消息时,通知提示将不再显示内容摘要",
            2: "当纵横ERP在运行时,你可以设置是否需要声音或者振动",
            3: "设置系统功能消息提示声音的振动的时段.",
        ]
        self.headerData = [3: "系统、功能消息免打扰"]
//        //创建表视图
        self.tableView = UITableView(frame:self.view.frame, style:.grouped)
//        //去除表格上放多余的空隙
        self.tableView!.contentInset = UIEdgeInsetsMake(-10, 0, 0, 0)
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        
//        self.tableViewSwitch.delegate = self
//        self.tableViewSwitch.dataSource = self
        
        //创建一个重用的单元格
        self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: identify)
        self.tableView!.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.tableView!)
        
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
    
    //设置分组头的高度
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard ((self.headerData?[section]) != nil) else {
            return 5
        }
        return tableView.sectionHeaderHeight + 50
    }
    
    //将分组尾设置为一个空的View
    //    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    //        return UIView()
    //    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let data = self.headerData?[section] else {
            return ""
        }
        return data
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        guard let data = self.footerData?[section] else {
            return ""
        }
        return data
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //为了提供表格显示性能，已创建完成的单元需重复使用
        let sectionNo = indexPath.section
        let cell: UITableViewCell?
        var data = self.dataArray?[sectionNo]!
        let _data = data![indexPath.row as Int]
        //同一形式的单元格重复使用，在声明时已注册
        if _data[0] == "Receiving" {
            cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: identify)
            cell?.accessoryType = .none
            cell?.detailTextLabel?.text = "已开启"
            cell?.detailTextLabel?.textColor = UIColor.green
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: identify, for: indexPath)
            let switchCell = cell?.viewWithTag(1) as! UISwitch
            switchCell.isOn = true
            cell?.accessoryType = .none
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

