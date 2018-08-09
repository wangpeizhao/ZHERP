//
//  OrderDetailViewController.swift
//  ZHERP
//
//  Created by MrParker on 2018/7/15.
//  Copyright © 2018 MrParker. All rights reserved.
//

import UIKit

class OrderDetailViewController: UIViewController {
    
    
//    // cellID
//    fileprivate let LXFContactCellID = "LXFContactCellID"
//    // footerH
//    fileprivate let LXFContactFooterH: CGFloat = 49.0
//    // headerH
//    fileprivate let LXFContactHeaderH: CGFloat = 22.0
    
    @IBOutlet weak var orderImage: UIImageView!
    @IBOutlet weak var OrderPrice: UILabel!
    @IBOutlet weak var OrderTitle: UILabel!
    //    @IBOutlet weak var OrderPrice: UILabel!
//    @IBOutlet weak var OrderTitle: UILabel!
    
    var detailCandy: Candy? {
        didSet {
//            configureView()
        }
    }
//    @IBOutlet weak var searchBar: UISearchBar!
//    @IBOutlet var searchBar: UISearchBar!
    
//
//    // MARK: tableview
//    lazy var tableView: UITableView = {  [unowned self] in
//        let table = UITableView(frame: self.view.bounds, style: .plain)
////        table.dataSource = self
////        table.delegate = self
//        table.contentInset = UIEdgeInsetsMake(64, 0, 44, 0)
//        table.scrollIndicatorInsets = UIEdgeInsetsMake(64, 0, 44, 0)
//        table.rowHeight = 55.0
//        let footView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: LXFContactFooterH + 0.4))
//        footView.backgroundColor = kSplitLineColor
//        footView.addSubview(self.footerL)
//        table.tableFooterView = footView
//        // 改变索引的颜色
//        table.sectionIndexColor = UIColor.black
//        // 改变索引背景颜色
//        table.sectionIndexBackgroundColor = UIColor.clear
//        // 改变索引被选中的背景颜色
//        // table.sectionIndexTrackingBackgroundColor = UIColor.green
//        return table
//    }()
//    // MARK: footerView
//    lazy var footerL: UILabel = {
//        let footer = UILabel(frame: CGRect(x: 0, y: 0.45, width: kScreenW, height: LXFContactFooterH))
//        footer.text = "X位联系人"
//        footer.font = UIFont.systemFont(ofSize: 15)
//        footer.backgroundColor = UIColor.white
//        footer.textColor = UIColor.gray
//        footer.textAlignment = .center
//        return footer
//    }()
////    // MARK: 处理过的联系人数组
////    lazy var dataArr: [[LXFContactCellModel]] = {
////        return [[LXFContactCellModel]]()
////    }()
////
////    // MARK: 联系人数组
////    var friendArr: [NIMUser]? {
////        didSet {
////            dataArr.removeAll()
////            var arr = [LXFContactCellModel]()
////            for friend in friendArr! {
////                arr.append(LXFContactCellModel(user: friend))
////            }
////            if let count = friendArr?.count {
////                footerL.text = "\(count)位联系人"
////            }
////
////            dataArr = LXFContactHepler.getFriendListData(by: arr)
////            sectionArr = LXFContactHepler.getFriendListSection(by: dataArr)
////
////            // 刷新表格
////            reloadTableView()
////        }
////    }
//    // MARK: 索引数组
//    lazy var sectionArr: [String] = {
//        return [String]()
//    }()
    
    var navTitle: String?
    var order_title: String?
    var order_price: String?
    var order_image: String?
    
    // MARK:- 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = Specs.color.white
        
        print(order_price!)
        print(order_title!)
//        OrderPrice.text = "order_price!"
//        OrderTitle.text = "order_title!"
        print(self.OrderPrice)
        self.OrderPrice.text = order_price!
        self.OrderTitle.text = order_title!
        self.orderImage.image = UIImage(named: order_image!)
        
        setNavBarTitle(view: self, title: navTitle!)
        
        
//        OrderTitle.text = detailCandy?.name
//        OrderPrice.text = detailCandy?.category
        
        // 初始化
//        self.setup()
        
        // 从服务器获取好友信息
//        LXFWeChatTools.shared.refreshFriends()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
//        hidesBottomBarWhenPushed = false
    }
    
    deinit {
        // 移除通知监听
//        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK:- 触摸事件
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        view.resignFirstResponder()
//    }
    

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
//
//// MARK:- 初始化
//extension OrderDetailViewController {
//    fileprivate func setup() {
//        // 设置标题
//        navigationItem.title = "通讯录"
//
//        // 设置右侧按钮
//        createRightBarBtnItem(icon: #imageLiteral(resourceName: "contacts_add_friend"), method: #selector(addMenu))
//
//        // 搜索控制器
//        let searchController = LXFSearchController(searchResultsController: UITableViewController())
//        self.searchController = searchController
//        tableView.tableHeaderView = searchController.searchBar
//
//        // 添加tableView
//        self.view.addSubview(tableView)
//
//        // 注册通知
//        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableView), name: NSNotification.Name(rawValue: kNoteContactUpdateFriends), object: nil)
//        // 注册cell
//        tableView.register(UINib(nibName: String(describing: LXFContactCell.self), bundle: nil), forCellReuseIdentifier: LXFContactCellID)
//
//        // 获取好友列表
//        friendArr = getMyFriends()
//    }
//}
//
//extension OrderDetailViewController {
//    func addMenu(_ btn: UIButton) {
//        LXFLog("添加朋友")
//
//        hidesBottomBarWhenPushed = true
//        navigationController?.pushViewController(LXFAddFriendViewController(), animated: true)
//    }
//}
//
//// MARK:- 测试
//extension OrderDetailViewController {
//    func addFriendTest() {
//        //        LXFWeChatTools.shared.addFriend("lqr", message: "我们加为好友吧") { (error) in
//        //            LXFLog(error)
//        //        }
//    }
//
//    func getMyFriends() -> [NIMUser]? {
//        return LXFWeChatTools.shared.getMyFriends()
//    }
//}
//
//
//// MARK:- UITableViewDataSource UITableViewDelegate
//extension OrderDetailViewController: UITableViewDataSource, UITableViewDelegate {
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return dataArr.count + 1
//    }
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if section == 0 {
//            return funcArr.count
//        }
//        return dataArr[section - 1].count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        var data: LXFContactCellModel?
//        if indexPath.section == 0 {
//            data = funcArr[indexPath.row]
//        } else {
//            data = dataArr[indexPath.section - 1][indexPath.row]
//        }
//
//        let cell = tableView.dequeueReusableCell(withIdentifier: LXFContactCellID) as? LXFContactCell
//        cell?.model = data
//
//        return cell!;
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        var data: LXFContactCellModel?
//        if indexPath.section == 0 {
//            data = funcArr[indexPath.row]
//        } else {
//            data = dataArr[indexPath.section - 1][indexPath.row]
//        }
//
//        if indexPath.section == 0 {
//            LXFLog("点击了 -- \(data?.title)")
//        } else {
//            LXFLog(data?.userId)
//            hidesBottomBarWhenPushed = true
//            navigationController?.pushViewController(LXFChatController(user: data), animated: true)
//        }
//    }
//
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let header = UIView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: LXFContactHeaderH))
//        header.backgroundColor = kSectionColor
//
//        let titleL = UILabel(frame: header.bounds)
//        titleL.text = self.tableView(tableView, titleForHeaderInSection: section)
//        titleL.font = UIFont.systemFont(ofSize: 14.0)
//        titleL.x = 10
//        header.addSubview(titleL)
//        return header
//    }
//
//
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        if section == 0 {
//            return 0
//        }
//        return LXFContactHeaderH
//    }
//
//    // 返回索引数组
//    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
//        return sectionArr
//    }
//    // 返回每个索引的内容
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        if section == 0 {
//            return nil
//        }
//        return sectionArr[section]
//    }
//    // 跳至对应的section
//    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
//        if index == 0 {
//            tableView.scrollRectToVisible(searchController!.searchBar.frame, animated: true)
//            return -1
//        }
//        return index
//    }
//
//    // 刷新表格
//    @objc func reloadTableView() {
//        LXFLog("刷新表格")
//        tableView.reloadData()
//    }
//}
