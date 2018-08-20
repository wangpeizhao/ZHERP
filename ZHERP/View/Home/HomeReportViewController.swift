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
    
    var todayTotalAmount: UILabel!
    var historyShipmentsValue: UILabel!
    var todayShipmentsValue: UILabel!
    var residueShipmentsValue: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        self._setup()

        // Do any additional setup after loading the view.
    }
    
    func _setup() {
        self.view = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 200))
        // 今日订单 Label
        let todayTotalLabel = UILabel()
        todayTotalLabel.text = "今日订单"
        todayTotalLabel.textAlignment = .center
        todayTotalLabel.sizeToFit()
        todayTotalLabel.font = Specs.font.regularBold
        self.view.addSubview(todayTotalLabel)
        todayTotalLabel.snp.makeConstraints {(make) -> Void in
            make.left.right.equalTo(0)
            make.height.equalTo(20)
            make.top.equalTo(5)
        }
        
        // 今日订单 Value
        let todayTotalValue = UILabel()
        todayTotalValue.text = "1234567890"
        todayTotalValue.textAlignment = .center
        todayTotalValue.sizeToFit()
        todayTotalValue.font = UIFont.systemFont(ofSize: 24.0)
        self.view.addSubview(todayTotalValue)
        todayTotalValue.snp.makeConstraints {(make) -> Void in
            make.left.right.equalTo(0)
            make.top.equalTo(todayTotalLabel.snp.bottom).offset(10)
            make.height.equalTo(30)
        }
        
        // 历史发货 View
        let historyShipmentsView = UIView()
        historyShipmentsView.backgroundColor = UIColor.clear
        self.view.addSubview(historyShipmentsView)
        historyShipmentsView.snp.makeConstraints {(make) -> Void in
            make.left.equalTo(0)
            make.top.equalTo(todayTotalValue.snp.bottom).offset(20)
            make.height.equalTo(50)
        }
        // 历史发货 label
        let historyShipmentsLabel = UILabel()
        historyShipmentsLabel.text = "历史发货"
        historyShipmentsLabel.textAlignment = .center
        historyShipmentsLabel.sizeToFit()
        historyShipmentsLabel.font = Specs.font.largeBold
        historyShipmentsView.addSubview(historyShipmentsLabel)
        historyShipmentsLabel.snp.makeConstraints {(make) -> Void in
            make.left.right.equalTo(0)
            make.top.equalTo(0)
            make.height.equalTo(20)
        }
        // 历史发货 Value
        self.historyShipmentsValue = UILabel()
        self.historyShipmentsValue.text = "12345"
        self.historyShipmentsValue.textAlignment = .center
        self.historyShipmentsValue.sizeToFit()
        self.historyShipmentsValue.font = Specs.font.largeBold
        historyShipmentsView.addSubview(self.historyShipmentsValue)
        self.historyShipmentsValue.snp.makeConstraints {(make) -> Void in
            make.left.right.equalTo(0)
            make.top.equalTo(historyShipmentsLabel.snp.bottom).offset(5)
            make.height.equalTo(20)
        }
        
        // 今日发货 View
        let todayShipmentsView = UIView()
        todayShipmentsView.backgroundColor = UIColor.clear
        self.view.addSubview(todayShipmentsView)
        todayShipmentsView.snp.makeConstraints {(make) -> Void in
            make.left.equalTo(historyShipmentsView.snp.right)
            make.top.equalTo(todayTotalValue.snp.bottom).offset(20)
            make.height.equalTo(historyShipmentsView.snp.height)
            make.width.equalTo(historyShipmentsView.snp.width)
        }
        // 今日发货 label
        let todayShipmentsLabel = UILabel()
        todayShipmentsLabel.text = "今日发货"
        todayShipmentsLabel.textAlignment = .center
        todayShipmentsLabel.sizeToFit()
        todayShipmentsLabel.font = Specs.font.largeBold
        todayShipmentsView.addSubview(todayShipmentsLabel)
        todayShipmentsLabel.snp.makeConstraints {(make) -> Void in
            make.left.right.equalTo(0)
            make.top.equalTo(0)
            make.height.equalTo(20)
        }
        // 今日发货 Value
        self.todayShipmentsValue = UILabel()
        self.todayShipmentsValue.text = "12345"
        self.todayShipmentsValue.textAlignment = .center
        self.todayShipmentsValue.sizeToFit()
        self.todayShipmentsValue.font = Specs.font.largeBold
        todayShipmentsView.addSubview(self.todayShipmentsValue)
        self.todayShipmentsValue.snp.makeConstraints {(make) -> Void in
            make.left.right.equalTo(0)
            make.top.equalTo(todayShipmentsLabel.snp.bottom).offset(5)
            make.height.equalTo(20)
        }
        
        // 剩余发货 View
        let residueShipmentsView = UIView()
        residueShipmentsView.backgroundColor = UIColor.clear
        self.view.addSubview(residueShipmentsView)
        residueShipmentsView.snp.makeConstraints {(make) -> Void in
            make.left.equalTo(todayShipmentsView.snp.right)
            make.top.equalTo(todayTotalValue.snp.bottom).offset(20)
            make.height.equalTo(historyShipmentsView.snp.height)
            make.width.equalTo(historyShipmentsView.snp.width)
            make.right.equalTo(0)
        }
        // 剩余发货 label
        let residueShipmentsLabel = UILabel()
        residueShipmentsLabel.text = "剩余发货"
        residueShipmentsLabel.textAlignment = .center
        residueShipmentsLabel.sizeToFit()
        residueShipmentsLabel.font = Specs.font.largeBold
        residueShipmentsView.addSubview(residueShipmentsLabel)
        residueShipmentsLabel.snp.makeConstraints {(make) -> Void in
            make.left.right.equalTo(0)
            make.top.equalTo(0)
            make.height.equalTo(20)
        }
        // 剩余发货 Value
        self.residueShipmentsValue = UILabel()
        self.residueShipmentsValue.text = "12345"
        self.residueShipmentsValue.textAlignment = .center
        self.residueShipmentsValue.sizeToFit()
        self.residueShipmentsValue.font = Specs.font.largeBold
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
