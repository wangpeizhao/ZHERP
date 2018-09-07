//
//  DatePicker.swift
//  ZHERP
//
//  Created by MrParker on 2018/9/7.
//  Copyright © 2018 MrParker. All rights reserved.
//

import UIKit

public func setDatePickerView(view: UIViewController,datePickerValue: Date, selector: Selector, handler: ((UIAlertAction)->Void)?){
    let alertController = UIAlertController(title: "请选择日期\n\n\n\n\n\n\n\n\n\n", message: "", preferredStyle: UIAlertControllerStyle.actionSheet)
    
    let DestructiveAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel) {
        (result : UIAlertAction) -> Void in
        // todo
    }
    let okAction = UIAlertAction(title: "确定", style: UIAlertActionStyle.default, handler: handler)
    
    //创建日期选择器
    let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 30, width: ScreenWidth, height: 216))
    //将日期选择器区域设置为中文，则选择器日期显示为中文
    datePicker.locale = Locale(identifier: "zh_CN")
    //注意：action里面的方法名后面需要加个冒号“：”
    datePicker.addTarget(view, action: selector, for: .valueChanged)
    
    datePicker.timeZone = TimeZone.current
    // 日期模式
    datePicker.datePickerMode = .date
    // 设置值
    datePicker.date = datePickerValue
    
    datePicker.maximumDate = dateFromString(SYSTEM_DATE)
    
    alertController.view.addSubview(datePicker)
    
    alertController.addAction(DestructiveAction)
    alertController.addAction(okAction)
    view.present(alertController, animated: true, completion: nil)
}
