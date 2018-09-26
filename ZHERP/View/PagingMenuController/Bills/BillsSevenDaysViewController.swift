//
//  BillsSevenDaysViewController.swift
//  ZHERP
//
//  Created by MrParker on 2018/9/7.
//  Copyright © 2018 MrParker. All rights reserved.
//

import UIKit

class BillsSevenDaysViewController: UIViewController {
    
    var tableView: UITableView!
    let CELL_IDENTIFY_ID = "CELL_IDENTIFY_ID"
    
    var dataArr = [
        ["datetime": "2018-09-06", "quantity": "516", "amount": "1999.00"],
        ["datetime": "2018-08-06", "quantity": "4456", "amount": "2999.00"],
        ["datetime": "2018-07-06", "quantity": "536", "amount": "3999.00"],
        ["datetime": "2018-06-06", "quantity": "560", "amount": "99.00"],
        ["datetime": "2018-05-06", "quantity": "569", "amount": "9.00"],
        ["datetime": "2018-04-06", "quantity": "7656", "amount": "345679.00"],
        ["datetime": "2018-03-06", "quantity": "256", "amount": "5645354657.00"],
        ["datetime": "2018-02-06", "quantity": "596", "amount": "569.00"],
        ["datetime": "2018-01-06", "quantity": "1256", "amount": "9666779.00"],
        ["datetime": "2018-09-05", "quantity": "23456", "amount": "933259.00"],
        ["datetime": "2018-09-04", "quantity": "5t56", "amount": "9966439.00"],
        ["datetime": "2018-09-03", "quantity": "509096", "amount": "9954469.00"],
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = Specs.color.white
        
        self._setup()
        // Do any additional setup after loading the view.
    }
    
    func _setup() {
        let _billReportView = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 180.0))
        self.view.addSubview(_billReportView)
        
        let _billReportViewController = BillsReportViewController()
        _billReportViewController.reportData = [
            "todayTotal": "1148.00",
            "todayReceiptNumber": "335",
            "historyShipments": "5543",
            "todayShipments": "2002",
            "residueShipments": "9093"
        ]
        self.addChildViewController(_billReportViewController)
        _billReportView.addSubview(_billReportViewController.view)
        
        //创建表视图
        let _tableViewY = _billReportView.frame.size.height
        let _tableViewH = ScreenHeight - GlobalNavHeight - _tableViewY - 40
        self.tableView = UITableView(frame: CGRect(x: 0, y: _tableViewY, width: ScreenWidth, height: _tableViewH), style: .grouped)
        
        // delegate
        let _delegate = BillsDelegateDataSource()
        _delegate.dataArr = self.dataArr
        _delegate.CELL_IDENTIFY_ID = self.CELL_IDENTIFY_ID
        self.addChildViewController(_delegate)
        
        self.tableView!.delegate = _delegate
        self.tableView!.dataSource = _delegate
        self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: CELL_IDENTIFY_ID)
        self.tableView!.register(SimpleBasicsCell.self, forCellReuseIdentifier: SimpleBasicsCell.identifier)
        self.tableView?.register(UINib(nibName: "BillsDailyReportTableViewCell", bundle: nil), forCellReuseIdentifier: CELL_IDENTIFY_ID)
        self.tableView!.tableHeaderView = UIView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0.1))
        self.view.addSubview(self.tableView!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
