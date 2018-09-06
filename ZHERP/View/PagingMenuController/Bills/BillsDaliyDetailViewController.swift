//
//  BillsDaliyDetailViewController.swift
//  ZHERP
//
//  Created by MrParker on 2018/9/6.
//  Copyright © 2018年 MrParker. All rights reserved.
//

import UIKit

class BillsDaliyDetailViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var navTitle: String!
    var navHeight: CGFloat!
    var tableView: UITableView!
    let CELL_IDENTIFY_ID = "CELL_IDENTIFY_ID"
    var selectedCellIndexPaths: [IndexPath] = []
    
    var datePickerValue: String!
    
    let dataArr = [
        ["name":"今日账单"],
        ["name":"今日账单"],
        ["name":"今日账单"],
        ["name":"今日账单"],
        ["name":"今日账单"],
        ["name":"今日账单"],
        ["name":"今日账单"],
        ["name":"今日账单"],
        ["name":"今日账单"],
        ["name":"今日账单"],
        ["name":"今日账单"],
        ["name":"今日账单"],
        ["name":"今日账单"],
        ["name":"今日账单"],
        ["name":"今日账单"],
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavBarTitle(view: self, title: self.navTitle)
        setNavBarBackBtn(view: self, title: "历史账单", selector: #selector(actionBack))
        setNavBarRightBtn(view: self, title: "更多", selector: #selector(actionMore))

        self._setUp()
        // Do any additional setup after loading the view.
    }
    
    @objc func actionBack() {
        
    }
    
    @objc func actionMore() {
        self._setDatePickerView()
    }
    
    public func _setDatePickerView(){
        let alertController = UIAlertController(title: "请选择日期\n\n\n\n\n\n\n\n\n\n", message: "", preferredStyle: UIAlertControllerStyle.actionSheet)
        
        let DestructiveAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel) {
            (result : UIAlertAction) -> Void in
            // todo
        }
        let okAction = UIAlertAction(title: "确定", style: UIAlertActionStyle.default, handler: getPickerViewValue)
        
        //创建日期选择器
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 30, width: ScreenWidth, height: 216))
        //将日期选择器区域设置为中文，则选择器日期显示为中文
        datePicker.locale = Locale(identifier: "zh_CN")
        //注意：action里面的方法名后面需要加个冒号“：”
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        datePicker.datePickerMode = .date
        alertController.view.addSubview(datePicker)
        
        alertController.addAction(DestructiveAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    //触摸按钮时，获得被选中的索引
    @objc func getPickerViewValue(_: UIAlertAction)->Void {
        self.title = self.datePickerValue == nil ? SYSTEM_DATE : self.datePickerValue
        print(self.title!)
    }
    
    //日期选择器响应方法
    @objc func dateChanged(datePicker : UIDatePicker){
        //更新提醒时间文本框
        let formatter = DateFormatter()
        //日期样式
        formatter.dateFormat = "yyyy-MM-dd" //"yyyy年MM月dd日 HH:mm:ss"
        
        self.datePickerValue = formatter.string(from: datePicker.date)
    }
    
    private func _setUp() {
        self.navHeight = self.navigationController?.navigationBar.frame.maxY
        
        let _billReportView = UIView(frame: CGRect(x: 0, y: self.navHeight, width: ScreenWidth, height: 140.0))
        self.view.addSubview(_billReportView)
        
        let _billReportViewController = BillsReportViewController()
        _billReportViewController.tableHeader = false
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
        let _tableViewY = _billReportView.frame.size.height + self.navHeight
        let _tableViewH = ScreenHeight - _tableViewY
        self.tableView = UITableView(frame: CGRect(x: 0, y: _tableViewY, width: ScreenWidth, height: _tableViewH), style: .grouped)
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: CELL_IDENTIFY_ID)
        self.tableView!.register(SimpleBasicsCell.self, forCellReuseIdentifier: SimpleBasicsCell.identifier)
        // 可展开
        self.tableView?.register(UINib(nibName: "OrderTodayBillTableViewCell", bundle: nil), forCellReuseIdentifier: "OrderTodayBillTableViewCell")
        self.tableView!.tableHeaderView = UIView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0.1))
        self.view.addSubview(self.tableView!)
        
        // 长按启动删除、移动排序功能
        let longPress = UILongPressGestureRecognizer.init(target: self, action: #selector(longPressAction))
        longPress.delegate = self
        longPress.minimumPressDuration = 1
        self.tableView!.addGestureRecognizer(longPress)
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
            _alert(view: self, message: "Copy Success")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension BillsDaliyDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataArr.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ""
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.selectedCellIndexPaths.contains(indexPath) {
            return 150
        }
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
        if section == self.dataArr.count - 1 {
            return "当日账单；点击可展开更多；长按复制交易单号。"
        }
        return ""
    }
    
    //设置分组尾的高度
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 30
    }
    
    //创建各单元显示内容(创建参数indexPath指定的单元）
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: OrderTodayBillTableViewCell = tableView.dequeueReusableCell(withIdentifier: "OrderTodayBillTableViewCell") as! OrderTodayBillTableViewCell
        cell.layer.masksToBounds = true
        
        return cell
    }
    
    // UITableViewDelegate 方法，处理列表项的选中事件
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView!.deselectRow(at: indexPath, animated: false)
        if let index = self.selectedCellIndexPaths.index(of: indexPath) {
            self.selectedCellIndexPaths.remove(at: index)
        }else{
            self.selectedCellIndexPaths.append(indexPath)
        }
        //强制改变高度
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
}
