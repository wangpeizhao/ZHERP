//
//  StatisticReportViewController.swift
//  ZHERP
//
//  Created by MrParker on 2018/9/7.
//  Copyright © 2018年 MrParker. All rights reserved.
//

import UIKit
import SnapKit

class StatisticReportViewController: UIViewController {
    
    var reportData = ["todayTotal": "23,145.89", "todayReceiptNumber": "34,535.98", "historyShipments": "2,344.98", "todayShipments": "234,234.98", "residueShipments": "2343"]
    let textColor = UIColor(hex: 0x9b9ca4)
    let separatorColor = UIColor(hex: 0x3c3a3a)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named:"StatisticBg.png")!)
        
        self._setup()
        
        // Do any additional setup after loading the view.
    }
    
    fileprivate func _setUILabel(label: UILabel, text: String) {
        label.text = text
        label.textAlignment = .center
        label.sizeToFit()
        label.font = Specs.font.regular
    }
    
    fileprivate func _setup() {
        self.view.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: 210)
        // 总流水 Label
        let _totalLabel = UILabel()
        self._setUILabel(label: _totalLabel, text: "总流水(元)")
        _totalLabel.textColor = Specs.color.gray
        self.view.addSubview(_totalLabel)
        _totalLabel.snp.makeConstraints {(make) -> Void in
            make.left.right.equalTo(0)
            make.top.equalTo(25)
        }
        
        // 总流水 Value
        let _totalValue = UILabel()
        self._setUILabel(label: _totalValue, text: reportData["todayTotal"]!)
        _totalValue.textColor = Specs.color.white
        _totalValue.font = UIFont.systemFont(ofSize: 28)
        self.view.addSubview(_totalValue)
        _totalValue.snp.makeConstraints {(make) -> Void in
            make.centerX.equalTo(_totalLabel)
            make.top.equalTo(_totalLabel.snp.bottom).offset(10)
        }
        
        // Middle separator
        let separatorMiddle = UILabel()
        separatorMiddle.backgroundColor = separatorColor
        self.view.addSubview(separatorMiddle)
        separatorMiddle.snp.makeConstraints {(make) -> Void in
            make.left.right.equalTo(0)
            make.height.equalTo(1)
            make.top.equalTo(_totalValue.snp.bottom).offset(15)
        }
        
        // 历史发货 View
        let historyShipmentsView = UIView()
        self.view.addSubview(historyShipmentsView)
        historyShipmentsView.snp.makeConstraints {(make) -> Void in
            make.left.equalTo(0)
            make.top.equalTo(separatorMiddle.snp.bottom).offset(15)
            make.height.equalTo(50)
        }
        // 历史发货 label
        let historyShipmentsLabel = UILabel()
        self._setUILabel(label: historyShipmentsLabel, text: "成本支出")
        historyShipmentsLabel.textColor = textColor
        historyShipmentsView.addSubview(historyShipmentsLabel)
        historyShipmentsLabel.snp.makeConstraints {(make) -> Void in
            make.left.right.equalTo(0)
            make.top.equalTo(0)
            make.height.equalTo(20)
        }
        // 历史发货 Value
        let historyShipmentsValue = UILabel()
        self._setUILabel(label: historyShipmentsValue, text: self.reportData["historyShipments"]!)
        historyShipmentsValue.textColor = Specs.color.white
        historyShipmentsView.addSubview(historyShipmentsValue)
        historyShipmentsValue.snp.makeConstraints {(make) -> Void in
            make.left.right.equalTo(0)
            make.top.equalTo(historyShipmentsLabel.snp.bottom).offset(5)
            make.height.equalTo(20)
        }
        
        // 分隔线
        let separatorLeft = UIView()
        separatorLeft.backgroundColor = separatorColor
        self.view.addSubview(separatorLeft)
        separatorLeft.snp.makeConstraints {(make) -> Void in
            make.left.equalTo(historyShipmentsView.snp.right)
            make.bottom.equalTo(historyShipmentsView.snp.bottom).offset(-5)
            make.height.equalTo(historyShipmentsView.snp.height).offset(-10)
            make.width.equalTo(1)
        }
        
        // 今日发货 View
        let todayShipmentsView = UIView()
        self.view.addSubview(todayShipmentsView)
        todayShipmentsView.snp.makeConstraints {(make) -> Void in
            make.left.equalTo(historyShipmentsView.snp.right)
            make.top.equalTo(historyShipmentsView.snp.top)
            make.height.equalTo(historyShipmentsView.snp.height)
            make.width.equalTo(historyShipmentsView.snp.width)
        }
        // 今日发货 label
        let todayShipmentsLabel = UILabel()
        self._setUILabel(label: todayShipmentsLabel, text: "经营利润")
        todayShipmentsLabel.textColor = textColor
        todayShipmentsView.addSubview(todayShipmentsLabel)
        todayShipmentsLabel.snp.makeConstraints {(make) -> Void in
            make.left.right.equalTo(0)
            make.top.equalTo(0)
            make.height.equalTo(20)
        }
        // 今日发货 Value
        let todayShipmentsValue = UILabel()
        self._setUILabel(label: todayShipmentsValue, text: self.reportData["todayShipments"]!)
        todayShipmentsValue.textColor = Specs.color.white
        todayShipmentsView.addSubview(todayShipmentsValue)
        todayShipmentsValue.snp.makeConstraints {(make) -> Void in
            make.left.right.equalTo(0)
            make.top.equalTo(todayShipmentsLabel.snp.bottom).offset(5)
            make.height.equalTo(20)
        }
        
        // 分隔线
        let separatorRight = UIView()
        separatorRight.backgroundColor = separatorColor
        self.view.addSubview(separatorRight)
        separatorRight.snp.makeConstraints {(make) -> Void in
            make.left.equalTo(todayShipmentsView.snp.right)
            make.bottom.equalTo(todayShipmentsView.snp.bottom).offset(-5)
            make.height.equalTo(todayShipmentsView.snp.height).offset(-10)
            make.width.equalTo(1)
        }
        
        // 剩余发货 View
        let residueShipmentsView = UIView()
        self.view.addSubview(residueShipmentsView)
        residueShipmentsView.snp.makeConstraints {(make) -> Void in
            make.left.equalTo(todayShipmentsView.snp.right)
            make.top.equalTo(historyShipmentsView.snp.top)
            make.height.equalTo(historyShipmentsView.snp.height)
            make.width.equalTo(historyShipmentsView.snp.width)
            make.right.equalTo(0)
        }
        // 剩余发货 label
        let residueShipmentsLabel = UILabel()
        self._setUILabel(label: residueShipmentsLabel, text: "订单数量")
        residueShipmentsLabel.textColor = textColor
        residueShipmentsView.addSubview(residueShipmentsLabel)
        residueShipmentsLabel.snp.makeConstraints {(make) -> Void in
            make.left.right.equalTo(0)
            make.top.equalTo(0)
            make.height.equalTo(20)
        }
        // 剩余发货 Value
        let residueShipmentsValue = UILabel()
        self._setUILabel(label: residueShipmentsValue, text: self.reportData["residueShipments"]!)
        residueShipmentsValue.textColor = Specs.color.white
        residueShipmentsView.addSubview(residueShipmentsValue)
        residueShipmentsValue.snp.makeConstraints {(make) -> Void in
            make.left.right.equalTo(0)
            make.top.equalTo(residueShipmentsLabel.snp.bottom).offset(5)
            make.height.equalTo(20)
        }
        
        // 数据统计截止到
        let _cutOffView = UIView()
        _cutOffView.backgroundColor = UIColor(hex: 0x212333)
        self.view.addSubview(_cutOffView)
        _cutOffView.snp.makeConstraints { (make) -> Void in
            make.left.right.equalTo(0)
            make.bottom.equalTo(self.view.snp.bottom)
            make.height.equalTo(40)
        }
        
        // 截止时间
        let _deadlineTip = UILabel()
        self._setUILabel(label: _deadlineTip, text: "数据统计截止到：\(SYSTEM_DATETIME)")
        _deadlineTip.textColor = textColor
        _cutOffView.addSubview(_deadlineTip)
        _deadlineTip.snp.makeConstraints { (make) -> Void in
            make.center.equalTo(_cutOffView)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
