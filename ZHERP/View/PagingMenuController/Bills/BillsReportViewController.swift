//
//  BillsReportViewController.swift
//  ZHERP
//
//  Created by MrParker on 2018/9/6.
//  Copyright © 2018年 MrParker. All rights reserved.
//

import UIKit

class BillsReportViewController: UIViewController {
    
    var todayTotalValue: UILabel!
    var todayReceiptNumberValue: UILabel!
    var historyShipmentsValue: UILabel!
    var todayShipmentsValue: UILabel!
    var residueShipmentsValue: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = Specs.color.white
        
        self._setup()
        // Do any additional setup after loading the view.
    }
    
    func _setUILabel(label: UILabel, text: String) {
        label.text = text
        label.textAlignment = .center
        label.sizeToFit()
        label.font = Specs.font.regular
    }
    
    func _setup() {
        
        // Top separator
        let separatorTop = UILabel()
        separatorTop.backgroundColor = UIColor(hex: 0xe7e7e7)
        self.view.addSubview(separatorTop)
        separatorTop.snp.makeConstraints {(make) -> Void in
            make.left.right.top.equalTo(0)
            make.height.equalTo(1)
        }
        
        // 今日收款 Label
        let todayTotalLabel = UILabel()
        self._setUILabel(label: todayTotalLabel, text: "总收款")
        todayTotalLabel.textAlignment = .left
        todayTotalLabel.textColor = Specs.color.gray
        self.view.addSubview(todayTotalLabel)
        todayTotalLabel.snp.makeConstraints {(make) -> Void in
            let _left = (ScreenWidth / 2 - todayTotalLabel.frame.size.width) / 2
            make.left.equalTo(_left)
            make.height.equalTo(20)
            make.top.equalTo(15)
        }
        
        // 今日收款 Value
        self.todayTotalValue = UILabel()
        self._setUILabel(label: self.todayTotalValue, text: "12345.00")
        self.todayTotalValue.textAlignment = .left
        self.todayTotalValue.textColor = UIColor(hex: 0x5faaff)
        self.todayTotalValue.font = UIFont.systemFont(ofSize: 25.0)
        self.view.addSubview(self.todayTotalValue)
        self.todayTotalValue.snp.makeConstraints {(make) -> Void in
            make.centerX.equalTo(todayTotalLabel)
            make.top.equalTo(todayTotalLabel.snp.bottom).offset(5)
        }
        
        // 今日收款 元
        let todayTotalCurrency = UILabel()
        self._setUILabel(label: todayTotalCurrency, text: "元")
        todayTotalCurrency.textAlignment = .left
        todayTotalCurrency.textColor = Specs.color.gray
        todayTotalCurrency.font = UIFont.systemFont(ofSize: 12.0)
        self.view.addSubview(todayTotalCurrency)
        todayTotalCurrency.snp.makeConstraints {(make) -> Void in
            make.left.equalTo(self.todayTotalValue.snp.right).offset(5)
            make.bottom.equalTo(self.todayTotalValue.snp.bottom).offset(-2)
            make.height.equalTo(20)
        }
        
        // 分隔线
        let separator = UIView()
        separator.backgroundColor = UIColor(hex: 0xf7f7f7)
        self.view.addSubview(separator)
        separator.snp.makeConstraints {(make) -> Void in
            make.left.equalTo(ScreenWidth / 2)
            make.bottom.equalTo(self.todayTotalValue.snp.bottom)
            make.height.equalTo(self.todayTotalValue.snp.height)
            make.width.equalTo(1)
        }
        
        // 收款笔数 Label
        let todayReceiptNumberLabel = UILabel()
        self._setUILabel(label: todayReceiptNumberLabel, text: "总笔数")
        todayReceiptNumberLabel.textAlignment = .left
        todayReceiptNumberLabel.textColor = Specs.color.gray
        self.view.addSubview(todayReceiptNumberLabel)
        todayReceiptNumberLabel.snp.makeConstraints {(make) -> Void in
            let _left = (ScreenWidth / 2 - todayReceiptNumberLabel.frame.size.width) / 2 + ScreenWidth / 2
            make.left.equalTo(_left)
            make.height.equalTo(20)
            make.top.equalTo(todayTotalLabel.snp.top)
        }
        // 收款笔数 Value
        self.todayReceiptNumberValue = UILabel()
        self._setUILabel(label: self.todayReceiptNumberValue, text: "123")
        self.todayReceiptNumberValue.textAlignment = .left
        self.todayReceiptNumberValue.textColor = UIColor.orange
        self.todayReceiptNumberValue.font = UIFont.systemFont(ofSize: 25.0)
        self.view.addSubview(self.todayReceiptNumberValue)
        self.todayReceiptNumberValue.snp.makeConstraints {(make) -> Void in
            make.centerX.equalTo(todayReceiptNumberLabel)
            make.top.equalTo(self.todayTotalValue.snp.top)
        }
        
        // 收款笔数 元
        let todayReceiptNumberUnit = UILabel()
        self._setUILabel(label: todayReceiptNumberUnit, text: "笔")
        todayReceiptNumberUnit.textAlignment = .left
        todayReceiptNumberUnit.textColor = Specs.color.gray
        todayReceiptNumberUnit.font = UIFont.systemFont(ofSize: 12.0)
        self.view.addSubview(todayReceiptNumberUnit)
        todayReceiptNumberUnit.snp.makeConstraints {(make) -> Void in
            make.left.equalTo(self.todayReceiptNumberValue.snp.right).offset(5)
            make.bottom.equalTo(self.todayReceiptNumberValue.snp.bottom).offset(-2)
            make.height.equalTo(20)
        }
        
        
        // Middle separator
        let separatorMiddle = UILabel()
        separatorMiddle.backgroundColor = UIColor(hex: 0xf7f7f7)
        self.view.addSubview(separatorMiddle)
        separatorMiddle.snp.makeConstraints {(make) -> Void in
            make.left.right.equalTo(0)
            make.height.equalTo(1)
            make.top.equalTo(todayTotalValue.snp.bottom).offset(5)
        }
        
        // 历史发货 View
        let historyShipmentsView = UIView()
        //        historyShipmentsView.backgroundColor = UIColor.clear
        self.view.addSubview(historyShipmentsView)
        historyShipmentsView.snp.makeConstraints {(make) -> Void in
            make.left.equalTo(0)
            make.top.equalTo(self.todayTotalValue.snp.bottom).offset(15)
            make.height.equalTo(50)
        }
        // 历史发货 label
        let historyShipmentsLabel = UILabel()
        self._setUILabel(label: historyShipmentsLabel, text: "历史发货")
        historyShipmentsLabel.textColor = Specs.color.gray
        historyShipmentsView.addSubview(historyShipmentsLabel)
        historyShipmentsLabel.snp.makeConstraints {(make) -> Void in
            make.left.right.equalTo(0)
            make.top.equalTo(0)
            make.height.equalTo(20)
        }
        // 历史发货 Value
        self.historyShipmentsValue = UILabel()
        self._setUILabel(label: self.historyShipmentsValue, text: "1230")
        self.historyShipmentsValue.textColor = Specs.color.black
        historyShipmentsView.addSubview(self.historyShipmentsValue)
        self.historyShipmentsValue.snp.makeConstraints {(make) -> Void in
            make.left.right.equalTo(0)
            make.top.equalTo(historyShipmentsLabel.snp.bottom).offset(5)
            make.height.equalTo(20)
        }
        
        // 分隔线
        let separatorLeft = UIView()
        separatorLeft.backgroundColor = UIColor(hex: 0xf7f7f7)
        self.view.addSubview(separatorLeft)
        separatorLeft.snp.makeConstraints {(make) -> Void in
            make.left.equalTo(historyShipmentsView.snp.right)
            make.bottom.equalTo(historyShipmentsView.snp.bottom).offset(-5)
            make.height.equalTo(historyShipmentsView.snp.height).offset(-10)
            make.width.equalTo(1)
        }
        
        // 今日发货 View
        let todayShipmentsView = UIView()
        //        todayShipmentsView.backgroundColor = UIColor.clear
        self.view.addSubview(todayShipmentsView)
        todayShipmentsView.snp.makeConstraints {(make) -> Void in
            make.left.equalTo(historyShipmentsView.snp.right)
            make.top.equalTo(historyShipmentsView.snp.top)
            make.height.equalTo(historyShipmentsView.snp.height)
            make.width.equalTo(historyShipmentsView.snp.width)
        }
        // 今日发货 label
        let todayShipmentsLabel = UILabel()
        self._setUILabel(label: todayShipmentsLabel, text: "今日发货")
        todayShipmentsLabel.textColor = Specs.color.gray
        todayShipmentsView.addSubview(todayShipmentsLabel)
        todayShipmentsLabel.snp.makeConstraints {(make) -> Void in
            make.left.right.equalTo(0)
            make.top.equalTo(0)
            make.height.equalTo(20)
        }
        // 今日发货 Value
        self.todayShipmentsValue = UILabel()
        self._setUILabel(label: self.todayShipmentsValue, text: "4560")
        self.todayShipmentsValue.textColor = Specs.color.black
        todayShipmentsView.addSubview(self.todayShipmentsValue)
        self.todayShipmentsValue.snp.makeConstraints {(make) -> Void in
            make.left.right.equalTo(0)
            make.top.equalTo(todayShipmentsLabel.snp.bottom).offset(5)
            make.height.equalTo(20)
        }
        
        // 分隔线
        let separatorRight = UIView()
        separatorRight.backgroundColor = UIColor(hex: 0xf7f7f7)
        self.view.addSubview(separatorRight)
        separatorRight.snp.makeConstraints {(make) -> Void in
            make.left.equalTo(todayShipmentsView.snp.right)
            make.bottom.equalTo(todayShipmentsView.snp.bottom).offset(-5)
            make.height.equalTo(todayShipmentsView.snp.height).offset(-10)
            make.width.equalTo(1)
        }
        
        // 剩余发货 View
        let residueShipmentsView = UIView()
        //        residueShipmentsView.backgroundColor = UIColor.clear
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
        self._setUILabel(label: residueShipmentsLabel, text: "剩余发货")
        residueShipmentsLabel.textColor = Specs.color.gray
        residueShipmentsView.addSubview(residueShipmentsLabel)
        residueShipmentsLabel.snp.makeConstraints {(make) -> Void in
            make.left.right.equalTo(0)
            make.top.equalTo(0)
            make.height.equalTo(20)
        }
        // 剩余发货 Value
        self.residueShipmentsValue = UILabel()
        self._setUILabel(label: self.residueShipmentsValue, text: "7890")
        self.residueShipmentsValue.textColor = Specs.color.black
        residueShipmentsView.addSubview(self.residueShipmentsValue)
        self.residueShipmentsValue.snp.makeConstraints {(make) -> Void in
            make.left.right.equalTo(0)
            make.top.equalTo(residueShipmentsLabel.snp.bottom).offset(5)
            make.height.equalTo(20)
        }
        
        let _tableHeader = UIView()
        _tableHeader.backgroundColor = UIColor(hex: 0xf7f7f7)
        self.view.addSubview(_tableHeader)
        _tableHeader.snp.makeConstraints {(make) -> Void in
            make.left.right.equalTo(0)
            make.top.equalTo(self.residueShipmentsValue.snp.bottom).offset(10)
            make.height.equalTo(40.0)
        }
        
        let _date = UILabel()
        _date.text = "日期"
        _date.font = Specs.font.regular
        _date.textAlignment = .center
        _tableHeader.addSubview(_date)
        _date.snp.makeConstraints {(make) -> Void in
            make.left.equalTo(0)
            make.top.equalTo(10)
            make.height.equalTo(20)
        }
        
        let _quantity = UILabel()
        _quantity.text = "交易笔数"
        _quantity.font = Specs.font.regular
        _quantity.textAlignment = .center
        _tableHeader.addSubview(_quantity)
        _quantity.snp.makeConstraints {(make) -> Void in
            make.left.equalTo(_date.snp.right)
            make.top.equalTo(_date.snp.top)
            make.height.equalTo(_date.snp.height)
            make.width.equalTo(_date.snp.width)
        }
        
        let _amount = UILabel()
        _amount.text = "交易金额(元)"
        _amount.font = Specs.font.regular
        _amount.textAlignment = .center
        _tableHeader.addSubview(_amount)
        _amount.snp.makeConstraints {(make) -> Void in
            make.left.equalTo(_quantity.snp.right)
            make.top.equalTo(_date.snp.top)
            make.height.equalTo(_date.snp.height)
            make.width.equalTo(_date.snp.width)
            make.right.equalTo(0)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
