//
//  NoDisturbingViewController.swift
//  ZHERP
//
//  Created by MrParker on 2018/7/25.
//  Copyright © 2018 MrParker. All rights reserved.
//

import UIKit

class NoDisturbingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var items:[String] = ["开启","只在夜间开启","关闭"]
    
    //存储选中单元格的索引
    var selectedIndexs = [Int]()
    
    var tableView:UITableView?
    
    override func loadView() {
        super.loadView()
        
        self.view.backgroundColor = Specs.color.white
        
        // set bar title
        setNavBarTitle(view: self, title: "功能消息免打扰")
        
        // set right btn
        let selector: Selector = #selector(btnClick)
        setNavBarRightBtn(view: self, title: "保存", selector: selector)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //创建表视图
        self.tableView = UITableView(frame: self.view.frame, style:.grouped)
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        //创建一个重用的单元格
        self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: "SwiftCell")
        //去除单元格分隔线
        self.tableView!.separatorStyle = .singleLine
        //去除表格上放多余的空隙
        self.tableView!.contentInset = UIEdgeInsetsMake(-10, 0, 0, 0)
        self.view.addSubview(self.tableView!)
    }
    
    //在本例中，只有一个分区
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    //返回表格行数（也就是返回控件数）
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
//    
//    //设置分组头的高度
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return tableView.sectionHeaderHeight + 50
//    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "开启后，手机不会振动与发出提示音；如果设置为“只在夜间开启”，则只在22:00到08:00间生效"
    }
    
    //创建各单元显示内容(创建参数indexPath指定的单元）
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
            //为了提供表格显示性能，已创建完成的单元需重复使用
            let identify:String = "SwiftCell"
            //同一形式的单元格重复使用，在声明时已注册
            let cell = tableView.dequeueReusableCell(withIdentifier: identify, for: indexPath) as UITableViewCell
            
            cell.textLabel?.text = self.items[indexPath.row]
            
            //判断是否选中（选中单元格尾部打勾）
            if selectedIndexs.contains(indexPath.row) {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
            
            return cell
    }
    
    // UITableViewDelegate 方法，处理列表项的选中事件
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //判断该行原先是否选中
        if let index = selectedIndexs.index(of: indexPath.row){
            selectedIndexs.remove(at: index) //原来选中的取消选中
        }else{
            selectedIndexs.removeAll() // 单选
            selectedIndexs.append(indexPath.row) //原来没选中的就选中
        }
        
        //刷新该行
//        self.tableView?.reloadRows(at: [indexPath], with: .automatic)
        
        self.tableView?.reloadData()
    }
    
    //确定按钮点击
    @IBAction func btnClick(_ sender: AnyObject) {
        print("选中项的索引为：", selectedIndexs)
        print("选中项的值为：")
        for index in selectedIndexs {
            print(items[index])
        }
        _alert(view: self, message: "保存成功", handler: _sure)
    }
    
    func _sure(alert: UIAlertAction!) {
        _back(view: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
