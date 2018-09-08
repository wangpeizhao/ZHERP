//
//  SearchBar.swift
//  ZHERP
//
//  Created by MrParker on 2018/7/15.
//  Copyright © 2018 MrParker. All rights reserved.
//

import UIKit

let SearchBtnHeight: CGFloat = 50.0

public func searchBarBtn(view: UIViewController, navHeight: CGFloat, placeholder: String, action: Selector) {
    let buttonView = UIView(frame: CGRect(x: 0, y: navHeight, width: ScreenWidth, height: SearchBtnHeight))
    buttonView.backgroundColor = UIColor(hex: 0xefeef4)
    view.view.addSubview(buttonView)
    
    let button = UIButton(frame: CGRect(x: 10, y: 10, width: ScreenWidth - 20, height: 30))
    button.setTitle(placeholder, for: UIControlState())
    button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
    button.setTitleColor(UIColor(hex: 0x8e8e93), for: UIControlState())
    button.backgroundColor = Specs.color.white
    button.layer.borderWidth = 0;
    button.layer.borderColor = UIColor(hex: 0xf5f5f5).cgColor
    button.layer.cornerRadius = Specs.border.radius
    button.layer.masksToBounds = true
    button.addTarget(view, action: action, for: .touchUpInside)
    buttonView.addSubview(button)
}

//构建搜索框
public func buildSearchBar(searchBar: UISearchBar, placeholder: String) {
    searchBar.layer.masksToBounds = false;
    searchBar.layer.borderWidth = 1;
    searchBar.contentMode = .center;
    searchBar.layer.borderColor = UIColor.cgColor().cgColor;
    searchBar.returnKeyType = UIReturnKeyType.default;
    searchBar.placeholder = placeholder
    searchBar.searchBarStyle = .prominent
//    searchBar.frame = CGRect(x: 80, y: 100, width: 200, height: 40)
}

extension UISearchController {
    
    static let resultVC = UINavigationController(rootViewController: OrderSearchResultViewController())
    static let controller: UISearchController = UISearchController(searchResultsController: resultVC)
    
    static func buildSearchBar(_view: UIViewController, searchHeight: inout CGFloat, searchOffset: inout CGFloat, placeholder: String) -> UISearchController {
        let currentVersion = getIOSVersion()
        //配置搜索控制器
        // searchBar中textField的placeholder的宽度可以获取
        let _label = UILabel.init()
        _label.text = placeholder
        _label.font = UIFont.systemFont(ofSize: 14)
        _label.sizeToFit()
        
//        print(controller.searchBar.frame.size.width) // 414.0
//        print(controller.searchBar.frame.size.height) // 56.0
        // 计算偏移量:偏移量 =（searchBar的宽度-label宽度-搜索框图片加上图片和字体之间的宽度）/ 2
        searchOffset = (controller.searchBar.frame.size.width - _label.frame.width - 50 ) / 2
        controller.hidesNavigationBarDuringPresentation = true
        controller.dimsBackgroundDuringPresentation = false
        controller.searchBar.searchBarStyle = .prominent
        controller.searchBar.sizeToFit()
        controller.searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        controller.searchBar.backgroundColor = Specs.color.grayBg
        
        
        controller.searchBar.delegate = _view as? UISearchBarDelegate
        controller.searchResultsUpdater = _view as? UISearchResultsUpdating
        
        controller.definesPresentationContext = true
    
        controller.searchBar.tintColor = RGBA(r: 0.12, g: 0.74, b: 0.13, a: 1.00)
    
//        controller.searchBar.layer.masksToBounds = true;
        controller.searchBar.layer.cornerRadius = 2;
        controller.searchBar.layer.borderWidth = 0;
        controller.searchBar.contentMode = .center;
        // searchBar弹出的键盘类型设置
        controller.searchBar.returnKeyType = UIReturnKeyType.search;
        controller.searchBar.placeholder = placeholder
        controller.searchBar.barTintColor = Specs.color.white
        
        
        controller.searchBar.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 31)
        controller.searchBar.barStyle = .default
        controller.searchBar.backgroundColor = .white
        controller.searchBar.barTintColor = .white
//        controller.searchBar.delegate = self
        controller.searchBar.autocapitalizationType = .none
        controller.searchBar.placeholder = "搜索"
        controller.searchBar.layer.borderColor = UIColor.white.cgColor
        controller.searchBar.layer.borderWidth = 1
        controller.searchBar.layer.masksToBounds = true
        
        //搜索栏取消按钮文字
        controller.searchBar.setValue("取消", forKey:"_cancelButtonText")
//        let uiButton = controller.searchBar.value(forKey: "cancelButton") as! UIButton
//        uiButton.setTitle("取消", for: .normal)
//        uiButton.setTitleColor(UIColor.orange,for: .normal)
        controller.searchBar.frame = CGRect(x: 0, y: 0, width: controller.searchBar.frame.size.width, height: 44)
    
        let searchField = controller.searchBar.value(forKey: "_searchField") as! UITextField;
        searchField.setValue(UIFont.systemFont(ofSize: 13), forKeyPath: "_placeholderLabel.font");
    
        // 判断是不是大于IOS 11
        if currentVersion < 11 {
            // searchBar中的textField设置
            searchField.setValue(UIColor.init(red: 70/255.0, green: 70/255.0, blue: 70/255.0, alpha: 1), forKeyPath: "_placeholderLabel.textColor");
            searchField.attributedPlaceholder = NSAttributedString.init(string: placeholder, attributes: [NSAttributedStringKey.baselineOffset: 2]);
        }else{
            // 获取当前屏幕宽度
            _view.view.frame.size.width = UIScreen.main.bounds.size.width
            // 重新布局
            _view.view.layoutSubviews()
            controller.searchBar.setPositionAdjustment(UIOffsetMake(searchOffset + 3 , 0), for: UISearchBarIcon.search)
            controller.searchBar.setSearchFieldBackgroundImage(UIImage(named: "searchBg"), for: UIControlState.normal)
        }
        return controller
    }
}
