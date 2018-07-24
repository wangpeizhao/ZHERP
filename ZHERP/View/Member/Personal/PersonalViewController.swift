//
//  PersonalViewController.swift
//  ZHERP
//
//  Created by MrParker on 2018/7/24.
//  Copyright © 2018 MrParker. All rights reserved.
//

import UIKit

class PersonalViewController: UIViewController {

    typealias RowModel = [String: String]
    
    fileprivate var user: Personal {
        get {
            let personal: Dictionary<String, String> = [
                "username": "王培照",
                "avatar": "bayMax",
                "wechatID": "Parker",
                "myQR": "fb_privacy_shortcuts",
                "address": "番禺区南浦",
                "sex": "男",
                "region": "广东省广州市",
                "signature": "yesterday you said tomorrow",
                "other": "This is a other message",
            ]
            return Personal(personal: personal)
        }
    }
    
    fileprivate var tableViewDataSource: [[String: Any]] {
        get {
            return MemberMenus.personalInfo(withUser: user)
        }
    }
    
    private let tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .grouped)
//        view.sectionHeaderHeight = view.frame.height - 2
//        view.sectionFooterHeight = view.frame.height - 2
        //去除表格上放多余的空隙
        view.contentInset = UIEdgeInsetsMake(-10, 0, 0, 0)
        view.register(PersonalBaseCell.self, forCellReuseIdentifier: PersonalBaseCell.identifier)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Specs.color.gray
        // set bar
        setNavBarTitle(view: self, title: "个人信息")
        
        // set back btn
        let selector: Selector = #selector(actionBack)
        setNavBarBackBtn(view: self, title: "个人信息", selector: selector)
        
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        
        // Set layout for tableView.
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[tableView]-0-|", options: .directionLeadingToTrailing, metrics: nil, views: ["tableView": tableView]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[tableView]-0-|", options: .directionLeadingToTrailing, metrics: nil, views: ["tableView": tableView]))
    }
    
    @objc func actionBack() {
        //        _dismiss(view: self)
        self.hidesBottomBarWhenPushed = false
        print("MemberViewController actionBack ")
    }
    
    fileprivate func rows(at section: Int) -> [Any] {
        return tableViewDataSource[section][MemberMenus.Rows] as! [Any]
    }
    
    fileprivate func title(at section: Int) -> String? {
        return tableViewDataSource[section][MemberMenus.Section] as? String
    }
    
    fileprivate func rowModel(at indexPath: IndexPath) -> RowModel {
        return rows(at: indexPath.section)[indexPath.row] as! RowModel
    }
}

extension PersonalViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewDataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows(at: section).count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return title(at: section)
    }
    
    //设置分组尾的高度
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    //将分组尾设置为一个空的View
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let modelForRow = rowModel(at: indexPath)
        var cell = UITableViewCell()
        
        guard let title = modelForRow[MemberMenus.Title] else {
            return cell
        }
        
        if title == user.username {
            cell = UITableViewCell.init(style: .subtitle, reuseIdentifier: nil)
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: PersonalBaseCell.identifier, for: indexPath)
        }
        
        cell.textLabel?.text = title
        
        if "avatar" == modelForRow[MemberMenus.key], let avatar = modelForRow[MemberMenus.Value] {
            cell.imageView?.image = UIImage(named: avatar)
        } else if title != MemberMenus.logout && title != MemberMenus.back {
//            cell.imageView?.image = UIImage(named: Specs.imageName.placeholder)
        }
        
        if title == user.username {
            cell.detailTextLabel?.text = modelForRow[MemberMenus.SubTitle]
        }
        
        return cell
    }
}

extension PersonalViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let modelForRow = rowModel(at: indexPath)
        
        guard modelForRow[MemberMenus.Value] != nil else {
            return 0.0
        }
        
        if "avatar" == modelForRow[MemberMenus.key] {
            return 64.0
        } else {
            return 44.0
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let modelForRow = rowModel(at: indexPath)
        
        guard let title = modelForRow[MemberMenus.Title] else {
            return
        }
        
        if title == MemberMenus.seeMore || title == MemberMenus.addFavorites {
            cell.textLabel?.textColor = Specs.color.tint
            cell.accessoryType = .none
        } else if title == MemberMenus.logout {
            cell.textLabel?.centerXAnchor.constraint(equalTo: cell.centerXAnchor).isActive = true
            cell.textLabel?.textColor = Specs.color.red
            cell.textLabel?.textAlignment = .center
            cell.accessoryType = .none
        }  else if title == MemberMenus.back {
            cell.textLabel?.centerXAnchor.constraint(equalTo: cell.centerXAnchor).isActive = true
            cell.textLabel?.textColor = Specs.color.blue
            cell.textLabel?.textAlignment = .center
            cell.accessoryType = .none
        } else {
            cell.accessoryType = .disclosureIndicator
        }
    }
    
    func logout(_: UIAlertAction)->Void {
        _logout()
        _open(view: self, vcName: "login", withNav: false)
        //        let sb = UIStoryboard(name: "Main", bundle:nil)
        //        let vc = sb.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        //        //VC为该界面storyboardID，Main.storyboard中选中该界面View，Identifier inspector中修改
        //        self.present(vc, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let modelForRow = rowModel(at: indexPath)
        
        let vc = EditPersonalViewController()
        vc.personalTitle = modelForRow[MemberMenus.Title]
        vc.personalValue = modelForRow[MemberMenus.Value]
        vc.personalKey = modelForRow[MemberMenus.key]
        
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        let cell = sender as? UITableViewCell
    //        if segue.identifier == "showProduct" {
    //            if let cell = sender as? UITableViewCell,
    //                let indexPath = tableView.indexPath(for: cell),
    //                let productVC = segue.destination as? ProductViewController {
    //                productVC.product = products?[(indexPath as NSIndexPath).row]
    //            }
    //        }
    //    }
}

