//
//  HPickingGoodView.swift
//  ZHERP
//
//  Created by MrParker on 2018/9/9.
//  Copyright © 2018 MrParker. All rights reserved.
//

import UIKit
import SnapKit

class HPickingGoodView: UIViewController {
    
    var _sukPriceValue: UILabel!
    var _sukPricedecimal: UILabel!
    var _sukStockValue: UILabel!
    var _sukTitle: UILabel!
    
    // 购物车数量
    var _cartqQuantity: UILabel!
    // 合计总价
    var _totalValue: UILabel!
    
    var _submitAdd: UIButton!
    
    var tabBarHeight: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    public func goodDeatilView(sukData: [String: String]) -> UIView {
        self.view.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: 90)
        let _priceArr: Array = sukData["price"]!.components(separatedBy: ".")
        let _mainView = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 90))
        self.view.addSubview(_mainView)
        
        let _sukView = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 40))
        _sukView.backgroundColor = Specs.color.main
        _mainView.addSubview(_sukView)
        
        let _sukTitleView = UIView(frame: CGRect(x: 0, y: 40, width: ScreenWidth, height: 50))
        _sukTitleView.backgroundColor = Specs.color.white
        _mainView.addSubview(_sukTitleView)
        
        let _sukPriceLabel = UILabel()
        _sukPriceLabel.text = "￥"
        _sukPriceLabel.sizeToFit()
        _sukPriceLabel.textAlignment = .left
        _sukPriceLabel.font = UIFont.systemFont(ofSize: 12.0)
        _sukPriceLabel.textColor = Specs.color.white
        _sukView.addSubview(_sukPriceLabel)
        _sukPriceLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(_sukView.snp.top).offset(16)
            make.left.equalTo(10)
        }

        self._sukPriceValue = UILabel()
        self._sukPriceValue.text = _priceArr[0].isEmpty ? "0" : _priceArr[0]
        self._sukPriceValue.sizeToFit()
        self._sukPriceValue.textAlignment = .left
        self._sukPriceValue.font = UIFont.systemFont(ofSize: 20.0)
        self._sukPriceValue.textColor = Specs.color.white
        _sukView.addSubview(self._sukPriceValue)
        self._sukPriceValue.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(_sukView.snp.top).offset(10)
            make.left.equalTo(_sukPriceLabel.snp.right).offset(0)
            make.height.equalTo(20)
        }

        self._sukPricedecimal = UILabel()
        self._sukPricedecimal.text = _priceArr[1].isEmpty ? ".00" : ".\(_priceArr[1])"
        self._sukPricedecimal.sizeToFit()
        self._sukPricedecimal.textAlignment = .left
        self._sukPricedecimal.font = UIFont.systemFont(ofSize: 12.0)
        self._sukPricedecimal.textColor = Specs.color.white
        _sukView.addSubview(self._sukPricedecimal)
        self._sukPricedecimal.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(self._sukPriceValue.snp.bottom)
            make.left.equalTo(self._sukPriceValue.snp.right).offset(0)
        }

        let _stockView = UIView()
        _sukView.addSubview(_stockView)
        _stockView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(_sukView.snp.top).offset(0)
            make.width.equalTo(ScreenWidth / 3 * 1)
            make.height.equalTo(40)
            make.right.equalTo(0)
        }

        self._sukStockValue = UILabel()
        self._sukStockValue.text = sukData["stock"]
        self._sukStockValue.sizeToFit()
        self._sukStockValue.textAlignment = .left
        self._sukStockValue.font = UIFont.systemFont(ofSize: 20.0)
        self._sukStockValue.textColor = Specs.color.white
        _stockView.addSubview(self._sukStockValue)
        self._sukStockValue.snp.makeConstraints { (make) -> Void in
            make.right.equalTo(_stockView.snp.right).offset(-10)
            make.centerY.equalTo(_stockView)
        }

        let _stockLabel = UILabel()
        _stockLabel.text = "剩余："
        _stockLabel.sizeToFit()
        _stockLabel.textAlignment = .left
        _stockLabel.font = Specs.font.regular
        _stockLabel.textColor = Specs.color.white
        _stockView.addSubview(_stockLabel)
        _stockLabel.snp.makeConstraints { (make) -> Void in
            make.right.equalTo(self._sukStockValue.snp.left).offset(-5)
            make.centerY.equalTo(_stockView)
        }

        self._sukTitle = UILabel()
        self._sukTitle.text = sukData["title"]
        self._sukTitle.sizeToFit()
        self._sukTitle.textAlignment = .left
        self._sukTitle.font = Specs.font.regular
        self._sukTitle.textColor = UIColor(hex: 0x666666)
        self._sukTitle.numberOfLines = 2
        _sukTitleView.addSubview(self._sukTitle)
        self._sukTitle.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(10)
            make.centerY.equalTo(_sukTitleView)
            make.width.equalTo(ScreenWidth - 20)
        }
        return _mainView
    }
    
    public func cartDetailView(cartData: [String: String]) -> UIView {
        self.view.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: self.tabBarHeight)
        // tabBarView
        let _tabBarView = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: self.tabBarHeight))
        _tabBarView.backgroundColor = Specs.color.white
        self.view.addSubview(_tabBarView)
        
        // 总价view
        let _cartDetailView = UIView()
        _tabBarView.addSubview(_cartDetailView)
        _cartDetailView.snp.makeConstraints { (make) -> Void in
            make.left.bottom.equalTo(0)
            make.height.equalTo(self.tabBarHeight)
            make.width.equalTo(ScreenWidth / 2)
        }
        
        // Separator
        let _separator = UILabel()
        _separator.backgroundColor = UIColor(hex: 0xdddddd)
        _cartDetailView.addSubview(_separator)
        _separator.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(_cartDetailView.snp.top)
            make.left.right.equalTo(0)
            make.width.equalTo(_cartDetailView.snp.width)
            make.height.equalTo(0.3)
        }
        
        // cart
        let _cartShopping = UIView()
        _cartShopping.backgroundColor = UIColor(patternImage: UIImage(named:"cart_32_32")!)
        _cartDetailView.addSubview(_cartShopping)
        _cartShopping.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(10)
            make.top.equalTo(_cartDetailView.snp.top).offset(10)
            make.width.height.equalTo(32)
        }
        
        // Quantity View
        let _width = 25.0
        let _cartQuantityView = UIView()
        _cartQuantityView.backgroundColor = UIColor.red
        _cartQuantityView.layer.cornerRadius = CGFloat(_width / 2)
        _cartQuantityView.layer.masksToBounds = true
        _cartShopping.addSubview(_cartQuantityView)
        _cartQuantityView.snp.makeConstraints { (make) -> Void in
            make.right.equalTo(10)
            make.top.equalTo(_cartDetailView.snp.top).offset(-5)
            make.width.height.equalTo(_width)
        }
        
        // Quantity Value
        self._cartqQuantity = UILabel()
        self._cartqQuantity.text = cartData["quantity"]
        self._cartqQuantity.sizeToFit()
        self._cartqQuantity.textAlignment = .center
        self._cartqQuantity.font = Specs.font.regular
        self._cartqQuantity.textColor = Specs.color.white
        _cartQuantityView.addSubview(self._cartqQuantity)
        self._cartqQuantity.snp.makeConstraints { (make) -> Void in
            make.center.equalTo(_cartQuantityView)
        }
        
        // 总价 Label
        let _totalLabel = UILabel()
        _totalLabel.text = "￥："
        _totalLabel.sizeToFit()
        _totalLabel.textAlignment = .left
        _totalLabel.font = Specs.font.regular
        _totalLabel.textColor = Specs.color.black
        _cartDetailView.addSubview(_totalLabel)
        _totalLabel.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(_cartShopping.snp.right).offset(20)
            make.centerY.equalTo(_cartDetailView)
            make.height.equalTo(20)
        }
        
        // 总价 Value
        self._totalValue = UILabel()
        self._totalValue.text = cartData["total"]
        self._totalValue.sizeToFit()
        self._totalValue.textAlignment = .left
        self._totalValue.font = UIFont.systemFont(ofSize: 20.0)
        self._totalValue.textColor = Specs.color.black
        _cartDetailView.addSubview(self._totalValue)
        self._totalValue.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(_totalLabel.snp.right).offset(0)
            make.centerY.equalTo(_cartDetailView)
            make.height.equalTo(20)
        }
        
        // 提交按钮View
        let _cartBtnView = UIView()
        _tabBarView.addSubview(_cartBtnView)
        _cartBtnView.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(_cartDetailView.snp.right)
            make.right.bottom.equalTo(0)
            make.height.equalTo(self.tabBarHeight)
            make.width.equalTo(ScreenWidth / 2)
        }
        
        // Btn
        self._submitAdd = UIButton()
        self._submitAdd.setTitle("立即添加", for: .normal)
        self._submitAdd.setTitleColor(Specs.color.white, for: UIControlState())
        self._submitAdd.backgroundColor = Specs.color.main
//        self._submitAdd.addTarget(self, action: action, for: .touchUpInside)
        _cartBtnView.addSubview(self._submitAdd)
        self._submitAdd.snp.makeConstraints { (make) -> Void in
            make.left.right.bottom.equalTo(0)
            make.width.equalTo(_cartBtnView.snp.width)
            make.height.equalTo(_cartBtnView.snp.height)
        }
        
        return _tabBarView
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
