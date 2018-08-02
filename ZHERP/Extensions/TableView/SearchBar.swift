//
//  SearchBar.swift
//  ZHERP
//
//  Created by MrParker on 2018/7/15.
//  Copyright © 2018 MrParker. All rights reserved.
//

import UIKit

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
    func buildSearchBar(searchOffset: inout CGFloat, searchHeight: CGFloat) -> UISearchController {
        let currentVersion = getIOSVersion()
        //配置搜索控制器
        // searchBar中textField的placeholder的宽度可以获取
        let _label = UILabel.init()
        _label.text = "搜索订单号"
        _label.font = UIFont.systemFont(ofSize: 14)
        _label.sizeToFit()
        //        print(_label.frame.width)
        
//        var searchController = UISearchController()
//        searchController = ({
            let controller = UISearchController(searchResultsController: nil)
            print(controller.searchBar.frame.size.width) // 414.0
            print(controller.searchBar.frame.size.height) // 56.0
            // 计算偏移量:偏移量 =（searchBar的宽度-label宽度-搜索框图片加上图片和字体之间的宽度）/ 2
            searchOffset = (controller.searchBar.frame.size.width - _label.frame.width - 50 ) / 2
//            controller.searchResultsUpdater = UISearchResultsUpdating
//            controller.searchBar.delegate = UISearchBarDelegate
            controller.hidesNavigationBarDuringPresentation = true
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.searchBarStyle = .minimal
            controller.searchBar.sizeToFit()
            controller.searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
            controller.searchBar.backgroundColor = Specs.color.white
            //            controller.searchBar.setImage(UIImage(named: "VoiceSearchStartBtn"), for: .search, state: UIControlState.normal)
            
            controller.searchBar.layer.masksToBounds = true;
            controller.searchBar.layer.cornerRadius = 2;
            controller.searchBar.layer.borderWidth = 0;
            controller.searchBar.contentMode = .center;
            // searchBar弹出的键盘类型设置
            controller.searchBar.returnKeyType = UIReturnKeyType.search;
            controller.searchBar.placeholder = "搜索订单号"
            controller.searchBar.barTintColor = Specs.color.white
            //搜索栏取消按钮文字
            controller.searchBar.setValue("取消", forKey:"_cancelButtonText")
            controller.searchBar.frame = CGRect(x: 0, y: 0, width: controller.searchBar.frame.size.width, height: searchHeight + 10)
            
            // 判断是不是大于IOS 11
            if currentVersion < 11 {
                // searchBar中的textField设置
                let searchField = controller.searchBar.value(forKey: "_searchField") as! UITextField;
                searchField.setValue(UIFont.systemFont(ofSize: 14), forKeyPath: "_placeholderLabel.font");
                searchField.setValue(UIColor.init(red: 70/255.0, green: 70/255.0, blue: 70/255.0, alpha: 1), forKeyPath: "_placeholderLabel.textColor");
                searchField.attributedPlaceholder = NSAttributedString.init(string: "搜索订单号", attributes: [NSAttributedStringKey.baselineOffset:-2]);
            }else{
                // 获取当前屏幕宽度
                self.view.frame.size.width = UIScreen.main.bounds.size.width
                // 重新布局
                self.view.layoutSubviews()
                controller.searchBar.setPositionAdjustment(UIOffsetMake(searchOffset , 0), for: UISearchBarIcon.search)
                //                controller.searchBar.setSearchFieldBackgroundImage(UIImage(named: "searchBg"), for: UIControlState.normal)
            }
            // 使键盘点击空白处关闭
            let tap = UITapGestureRecognizer.init(target: self, action: #selector(viewTapped(tap:)));
            tap.cancelsTouchesInView = false;
            self.view.addGestureRecognizer(tap);
            //
            //            accessoryView = UIView(frame: CGRect(x: 0, y: self.navHeight, width: self.view.frame.width, height: 200))
            //            accessoryView.backgroundColor = UIColor.gray
            //
            //
            //            let historyTitle = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
            //            historyTitle.text = "搜索历史"
            //            accessoryView.addSubview(historyTitle)
            //
            //
            //            searchWord = UILabel(frame: CGRect(x: 0, y: 30, width: 200, height: 30))
            //            accessoryView.addSubview(searchWord)
            //
            //
            //            let keyword = UIButton(frame: CGRect(x: 0, y: 60, width: 200, height: 30))
            //            keyword.setTitle("Hello world", for: UIControlState.normal)
            //            keyword.addTarget(self, action: #selector(_keyword), for: UIControlEvents.touchUpInside)
            //            accessoryView.addSubview(keyword)
            
            //            controller.searchBar.inputAccessoryView = accessoryView
            
            return controller
//        })()
        
    }
    
    @objc func viewTapped(tap: UITapGestureRecognizer) {
//        searchController.searchBar.resignFirstResponder()
    }
}
