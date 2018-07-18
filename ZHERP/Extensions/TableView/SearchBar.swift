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
