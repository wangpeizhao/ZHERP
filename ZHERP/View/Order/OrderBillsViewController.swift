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
        let _target = BillsDaliyDetailViewController()
        _target.navTitle = self.datePickerValue == nil ? SYSTEM_DATE : self.datePickerValue
        
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
