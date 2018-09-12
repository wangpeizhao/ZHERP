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
    
    @objc func cartCancelBtn() {
        print("cartCancelBtn")
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
    
    public func cartEditView(cartData: [String: String]) -> UIView {
        
        let _btnWidth: CGFloat = 60.0
        let _btnHeight: CGFloat = 30.0
        let _btnHeightOffset = (self.tabBarHeight - _btnHeight) / 2
        self.view.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: self.tabBarHeight)
        // tabBarView
        let _editView = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: self.tabBarHeight * 2))
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

        let _orderTypeButton = UIButton()
        _orderTypeButton.setTitleColor(normalRGBA(r: 114, g: 114, b: 114, a: 1.0), for: .normal)
        _orderTypeButton.backgroundColor = Specs.color.white
        _orderTypeButton.titleLabel?.font = UIFont.systemFont(ofSize: Specs.fontSize.regular)
        _orderTypeButton.titleLabel?.textAlignment = .center
        _orderTypeButton.layer.borderWidth = 0.5
        _orderTypeButton.layer.cornerRadius = Specs.border.radius
        _orderTypeButton.set(image: UIImage(named: "arrange1"), title: "线上订单", titlePosition: .left, additionalSpacing: 5.0, state: .normal)
        _orderTypeView.addSubview(_orderTypeButton)
        _orderTypeButton.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(_orderTypeView.snp.top).offset(_btnHeightOffset)
            make.left.equalTo(_orderTypeLabel.snp.right)
            make.height.equalTo(_btnHeight)
            make.width.equalTo(_btnWidth * 2)
        }

        // cancel Btn
        self._cartCancelBtn = UIButton()
        self._cartCancelBtn.setTitle("取消", for: .normal)
        self._cartCancelBtn.setTitleColor(Specs.color.white, for: UIControlState())
        self._cartCancelBtn.layer.cornerRadius = Specs.border.radius
        self._cartCancelBtn.titleLabel?.font = UIFont.systemFont(ofSize: Specs.fontSize.regular)
        self._cartCancelBtn.backgroundColor = Specs.color.main
        _orderTypeView.addSubview(self._cartCancelBtn)
        self._cartCancelBtn.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(_orderTypeView.snp.top).offset(_btnHeightOffset)
            make.right.equalTo(-10)
            make.width.equalTo(_btnWidth)
            make.height.equalTo(_btnHeight)
        }

        // Separator
        let _separator = UILabel()
        _separator.backgroundColor = Specs.color.gray
        _orderTypeView.addSubview(_separator)
        _separator.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(_orderTypeView.snp.bottom).offset(5)
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
            make.top.equalTo(_separator.snp.bottom)
        }
        
        // 总价
        let _orderTotalLabel = UILabel()
        _orderTotalLabel.text = "订单总价："
        _orderTotalLabel.sizeToFit()
        _orderTotalLabel.textAlignment = .left
        _orderTotalLabel.font = Specs.font.regular
        _editTotalView.addSubview(_orderTotalLabel)
        _orderTotalLabel.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(_editTotalView.snp.left).offset(10)
            make.centerY.equalTo(_editTotalView)
        }

        //
        let _operateTypeButton = UIButton()
        _operateTypeButton.setTitleColor(normalRGBA(r: 114, g: 114, b: 114, a: 1.0), for: .normal)
        _operateTypeButton.backgroundColor = Specs.color.white
        _operateTypeButton.titleLabel?.font = UIFont.systemFont(ofSize: Specs.fontSize.regular)
        _operateTypeButton.titleLabel?.textAlignment = .center
        _operateTypeButton.layer.borderWidth = 0.5
        _operateTypeButton.layer.cornerRadius = Specs.border.radius
        _operateTypeButton.set(image: UIImage(named: "arrange1"), title: "减少", titlePosition: .left, additionalSpacing: 5.0, state: .normal)
        _editTotalView.addSubview(_operateTypeButton)
        _operateTypeButton.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(_editTotalView.snp.top).offset(_btnHeightOffset)
            make.left.equalTo(_orderTotalLabel.snp.right)
            make.height.equalTo(_btnHeight)
            make.width.equalTo(_btnWidth)
        }
        
        // 输入金额/折扣
        let _amountTextfield = UITextField()
        _amountTextfield.placeholder = "输入金额/折扣"
        _amountTextfield.textColor = UIColor(hex: 0x666666)
        _amountTextfield.font = Specs.font.regular
        _amountTextfield.clearButtonMode = UITextFieldViewMode.always
        _amountTextfield.adjustsFontSizeToFitWidth = true
        _amountTextfield.returnKeyType = UIReturnKeyType.done
        _amountTextfield.keyboardType = UIKeyboardType.decimalPad
        _amountTextfield.layer.borderWidth = 0.5
        _amountTextfield.layer.cornerRadius = Specs.border.radius
        _amountTextfield.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 3, height: 3))
        _amountTextfield.leftViewMode = .always
        _amountTextfield.becomeFirstResponder()
        _amountTextfield.addTarget(self, action: #selector(cartCancelBtn), for: .touchDown)
        _editView.addSubview(_amountTextfield)
        _amountTextfield.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(_editView.snp.top).offset(_btnHeightOffset + self.tabBarHeight)
            make.left.equalTo(_operateTypeButton.snp.right).offset(5)
            make.height.equalTo(_btnHeight)
            make.width.equalTo(_btnWidth * 2)
        }
        
        // 元/折扣
        let _discountTypeButton = UIButton()
        _discountTypeButton.setTitleColor(normalRGBA(r: 114, g: 114, b: 114, a: 1.0), for: .normal)
        _discountTypeButton.backgroundColor = Specs.color.white
        _discountTypeButton.titleLabel?.font = UIFont.systemFont(ofSize: Specs.fontSize.regular)
        _discountTypeButton.titleLabel?.textAlignment = .center
        _discountTypeButton.layer.borderWidth = 0.5
        _discountTypeButton.layer.cornerRadius = Specs.border.radius
        _discountTypeButton.set(image: UIImage(named: "arrange1"), title: "折扣", titlePosition: .left, additionalSpacing: 5.0, state: .normal)
        _editTotalView.addSubview(_discountTypeButton)
        _discountTypeButton.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(_editTotalView.snp.top).offset(_btnHeightOffset)
            make.left.equalTo(_amountTextfield.snp.right).offset(5)
            make.height.equalTo(_btnHeight)
            make.width.equalTo(_btnWidth)
        }

        // Submit Btn
        let _submitBtn = UIButton()
        _submitBtn.setTitle("确定", for: .normal)
        _submitBtn.setTitleColor(Specs.color.white, for: UIControlState())
        _submitBtn.layer.cornerRadius = Specs.border.radius
        _submitBtn.titleLabel?.font = UIFont.systemFont(ofSize: Specs.fontSize.regular)
        _submitBtn.backgroundColor = Specs.color.main
        _editTotalView.addSubview(_submitBtn)
        _submitBtn.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(_editTotalView.snp.top).offset(_btnHeightOffset)
            make.right.equalTo(-10)
            make.width.equalTo(_btnWidth)
            make.height.equalTo(_btnHeight)
        }
        
        return _editView
        
    }
}
