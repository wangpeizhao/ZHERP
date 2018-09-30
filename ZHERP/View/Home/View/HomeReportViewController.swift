//
//  HomeReportViewController.swift
//  ZHERP
//
//  Created by MrParker on 2018/8/20.
//  Copyright © 2018 MrParker. All rights reserved.
//

import UIKit
import SnapKit

class HomeReportViewController: UIViewController {
    
    var todayTotalValue: UILabel!
    var todayReceiptNumberValue: UILabel!
    var historyShipmentsValue: UILabel!
    var todayShipmentsValue: UILabel!
    var residueShipmentsValue: UILabel!
    var companyName: String = "纵横科技"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(hex: 0x1a2639)
        self._setup()

        // Do any additional setup after loading the view.
    }
    
    func _setUILabel(label: UILabel, text: String) {
        label.text = text
        label.textColor = Specs.color.white
        label.textAlignment = .center
        label.sizeToFit()
        label.font = Specs.font.regular
    }
    
    func _setup() {
//        self.view = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 200))
        
        // 客户、公司名称
        let _companyName = UILabel()
        self._setUILabel(label: _companyName, text: "广州白马商业经营管理有限公司白马服装市场经营管理服务中心")
        _companyName.textAlignment = .left
        _companyName.textColor = Specs.color.white
        _companyName.font = Specs.font.regularBold
        _companyName.numberOfLines = 2
        self.view.addSubview(_companyName)
        _companyName.snp.makeConstraints {(make) -> Void in
            make.left.equalTo(30)
//            make.height.equalTo(20)
            make.top.equalTo(30)
            make.width.equalTo(ScreenWidth - 60)
        }
        
        // 今日收款 Label
        let todayTotalLabel = UILabel()
        self._setUILabel(label: todayTotalLabel, text: "今日收款")
        todayTotalLabel.textAlignment = .left
        todayTotalLabel.textColor = UIColor(hex: 0x5d6982)
        self.view.addSubview(todayTotalLabel)
        todayTotalLabel.snp.makeConstraints {(make) -> Void in
            make.left.equalTo(30)
            make.height.equalTo(20)
            make.top.equalTo(_companyName.snp.bottom).offset(20)
        }
        
        // 今日收款 Value
        self.todayTotalValue = UILabel()
        self._setUILabel(label: self.todayTotalValue, text: "12345.00")
        self.todayTotalValue.textAlignment = .left
        self.todayTotalValue.textColor = UIColor(hex: 0x5faaff)
        self.todayTotalValue.font = UIFont.systemFont(ofSize: 35.0)
        self.view.addSubview(self.todayTotalValue)
        self.todayTotalValue.snp.makeConstraints {(make) -> Void in
            make.left.equalTo(todayTotalLabel.snp.left)
            make.top.equalTo(todayTotalLabel.snp.bottom)
        }
        
        // 今日收款 元
        let todayTotalCurrency = UILabel()
        self._setUILabel(label: todayTotalCurrency, text: "元")
        todayTotalCurrency.textAlignment = .left
        todayTotalCurrency.font = UIFont.systemFont(ofSize: 13.0)
        self.view.addSubview(todayTotalCurrency)
        todayTotalCurrency.snp.makeConstraints {(make) -> Void in
            make.left.equalTo(self.todayTotalValue.snp.right).offset(5)
            make.bottom.equalTo(self.todayTotalValue.snp.bottom).offset(-5)
            make.height.equalTo(20)
        }
        
        // 分隔线
        let separator = UIView()
        separator.backgroundColor = UIColor(hex: 0x273244)
        self.view.addSubview(separator)
        separator.snp.makeConstraints {(make) -> Void in
            make.left.equalTo(ScreenWidth / 3 * 2 + 10)
            make.bottom.equalTo(self.todayTotalValue.snp.bottom)
            make.height.equalTo(self.todayTotalValue.snp.height)
            make.width.equalTo(1)
        }
        
        // 收款笔数 Label
        let todayReceiptNumberLabel = UILabel()
        self._setUILabel(label: todayReceiptNumberLabel, text: "收款笔数")
        todayReceiptNumberLabel.textAlignment = .left
        todayReceiptNumberLabel.textColor = UIColor(hex: 0x5d6982)
        self.view.addSubview(todayReceiptNumberLabel)
        todayReceiptNumberLabel.snp.makeConstraints {(make) -> Void in
            make.left.equalTo(separator.snp.right).offset(22)
            make.height.equalTo(20)
            make.top.equalTo(todayTotalLabel.snp.top)
        }
        // 收款笔数 Value
        self.todayReceiptNumberValue = UILabel()
        self._setUILabel(label: self.todayReceiptNumberValue, text: "123")
        self.todayReceiptNumberValue.textAlignment = .left
        self.todayReceiptNumberValue.textColor = UIColor(hex: 0x5faaff)
        self.todayReceiptNumberValue.font = UIFont.systemFont(ofSize: 35.0)
        self.view.addSubview(self.todayReceiptNumberValue)
        self.todayReceiptNumberValue.snp.makeConstraints {(make) -> Void in
            make.left.equalTo(separator.snp.right).offset(20)
            make.top.equalTo(self.todayTotalValue.snp.top)
        }
        
        // 收款笔数 元
        let todayReceiptNumberUnit = UILabel()
        self._setUILabel(label: todayReceiptNumberUnit, text: "笔")
        todayReceiptNumberUnit.textAlignment = .left
        todayReceiptNumberUnit.font = UIFont.systemFont(ofSize: 13.0)
        self.view.addSubview(todayReceiptNumberUnit)
        todayReceiptNumberUnit.snp.makeConstraints {(make) -> Void in
            make.left.equalTo(self.todayReceiptNumberValue.snp.right).offset(5)
            make.bottom.equalTo(self.todayReceiptNumberValue.snp.bottom).offset(-5)
            make.height.equalTo(20)
        }
        
        // 历史发货 View
        let historyShipmentsView = UIView()
//        historyShipmentsView.backgroundColor = UIColor.clear
        self.view.addSubview(historyShipmentsView)
        historyShipmentsView.snp.makeConstraints {(make) -> Void in
            make.left.equalTo(0)
            make.top.equalTo(self.todayTotalValue.snp.bottom).offset(25)
            make.height.equalTo(50)
        }
        // 历史发货 label
        let historyShipmentsLabel = UILabel()
        self._setUILabel(label: historyShipmentsLabel, text: "历史发货")
        historyShipmentsLabel.textColor = UIColor(hex: 0x5d6982)
        historyShipmentsView.addSubview(historyShipmentsLabel)
        historyShipmentsLabel.snp.makeConstraints {(make) -> Void in
            make.left.right.equalTo(0)
            make.top.equalTo(0)
            make.height.equalTo(20)
        }
        // 历史发货 Value
        self.historyShipmentsValue = UILabel()
        self._setUILabel(label: self.historyShipmentsValue, text: "1230")
        self.historyShipmentsValue.textColor = UIColor(hex: 0x5faaff)
        historyShipmentsView.addSubview(self.historyShipmentsValue)
        self.historyShipmentsValue.snp.makeConstraints {(make) -> Void in
            make.left.right.equalTo(0)
            make.top.equalTo(historyShipmentsLabel.snp.bottom).offset(5)
            make.height.equalTo(20)
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
        todayShipmentsLabel.textColor = UIColor(hex: 0x5d6982)
        todayShipmentsView.addSubview(todayShipmentsLabel)
        todayShipmentsLabel.snp.makeConstraints {(make) -> Void in
            make.left.right.equalTo(0)
            make.top.equalTo(0)
            make.height.equalTo(20)
        }
        // 今日发货 Value
        self.todayShipmentsValue = UILabel()
        self._setUILabel(label: self.todayShipmentsValue, text: "4560")
        self.todayShipmentsValue.textColor = UIColor(hex: 0x5faaff)
        todayShipmentsView.addSubview(self.todayShipmentsValue)
        self.todayShipmentsValue.snp.makeConstraints {(make) -> Void in
            make.left.right.equalTo(0)
            make.top.equalTo(todayShipmentsLabel.snp.bottom).offset(5)
            make.height.equalTo(20)
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
        residueShipmentsLabel.textColor = UIColor(hex: 0x5d6982)
        residueShipmentsView.addSubview(residueShipmentsLabel)
        residueShipmentsLabel.snp.makeConstraints {(make) -> Void in
            make.left.right.equalTo(0)
            make.top.equalTo(0)
            make.height.equalTo(20)
        }
        // 剩余发货 Value
        self.residueShipmentsValue = UILabel()
        self._setUILabel(label: self.residueShipmentsValue, text: "7890")
        self.residueShipmentsValue.textColor = UIColor(hex: 0x5faaff)
        residueShipmentsView.addSubview(self.residueShipmentsValue)
        self.residueShipmentsValue.snp.makeConstraints {(make) -> Void in
            make.left.right.equalTo(0)
            make.top.equalTo(residueShipmentsLabel.snp.bottom).offset(5)
            make.height.equalTo(20)
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
