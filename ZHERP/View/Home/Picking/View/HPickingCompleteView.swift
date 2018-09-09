//
//  HPickingCompleteView.swift
//  ZHERP
//
//  Created by MrParker on 2018/9/9.
//  Copyright © 2018 MrParker. All rights reserved.
//

import UIKit
import SnapKit

class HPickingCompleteView: UIViewController {

    // 订单号
    var orderIdValue: UILabel!
    // 下单时间
    var orderTimeValue: UILabel!
    // 总价
    var totalValue: UILabel!
    
    // 进入订单
    var actionOrderBtn: UIButton!
    // 继续拣货
    var continuePickBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    public func mainView(initData: [String: String]) -> UIView {
        let _mainView = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight))
        _mainView.backgroundColor = Specs.color.white
        self.view.addSubview(_mainView)
        
        let _orderIdLabel = UILabel()
        _orderIdLabel.text = "订单编号："
        _orderIdLabel.sizeToFit()
        _orderIdLabel.textAlignment = .left
        _orderIdLabel.font = Specs.font.regular
        _mainView.addSubview(_orderIdLabel)
        _orderIdLabel.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(20)
            make.height.equalTo(20)
            make.top.equalTo(_mainView.snp.top).offset(10)
        }
        
        self.orderIdValue = UILabel()
        self.orderIdValue.text = initData["orderId"]
        self.orderIdValue.sizeToFit()
        self.orderIdValue.textAlignment = .left
        self.orderIdValue.font = Specs.font.regular
        _mainView.addSubview(self.orderIdValue)
        self.orderIdValue.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(_orderIdLabel.snp.right)
            make.height.equalTo(20)
            make.top.equalTo(_orderIdLabel.snp.top)
        }
        
        let _orderTimeLabel = UILabel()
        _orderTimeLabel.text = "下单时间："
        _orderTimeLabel.sizeToFit()
        _orderTimeLabel.textAlignment = .left
        _orderTimeLabel.font = Specs.font.regular
        _mainView.addSubview(_orderTimeLabel)
        _orderTimeLabel.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(20)
            make.height.equalTo(20)
            make.top.equalTo(_orderIdLabel.snp.bottom).offset(10)
        }
        
        self.orderTimeValue = UILabel()
        self.orderTimeValue.text = initData["orderTime"]
        self.orderTimeValue.sizeToFit()
        self.orderTimeValue.textAlignment = .left
        self.orderTimeValue.font = Specs.font.regular
        _mainView.addSubview(self.orderTimeValue)
        self.orderTimeValue.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(_orderTimeLabel.snp.right)
            make.height.equalTo(20)
            make.top.equalTo(_orderTimeLabel.snp.top)
        }
        
        let _width = (ScreenWidth - 80) / 2
        let _paymentCodeView = UIView()
//        _paymentCodeView.backgroundColor = UIColor.orange
        _mainView.addSubview(_paymentCodeView)
        _paymentCodeView.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(0)
            make.width.equalTo(ScreenWidth)
            make.height.equalTo(_width)
            make.top.equalTo(_orderTimeLabel.snp.bottom).offset(20)
        }
        
        let _weixinImageView = UIImageView()
        let _weixinPaymentCode = UIImage(named: "weixinPaymentCode")
        _weixinImageView.image = _weixinPaymentCode
        _paymentCodeView.addSubview(_weixinImageView)
        _weixinImageView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(_paymentCodeView.snp.top)
            make.width.height.equalTo(_width)
            make.height.height.equalTo(_width)
            make.left.equalTo(20)
        }
        
        let _weixinLabel = UILabel()
        _weixinLabel.text = "微信收款码"
        _weixinLabel.sizeToFit()
        _weixinLabel.textAlignment = .center
        _weixinLabel.font = Specs.font.regular
        _mainView.addSubview(_weixinLabel)
        _weixinLabel.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(20)
            make.width.equalTo(_width)
            make.height.equalTo(20)
            make.top.equalTo(_weixinImageView.snp.bottom).offset(10)
        }
        
        let _alipayImageView = UIImageView()
        let _alipayPaymentCode = UIImage(named: "alipayPaymentCode")
        _alipayImageView.image = _alipayPaymentCode
        _paymentCodeView.addSubview(_alipayImageView)
        _alipayImageView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(_weixinImageView.snp.top)
            make.width.height.equalTo(_width)
            make.height.height.equalTo(_width)
            make.left.equalTo(_weixinImageView.snp.right).offset(40)
        }
        
        let _alipayLabel = UILabel()
        _alipayLabel.text = "支付宝收款码"
        _alipayLabel.sizeToFit()
        _alipayLabel.textAlignment = .center
        _alipayLabel.font = Specs.font.regular
        _mainView.addSubview(_alipayLabel)
        _alipayLabel.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(_width)
            make.height.equalTo(20)
            make.top.equalTo(_alipayImageView.snp.bottom).offset(10)
            make.left.equalTo(_weixinLabel.snp.right).offset(40)
        }
        
        self.totalValue = UILabel()
        self.totalValue.text = "总价：￥\(initData["total"]!)元"
        self.totalValue.sizeToFit()
        self.totalValue.textAlignment = .center
        self.totalValue.font = Specs.font.largeBold
        _mainView.addSubview(self.totalValue)
        self.totalValue.snp.makeConstraints { (make) -> Void in
            make.left.right.equalTo(0)
            make.width.equalTo(ScreenWidth)
            make.height.equalTo(40)
            make.top.equalTo(_weixinLabel.snp.bottom).offset(10)
        }
        
        // Separator
        let _separator = UILabel()
        _separator.backgroundColor = UIColor(hex: 0xdddddd)
        _mainView.addSubview(_separator)
        _separator.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.totalValue.snp.bottom).offset(10)
            make.left.right.equalTo(0)
            make.width.equalTo(ScreenWidth)
            make.height.equalTo(0.3)
        }
        
        self.actionOrderBtn = UIButton()
        self.actionOrderBtn.setTitle("进入订单", for: .normal)
        self.actionOrderBtn.setTitleColor(Specs.color.white, for: UIControlState())
        self.actionOrderBtn.backgroundColor = Specs.color.main
        self.actionOrderBtn.layer.masksToBounds = true
        self.actionOrderBtn.layer.cornerRadius = Specs.border.radius
        _mainView.addSubview(self.actionOrderBtn)
        self.actionOrderBtn.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(_separator.snp.bottom).offset(10)
            make.left.equalTo(20)
            make.width.equalTo(_width)
            make.height.equalTo(40)
        }

        self.continuePickBtn = UIButton()
        self.continuePickBtn.setTitle("继续拣货", for: .normal)
        self.continuePickBtn.setTitleColor(Specs.color.black, for: UIControlState())
        self.continuePickBtn.backgroundColor = Specs.color.white
        self.continuePickBtn.layer.borderWidth = 1
        self.continuePickBtn.layer.borderColor = UIColor(hex: 0xdddddd).cgColor
        self.continuePickBtn.layer.masksToBounds = true
        self.continuePickBtn.layer.cornerRadius = Specs.border.radius
        _mainView.addSubview(self.continuePickBtn)
        self.continuePickBtn.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(_separator.snp.bottom).offset(10)
            make.left.equalTo(self.actionOrderBtn.snp.right).offset(40)
            make.width.equalTo(_width)
            make.height.equalTo(40)
        }
        
        // Separator
        let _separatorBottom = UILabel()
        _separatorBottom.backgroundColor = UIColor(hex: 0xdddddd)
        _mainView.addSubview(_separatorBottom)
        _separatorBottom.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(_separator.snp.bottom).offset(60)
            make.left.right.equalTo(0)
            make.width.equalTo(ScreenWidth)
            make.height.equalTo(0.3)
        }
        
        return _mainView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
