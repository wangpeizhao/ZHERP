//
//  BillsDelegateDataSourceViewController.swift
//  ZHERP
//
//  Created by MrParker on 2018/9/6.
//  Copyright © 2018年 MrParker. All rights reserved.
//

import UIKit

class BillsDelegateDataSourceViewController: UIViewController {
    
    var dataArr = [[String: String]]()
    var CELL_IDENTIFY_ID: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension BillsDelegateDataSourceViewController: UITableViewDelegate, UITableViewDataSource {
    
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
        return "点击查看每日账单详情"
    }
    
    //设置分组尾的高度
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 30
    }
    
    //创建各单元显示内容(创建参数indexPath指定的单元）
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let _data = dataArr[indexPath.item]
        let cell: BillsDailyReportTableViewCell = tableView.dequeueReusableCell(withIdentifier: CELL_IDENTIFY_ID, for: indexPath) as! BillsDailyReportTableViewCell

        cell.dateLabel.text = _data["datetime"]
        cell.dateLabel.sizeToFit()
        
        cell.quantityLabel.text = _data["quantity"]
        cell.quantityLabel.sizeToFit()
        cell.quantityLabel.frame.origin.x = 20.0
        
        cell.amountLabel.text = _data["amount"]
        cell.amountLabel.sizeToFit()
        cell.amountLabel.frame.origin.x = 40.0
        
        cell.accessoryType = .none
        
        return cell
    }
    
    // UITableViewDelegate 方法，处理列表项的选中事件
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let _data = dataArr[indexPath.item]
        
        let _target = BillsDaliyDetailViewController()
        _target.navTitle = _data["datetime"]
        _target.todayTotal = _data["amount"]!
        _target.todayReceiptNumber = _data["quantity"]!
        
        _target.hidesBottomBarWhenPushed = true
        _push(view: self, target: _target, rootView: false)
    }
}
