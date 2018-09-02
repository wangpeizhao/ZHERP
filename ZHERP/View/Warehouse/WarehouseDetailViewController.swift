//
//  WarehouseDetailViewController.swift
//  ZHERP
//
//  Created by MrParker on 2018/9/2.
//  Copyright © 2018 MrParker. All rights reserved.
//

import UIKit
import SnapKit

class WarehouseDetailViewController: UIViewController {
    
    var Id: Int = 0
    var navTitle: String? = nil
    var value: String? = nil
    var placeholder: String? = nil
    var navHeight: CGFloat!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(hex: 0xf7f7f7)
        setNavBarTitle(view: self, title: self.navTitle!)
        setNavBarRightBtn(view: self, title: "保存", selector: #selector(actionSave))
        
        self._setup()

        // Do any additional setup after loading the view.
    }
    
    @objc func actionSave() {
        
    }
    
    private func _setup() {
        self.navHeight = self.navigationController?.navigationBar.frame.maxY
        
        let _view = UIView(frame: CGRect(x: 0, y: self.navHeight + 10, width: ScreenWidth, height: 40))
        _view.backgroundColor = Specs.color.white
        self.view.addSubview(_view)
        
        let _value = UITextField()
        _value.text = self.value
        _value.placeholder = self.placeholder
        _value.textAlignment = .left
        _value.font = Specs.font.regular
        _value.textColor = Specs.color.gray
        _value.clearButtonMode = .whileEditing
        _value.becomeFirstResponder() // resignFirstResponder
        _view.addSubview(_value)
        _value.snp.makeConstraints {(make) -> Void in
            make.top.equalTo(10)
            make.left.equalTo(15)
            make.right.equalTo(-10)
            make.centerY.equalTo(_view)
        }
        
        let _btn = UIButton(frame: CGRect(x: 10, y: 0, width: ScreenWidth - 20, height: 40))
        _btn.setTitle("保存", for: .normal)
        _btn.setTitleColor(Specs.color.white, for: UIControlState())
        _btn.backgroundColor = Specs.color.main
        _btn.layer.cornerRadius = Specs.border.radius
        _btn.layer.masksToBounds = true
        _btn.titleLabel?.font = UIFont.systemFont(ofSize: Specs.fontSize.regular)
        _btn.addTarget(self, action: #selector(actionSave), for: .touchUpInside)
        self.view.addSubview(_btn)
        _btn.snp.makeConstraints {(make) -> Void in
            make.top.equalTo(_value.snp.bottom).offset(15)
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
