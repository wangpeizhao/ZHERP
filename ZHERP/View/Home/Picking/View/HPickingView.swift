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
    var _cartCancelBtn: UIButton!
    
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
    
    public func cartEditView(cartData: [String: String]) {
        self.view.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: self.tabBarHeight)
        // tabBarView
        let _editView = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: self.tabBarHeight))
        _editView.backgroundColor = Specs.color.white
        self.view.addSubview(_editView)
        
        let _orderTypeView = UIView()
        _orderTypeView.backgroundColor = Specs.color.white
        _editView.addSubview(_orderTypeView)
        _orderTypeView.snp.makeConstraints { (make) -> Void in
            make.left.right.equalTo(0)
            make.height.equalTo(SelectCellHeight)
            make.top.equalTo(_editView.snp.top)
        }
        
        // 订单类型
        let _orderTypeLabel = UILabel()
        _orderTypeLabel.text = "订单类型："
        _orderTypeLabel.sizeToFit()
        _orderTypeLabel.textAlignment = .left
        _orderTypeLabel.font = Specs.font.regular
        _orderTypeView.addSubview(_orderTypeLabel)
        _orderTypeLabel.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(_orderTypeView.snp.left).offset(10)
            make.centerY.equalTo(_orderTypeView)
        }
        
        // 订单类型 下拉 View
        let _orderTypeSelectView = UIView()
        _orderTypeSelectView.backgroundColor = Specs.color.white
        _orderTypeSelectView.layer.borderWidth = 0.5
        _orderTypeSelectView.layer.masksToBounds = true
        _orderTypeSelectView.layer.cornerRadius = Specs.border.radius
        _orderTypeView.addSubview(_orderTypeSelectView)
        _orderTypeSelectView.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(_orderTypeLabel.snp.right).offset(5)
            make.top.equalTo(_orderTypeView.snp.top)
            make.height.equalTo(_orderTypeView.snp.height)
        }
        
        // 订单类型 下拉 Label
        let _orderTypeSelectLabel = UILabel()
        _orderTypeSelectLabel.text = "线上订单"
        _orderTypeSelectLabel.sizeToFit()
        _orderTypeSelectLabel.textAlignment = .left
        _orderTypeSelectLabel.font = Specs.font.regular
        _orderTypeSelectView.addSubview(_orderTypeSelectLabel)
        _orderTypeSelectLabel.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(_orderTypeSelectView.snp.left).offset(10)
            make.right.equalTo(_orderTypeSelectView.snp.right).offset(-10)
            make.centerY.equalTo(_orderTypeSelectView)
        }
        
        // 订单类型 下拉 icon
        let _orderTypeSelectIcon = UIImageView()
        let _icon = UIImage(named: "arrange1")
        _orderTypeSelectIcon.image = _icon
        _orderTypeSelectView.addSubview(_orderTypeSelectIcon)
        _orderTypeSelectIcon.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(_orderTypeSelectLabel.snp.right).offset(-2)
            make.centerY.equalTo(_orderTypeSelectView)
            make.width.equalTo(5)
        }
        
        // cancel Btn
        self._cartCancelBtn = UIButton()
        self._cartCancelBtn.setTitle("取消", for: .normal)
        self._cartCancelBtn.setTitleColor(Specs.color.white, for: UIControlState())
        self._cartCancelBtn.backgroundColor = Specs.color.main
        _orderTypeView.addSubview(self._cartCancelBtn)
        self._cartCancelBtn.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(_orderTypeView.snp.top)
            make.right.equalTo(-10)
            make.width.equalTo(50)
            make.height.equalTo(30)
            make.centerY.equalTo(_orderTypeView)
        }
        
        // Separator
        let _separator = UILabel()
        _separator.backgroundColor = Specs.color.gray
        _orderTypeView.addSubview(_separator)
        _separator.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(_orderTypeView.snp.top)
            make.left.right.equalTo(0)
            make.width.equalTo(ScreenWidth)
            make.height.equalTo(0.3)
        }
        
        let _editTotalView = UIView()
        _editTotalView.backgroundColor = Specs.color.white
        _editView.addSubview(_editTotalView)
        _editTotalView.snp.makeConstraints { (make) -> Void in
            make.left.right.equalTo(0)
            make.height.equalTo(SelectCellHeight)
            make.top.equalTo(_orderTypeView.snp.bottom)
        }
        
        // 总价
        let _orderTotalLabel = UILabel()
        _orderTotalLabel.text = "总价："
        _orderTotalLabel.sizeToFit()
        _orderTotalLabel.textAlignment = .left
        _orderTotalLabel.font = Specs.font.regular
        _editTotalView.addSubview(_orderTotalLabel)
        _orderTotalLabel.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(_editTotalView.snp.left).offset(10)
            make.centerY.equalTo(_editTotalView)
        }
        
        // 操作类型 下拉 View
        let _operateTypeSelectView = UIView()
        _operateTypeSelectView.backgroundColor = Specs.color.white
        _operateTypeSelectView.layer.borderWidth = 0.5
        _operateTypeSelectView.layer.masksToBounds = true
        _operateTypeSelectView.layer.cornerRadius = Specs.border.radius
        _editTotalView.addSubview(_operateTypeSelectView)
        _operateTypeSelectView.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(_orderTotalLabel.snp.right).offset(5)
            make.top.equalTo(_editTotalView.snp.top)
            make.height.equalTo(_editTotalView.snp.height)
        }
        
        // 减少 or 增加 下拉 Label
        let _operateTypeSelectLabel = UILabel()
        _operateTypeSelectLabel.text = "减少"
        _operateTypeSelectLabel.sizeToFit()
        _operateTypeSelectLabel.textAlignment = .left
        _operateTypeSelectLabel.font = Specs.font.regular
        _editTotalView.addSubview(_operateTypeSelectLabel)
        _operateTypeSelectLabel.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(_operateTypeSelectView.snp.left).offset(10)
            make.right.equalTo(_operateTypeSelectView.snp.right).offset(-10)
            make.centerY.equalTo(_operateTypeSelectView)
        }
        
        // 减少 or 增加 下拉 icon
        let _operateTypeSelectIcon = UIImageView()
        _operateTypeSelectIcon.image = _icon
        _editTotalView.addSubview(_operateTypeSelectIcon)
        _operateTypeSelectIcon.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(_operateTypeSelectLabel.snp.right).offset(-2)
            make.centerY.equalTo(_editTotalView)
            make.width.equalTo(5)
        }
        
    }
}
