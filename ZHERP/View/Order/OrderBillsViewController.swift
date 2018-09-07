//
//  OrderBillsViewController.swift
//  ZHERP
//
//  Created by MrParker on 2018/9/6.
//  Copyright © 2018 MrParker. All rights reserved.
//

import UIKit

class OrderBillsViewController: UIViewController {

    var pageMenuView: UIView!
    var orderPageMenuView: OrderBillsPagesViewController?
    var navHeight: CGFloat!
    var datePickerValue: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Specs.color.white
        
        setNavBarTitle(view: self, title: "账单")
        setNavBarBackBtn(view: self, title: "历史账单", selector: #selector(actionBack))
        setNavBarRightBtn(view: self, title: "更多", selector: #selector(actionMore))
        
        self._setUp()
        // Do any additional setup after loading the view.
    }
    
    @objc func actionBack() {
        
    }
    
    @objc func actionMore() {
        let date = dateFromString(self.datePickerValue == nil ? SYSTEM_DATE : self.datePickerValue)!
        setDatePickerView(view: self, datePickerValue: date, selector: #selector(dateChanged), handler: getPickerViewValue)
    }
    
    //触摸按钮时，获得被选中的索引
    @objc func getPickerViewValue(_: UIAlertAction)->Void {
        let _date = self.datePickerValue == nil ? SYSTEM_DATE : self.datePickerValue
        let _target = BillsDaliyDetailViewController()
        _target.navTitle = _date
        _target.datePickerValue = _date
        _target.hidesBottomBarWhenPushed = true
        _push(view: self, target: _target, rootView: false)
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
        GlobalNavHeight = self.navHeight
        
        self.pageMenuView = UIView(frame: CGRect(x: 0, y: self.navHeight, width: ScreenWidth, height: ScreenHeight))
        self.view.addSubview(self.pageMenuView)
        
        self.orderPageMenuView = OrderBillsPagesViewController()
        self.addChildViewController(self.orderPageMenuView!)
        self.pageMenuView.addSubview((self.orderPageMenuView?.view)!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
