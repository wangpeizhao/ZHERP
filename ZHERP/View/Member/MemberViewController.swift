//
//  MemberViewController.swift
//  ZHERP
//
//  Created by MrParker on 2018/7/16.
//  Copyright © 2018 MrParker. All rights reserved.
//

import UIKit

class MemberViewController: MemberBaseViewController {
    
    typealias RowModel = [String: String]
    
    fileprivate var user: Member {
        get {
            return Member(name: "BayMax (可点击)", education: "CMU")
        }
    }
    
    fileprivate var tableViewDataSource: [[String: Any]] {
        get {
            return MemberMenus.populate(withUser: user)
        }
    }
    
    private let tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .grouped)
        //去除表格上放多余的空隙
        view.contentInset = UIEdgeInsetsMake(-15, 0, 0, 0)
        view.register(MemberBaseCell.self, forCellReuseIdentifier: MemberBaseCell.identifier)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Specs.color.gray
        // set bar
        setNavBarTitle(view: self, title: "我")
        
        // set back btn
        let selector: Selector = #selector(actionBack)
        setNavBarBackBtn(view: self, title: "我", selector: selector)
                
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        
        // Set layout for tableView.
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[tableView]-0-|", options: .directionLeadingToTrailing, metrics: nil, views: ["tableView": tableView]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[tableView]-0-|", options: .directionLeadingToTrailing, metrics: nil, views: ["tableView": tableView]))
    }
    
    @objc func actionBack() {
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

extension MemberViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewDataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows(at: section).count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return title(at: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let modelForRow = rowModel(at: indexPath)
        var cell = UITableViewCell()
        
        guard let title = modelForRow[MemberMenus.Title] else {
            return cell
        }
        
        if title == user.name {
            cell = UITableViewCell.init(style: .subtitle, reuseIdentifier: nil)
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: MemberBaseCell.identifier, for: indexPath)
        }
        
        cell.textLabel?.text = title
        
        if let imageName = modelForRow[MemberMenus.ImageName] {
            cell.imageView?.image = UIImage(named: imageName)
        } else if title != MemberMenus.logout && title != MemberMenus.back {
            cell.imageView?.image = UIImage(named: Specs.imageName.placeholder)
        }
        
        if title == user.name {
            cell.detailTextLabel?.text = modelForRow[MemberMenus.SubTitle]
        }
        cell.textLabel?.font = UIFont.systemFont(ofSize: Specs.fontSize.large)
        
        return cell
    }
}

extension MemberViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let modelForRow = rowModel(at: indexPath)
        
        guard let title = modelForRow[MemberMenus.Title] else {
            return 0.0
        }
        
        if title == user.name {
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
        } else {
            cell.accessoryType = .disclosureIndicator
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let modelForRow = rowModel(at: indexPath)
        self.hidesBottomBarWhenPushed = true
        if let action: String = modelForRow[MemberMenus.key] {
            switch action {
            case "Setting":
                _push(view: self, target: SettingViewController(), rootView: false)
                break;
            case "System":
                _push(view: self, target: SystemViewController(), rootView: false)
                break;
            case "Personal":
                _push(view: self, target: PersonalViewController(), rootView: false)
                break;
            default: break
                
            }
        }
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

