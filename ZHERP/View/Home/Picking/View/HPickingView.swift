//
//  HPickingView.swift
//  ZHERP
//
//  Created by MrParker on 2018/9/9.
//  Copyright © 2018 MrParker. All rights reserved.
//

import UIKit

class HPickingView: UIViewController {
    
    // 合计总价
    var _totalValue: UILabel!
    // 合计数量
    var _quantityValue: UILabel!
    
    var _submitAdd: UIButton!
    
    var tabBarHeight: CGFloat!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
            make.width.equalTo(ScreenWidth / 3 * 2)
        }
        
        // Separator
        let _separator = UILabel()
        _separator.backgroundColor = Specs.color.gray
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
        self._quantityValue = UILabel()
        self._quantityValue.text = cartData["quantity"]
        self._quantityValue.sizeToFit()
        self._quantityValue.textAlignment = .center
        self._quantityValue.font = Specs.font.regular
        self._quantityValue.textColor = Specs.color.white
        _cartQuantityView.addSubview(self._quantityValue)
        self._quantityValue.snp.makeConstraints { (make) -> Void in
            make.center.equalTo(_cartQuantityView)
        }
        
        // 总价 Label
        let _totalLabel = UILabel()
        _totalLabel.text = "合计：￥"
        _totalLabel.sizeToFit()
        _totalLabel.textAlignment = .left
        _totalLabel.font = Specs.font.regular
        _totalLabel.textColor = Specs.color.black
        _cartDetailView.addSubview(_totalLabel)
        _totalLabel.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(_cartShopping.snp.right).offset(30)
            make.centerY.equalTo(_cartDetailView)
            make.height.equalTo(20)
        }
        
        // 总价 Value
        self._totalValue = UILabel()
        self._totalValue.text = cartData["total"]
        self._totalValue.sizeToFit()
        self._totalValue.textAlignment = .left
        self._totalValue.font = UIFont.systemFont(ofSize: 25.0)
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
            make.top.equalTo(_separator.snp.top)
            make.left.equalTo(_cartDetailView.snp.right)
            make.right.equalTo(0)
            make.height.equalTo(self.tabBarHeight)
            make.width.equalTo(ScreenWidth / 3 - 1)
        }
        
        // Btn
        self._submitAdd = UIButton()
        self._submitAdd.setTitle("提 交", for: .normal)
        self._submitAdd.setTitleColor(Specs.color.white, for: UIControlState())
        self._submitAdd.backgroundColor = Specs.color.main
//        _btn.addTarget(self, action: #selector(actionCart), for: .touchUpInside)
        _cartBtnView.addSubview(self._submitAdd)
        self._submitAdd.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(_cartBtnView.snp.top)
            make.left.right.equalTo(0)
            make.width.equalTo(_cartBtnView.snp.width)
            make.height.equalTo(_cartBtnView.snp.height)
        }
        
        return _tabBarView
    }
}
