//
//  WarehouseDetailViewController.swift
//  ZHERP
//
//  Created by MrParker on 2018/9/2.
//  Copyright © 2018 MrParker. All rights reserved.
//

import UIKit
import SnapKit

// 用typealias来定义闭包,用来反向传值
typealias assignValueClosure = (_ assignValue: String) -> Void//声明
class WarehouseDetailViewController: UIViewController {
    
    var Id: Int = 0
    var navTitle: String? = nil
    var value: String? = nil
    var placeholder: String? = nil
    var navHeight: CGFloat!
    
    let _value = UITextField()
    var callBackAssign: assignValueClosure?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(hex: 0xf7f7f7)
        setNavBarTitle(view: self, title: self.navTitle!)
//        setNavBarRightBtn(view: self, title: "保存", selector: #selector(actionSave))
        
        self._setup()

        // Do any additional setup after loading the view.
    }
    
    @objc func actionSave() {
        let value = self._value.text
        if (value?.isEmpty)! {
            _alert(view: self, message: "\(self.navTitle!)不能为空！")
            return
        }
        if (self.callBackAssign != nil) {
            self.callBackAssign!(value!)
        }
        _back(view: self)
    }
    
    private func _setup() {
        self.navHeight = self.navigationController?.navigationBar.frame.maxY
        
        let _view = UIView(frame: CGRect(x: 0, y: self.navHeight + 10, width: ScreenWidth, height: 40))
        _view.backgroundColor = Specs.color.white
        self.view.addSubview(_view)
        
        self._value.text = self.value
        self._value.placeholder = self.placeholder
        self._value.textAlignment = .left
        self._value.font = Specs.font.regular
        self._value.textColor = Specs.color.gray
        self._value.clearButtonMode = .whileEditing
        self._value.becomeFirstResponder() // resignFirstResponder
        self._value.returnKeyType = UIReturnKeyType.done
        self._value.delegate = self
        _view.addSubview(self._value)
        self._value.snp.makeConstraints {(make) -> Void in
            make.top.equalTo(10)
            make.left.equalTo(15)
            make.right.equalTo(-10)
            make.centerY.equalTo(_view)
        }
        
        let _btn = UIButton(frame: CGRect(x: 10, y: self.navHeight + 60, width: ScreenWidth - 20, height: 40))
        _btn.setTitle("保存", for: .normal)
        _btn.setTitleColor(Specs.color.white, for: UIControlState())
        _btn.backgroundColor = Specs.color.main
        _btn.layer.cornerRadius = Specs.border.radius
        _btn.layer.masksToBounds = true
        _btn.titleLabel?.font = UIFont.systemFont(ofSize: Specs.fontSize.regular)
        _btn.addTarget(self, action: #selector(actionSave), for: .touchUpInside)
        self.view.addSubview(_btn)
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


extension WarehouseDetailViewController: UITextFieldDelegate {
    
    // 输入框询问是否可以编辑 true 可以编辑  false 不能编辑
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("我要开始编辑了...")
        return true
    }
    // 该方法代表输入框已经可以开始编辑  进入编辑状态
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("我正在编辑状态中...")
    }
    // 输入框将要将要结束编辑
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print("我即将编辑结束...")
        return true
    }
    // 输入框结束编辑状态
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("我已经结束编辑状态...")
    } // 文本框是否可以清除内容
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
    // 输入框按下键盘 return 收回键盘
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    // 该方法当文本框内容出现变化时 及时获取文本最新内容
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        return true
    }
    
}
