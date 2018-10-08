//
//  HPickingViewController.swift
//  ZHERP
//
//  Created by MrParker on 2018/9/8.
//  Copyright © 2018 MrParker. All rights reserved.
//

import UIKit
import MJRefresh
import SnapKit

class HPickingViewController: UIViewController , UIGestureRecognizerDelegate, HPickingViewDelegate{
    
    var tableView: UITableView!
    let CELL_IDENTIFY_ID = "CELL_IDENTIFY_ID"
    var navHeight: CGFloat!
    var tabBarHeight: CGFloat!
    
    var selectedIds: [Int] = [123]
    
    // 合计总价
    var _totalValue: UILabel!
    // 合计数量
    var _quantityValue: UILabel!
    
    var _HPickingView: HPickingView!
    
    var _tabBarCartView: UIView!
    // 阴影
    var cover: UIView!
    
    // 初始数据
    var valueArr = [String: String]()
    
    // 顶部刷新
    let header = MJRefreshNormalHeader()
    
    
    
    var dataArr : [Int: [String:String]] = [
        0: ["sn": "2018090612344519995",
            "id": "123",
         "suk": "CD_PPC01CD_PPC01",
         "avatar": "bayMax",
         "warehouse": "深圳仓库",
         "price": "80000.88",
         "total": "987452.00",
         "quantity": "1",
         "stock": "5600",
//         "name": "六神花露水001",
         "name": "美的（Midea）电饭煲 气动涡轮防溢 金属机身 圆灶釜内胆4L电饭锅MB-WFS4037",
        "cost": "2350.00", "location": "广州白马3434", "status": "-1"],
        1: ["sn": "2018090612344519995",
            "id": "124",
         "suk": "CD_PPC01CD_PPC01",
         "avatar": "swift",
         "warehouse": "深圳仓库",
         "price": "80000.88",
         "total": "987452.00",
         "quantity": "1",
         "stock": "5600",
//         "name": "六神花露水002",
         "name": "美的（Midea）电饭煲 气动涡轮防溢 金属机身 圆灶釜内胆4L电饭锅MB-WFS4037",
        "cost": "2350.00", "location": "广州白马3434", "status": "-1"],
        2: ["sn": "2018090612344519995",
            "id": "125",
         "suk": "CD_PPC01CD_PPC01",
         "avatar": "php",
         "warehouse": "深圳仓库",
         "price": "80000.88",
         "total": "987452.00",
         "quantity": "12",
         "stock": "5600",
//         "name": "六神花露水003",
         "name": "美的（Midea）电饭煲 气动涡轮防溢 金属机身 圆灶釜内胆4L电饭锅MB-WFS4037",
        "cost": "2350.00", "location": "广州白马3434", "status": "-1"],
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        print("HPickingViewController:->viewDidLoad()")
        
        self.view.backgroundColor = Specs.color.white
        setNavBarTitle(view: self, title: "正在拣货")
        setNavBarBackBtn(view: self, title: "", selector: #selector(actionBack))
        
        // 设置右侧按钮1(扫码)
        let rightBarBtnScan = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(actionScan))
        rightBarBtnScan.image = UIImage(named: "scan")
        rightBarBtnScan.tintColor = Specs.color.white
        
        // 设置右侧按钮2(筛选)
        let rightBarBtnRefresh = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(actionEdit))
        rightBarBtnRefresh.image = UIImage(named: "edit")
        rightBarBtnRefresh.tintColor = Specs.color.white
        self.navigationItem.rightBarButtonItems = [rightBarBtnScan,rightBarBtnRefresh]
        
        self._setup()
        
        // 监听键盘 打开 关闭
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(note:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHidden(note:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self._HPickingView._submitAdd.setTitle("去结算(\(self.selectedIds.count))", for: .normal)
    }
    
    //监听键盘弹出事件：
    @objc func keyboardWillShow(note: NSNotification) {
        let userInfo = note.userInfo!
        let  keyBoardBounds = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let duration = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        
        let deltaY = keyBoardBounds.size.height
        let animations:(() -> Void) = {
            //键盘的偏移量
            //self.tableView.transform = CGAffineTransformMakeTranslation(0 , -deltaY)
            self._tabBarCartView.frame.origin.y = ScreenHeight - deltaY - self.tabBarHeight * 2
            //延时1秒执行
            let time: TimeInterval = 0.5
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time) {
                //code
                self._tabBarCartView.isHidden = false
                self.cover.isHidden = false
            }
        }
        
        if duration > 0 {
            let options = UIViewAnimationOptions(rawValue: UInt((userInfo[UIKeyboardAnimationCurveUserInfoKey] as! NSNumber).intValue << 16))
            UIView.animate(withDuration: duration, delay: 0, options:options, animations: animations, completion: nil)
        }else{
            animations()
        }
    }
    
    //监听键盘隐藏事件：
    @objc func keyboardWillHidden(note: NSNotification) {
        let userInfo  = note.userInfo!
        let duration = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        
        let animations:(() -> Void) = {
            //键盘的偏移量
            //self.tableView.transform = CGAffineTransformIdentity
            self.keyboardHidden()
        }
        if duration > 0 {
            let options = UIViewAnimationOptions(rawValue: UInt((userInfo[UIKeyboardAnimationCurveUserInfoKey] as! NSNumber).intValue << 16))
            UIView.animate(withDuration: duration, delay: 0, options:options, animations: animations, completion: nil)
        }else{
            animations()
        }
    }
    
    @objc func actionEdit() {
        if (self._tabBarCartView.isHidden == false) {
            self._tabBarCartView.isHidden = true
            self.cover.isHidden = true
            self._HPickingView._amountTextfield.resignFirstResponder()
        } else {
            self.cover.isHidden = false
            self._HPickingView._amountTextfield.becomeFirstResponder()
        }
    }
    
    @objc func actionEditActive(alert: UIAlertAction) {
        self.actionEdit()
    }
    
    @objc func actionClose() {
        self.keyboardHidden()
    }
    @objc func tapCover(_ tapCover : UITapGestureRecognizer){
        self.keyboardHidden()
    }
    
    @objc func actionSave() {
        
    }
    
    @objc func actionBack() {
        
    }
    
    @objc func actionSelectAll(_ sender: UIButton) {
        if (sender.isSelected) {
            self.selectedIds = []
            sender.setImage(UIImage(named: "unselected"), for: .normal)
        } else {
            sender.setImage(UIImage(named: "selected"), for: .normal)
            self.selectedIds.removeAll()
            for (_, _data) in self.dataArr {
                self.selectedIds.append(Int(_data["id"]!)!)
            }
        }
        self._HPickingView._submitAdd.setTitle("去结算(\(self.selectedIds.count))", for: .normal)
        self.tableView.reloadData()
        sender.isSelected = !sender.isSelected
    }
    
    @objc func actionSelect(_ sender: UIButton) {
        let _id = sender.tag
        if (!self.selectedIds.contains(_id)) {
            self.selectedIds.append(_id)
            sender.setImage(UIImage(named: "selected"), for: .normal)
        } else {
            self.selectedIds = self.selectedIds.filter{$0 != _id}
            sender.setImage(UIImage(named: "unselected"), for: .normal)
            sender.isSelected = false
        }
        self._HPickingView._submitAdd.setTitle("去结算(\(self.selectedIds.count))", for: .normal)
    }
    
    @objc func actionPlus(_ sender: UIButton) {
        let _max = 999
        let _indexPath: IndexPath = IndexPath(row: sender.tag, section: 0)
        let _cell: HPickingGoodTableViewCell = self.tableView.cellForRow(at: _indexPath as IndexPath) as! HPickingGoodTableViewCell
        let _val = Int(_cell.quantity.text!)!
        if _val >= _max {
            _alert(view: self, message: "最多只能买\(_max)件哦！")
            _cell.quantity.text = "\(_max)"
            _cell.plus.setTitleColor(UIColor.hexInt(0xdddddd), for: UIControlState())
            return
        }
        if (_val + 1 == _max) {
            _cell.plus.setTitleColor(UIColor.hexInt(0xdddddd), for: UIControlState())
        }
        _cell.quantity.text = "\(_val + 1)"
        if (_val == 1) {
            _cell.minus.setTitleColor(UIColor.hexInt(0x000000), for: UIControlState())
        }
    }
    
    @objc func actionMinus(_ sender: UIButton) {
        let _max = 999
        let _indexPath: IndexPath = IndexPath(row: sender.tag, section: 0)
        let _cell: HPickingGoodTableViewCell = self.tableView.cellForRow(at: _indexPath as IndexPath) as! HPickingGoodTableViewCell
        let _val = Int(_cell.quantity.text!)!
        if (_val < 2) {
            _cell.minus.setTitleColor(UIColor.hexInt(0xdddddd), for: UIControlState())
            return
        }
        if (_val - 1 == 1) {
            _cell.minus.setTitleColor(UIColor.hexInt(0xdddddd), for: UIControlState())
        }
        _cell.quantity.text = "\(_val - 1)"
        if (_val == _max) {
            _cell.plus.setTitleColor(UIColor.hexInt(0x000000), for: UIControlState())
        }
    }
    
    @objc func actionScan() {
        let _target = ZHQRCodeViewController()
        _target.actionType = "picking"
        _target.navTitle = "扫码拣货"
        _push(view: self, target: _target, rootView: false)
    }
    
    @objc func actionRefresh() {
        self.tableView!.mj_header.beginRefreshing()
//        self.tableView.reloadData()
    }
    
    @objc func actionCart() {
        if self.valueArr["total"]! == "0.00" || Int(self.valueArr["quantity"]!)! == 0 {
            _alert(view: self, message: "购物车还是空呢，请先拣货")
            return
        }
        let _target = HPickingCompleteViewController()
        _push(view: self, target: _target, rootView: false)
    }
    
    @objc func actionSearch() {
        let _target = SearchViewController()
        _target.navBarTitle = "搜索货品"
        _target.searchBarPlaceholder = "按货品名称或编号搜索"
        _target.searchType = "picking"
        _push(view: self, target: _target, rootView: false)
    }
    
    @objc func clickedMoreBtn(_ sender: UIButton) {
        
    }
    
    @objc func longPressAction(recognizer: UILongPressGestureRecognizer)  {
        if recognizer.state == UIGestureRecognizerState.began {
            print("UIGestureRecognizerStateBegan");
        }
        if recognizer.state == UIGestureRecognizerState.changed {
            print("UIGestureRecognizerStateChanged");
        }
        if recognizer.state == UIGestureRecognizerState.ended {
            print("UIGestureRecognizerStateEnded");
            // tableView.isEditing = !tableView.isEditing
            if tableView.isEditing == true {
                tableView.isEditing = false
            } else {
                // tableView.isEditing = true
//                setNavBarRightBtn(view: self, title: "保存", selector: #selector(actionSave))
                self.setEditing(true,animated: true)
            }
        }
    }
    
    //顶部下拉刷新
    @objc func headerRefresh(){
        print("下拉刷新:\(self.dataArr.count).")
        sleep(1)
        //重现生成数据
        refreshItemData(append: false)
        
        // self.tableView?.mj_header.endRefreshing(.)
        if (self.dataArr.count > 6) {
            DispatchQueue.main.async {
                // 主线程中
                // elf.tableView!.mj_header.state = MJrefreshno
            }
        }
        //重现加载表格数据
        self.tableView!.reloadData()
        //结束刷新
        self.tableView!.mj_header.endRefreshing()
    }
    
    fileprivate func keyboardHidden() {
        self._tabBarCartView.frame.origin.y = ScreenHeight - self.tabBarHeight * 2
        self.cover.isHidden = true
        self._tabBarCartView.isHidden = true
        self._HPickingView._amountTextfield.resignFirstResponder()
    }
    
    //初始化数据
    func refreshItemData(append: Bool) {
        let count = self.dataArr.count
        let imagePaths = ["java","php","html","react","ruby","swift","xcode","bayMax","c#"]
        for i in 0...2 {
            let index = arc4random_uniform(UInt32(imagePaths.count))
            let _imagePath = imagePaths[Int(index)]
            self.dataArr[count + i] = [
                "id": "\(1211 + count + i)",
                "avatar": _imagePath,
                "sn": "2018090612344519995",
                "suk": "AB_PPC\(count + i)",
                "warehouse": "深圳仓库",
                "price": "80000.88",
                "total": "987452.00",
                "quantity": "12",
                "stock": "5600",
                "name": "美的（Midea）电饭煲 气动涡轮防溢 金属机身 圆灶釜内胆4L电饭锅MB-WFS4037六神花露水003",
                "title": "美的（Midea）电饭煲 气动涡轮防溢 金属机身 圆灶釜内胆4L电饭锅MB-WFS4037",
                "cost": "2350.00", "location": "广州白马3434", "status": "-1"]
        }
    }
    
    fileprivate func initData() {
        if self.valueArr.count == 0 {
            self.valueArr = [
                "quantity": "12",
                "total": "56740.00"
            ]
        }
    }
    
    fileprivate func _setup() {
        self.navHeight = self.navigationController?.navigationBar.frame.maxY
        self.tabBarHeight = self.tabBarController?.tabBar.bounds.size.height
        
        self.initData()
        
        searchBarBtn(view: self, navHeight: self.navHeight, placeholder: "按货品名称或编号搜索", action: #selector(actionSearch))
        
        self._HPickingView = HPickingView()
        self._HPickingView._delegate = self
        _HPickingView.tabBarHeight = self.tabBarHeight
        self.addChildViewController(_HPickingView)
        
        let _frame = CGRect(x: 0, y: self.navHeight + SearchBtnHeight, width: ScreenWidth, height: ScreenHeight - self.navHeight - self.tabBarHeight - SearchBtnHeight)
        self.tableView = UITableView(frame: _frame, style: .grouped)
        
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: CELL_IDENTIFY_ID)
        self.tableView!.register(SimpleBasicsCell.self, forCellReuseIdentifier: SimpleBasicsCell.identifier)
        self.tableView?.register(UINib(nibName: "HPickingGoodTableViewCell", bundle: nil), forCellReuseIdentifier: CELL_IDENTIFY_ID)
        self.tableView!.tableHeaderView = UIView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0.1))
        
//        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
//        //设置分割线颜色
//        self.tableView.separatorColor = UIColor.red
        //设置分割线内边距
        self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)

        self.view.addSubview(self.tableView!)
        
        //表格在编辑状态下允许多选
//        self.tableView!.allowsMultipleSelectionDuringEditing = true
//        self.tableView!.setEditing(true, animated:true)
        
        // 长按启动删除、移动排序功能
//        let longPress = UILongPressGestureRecognizer.init(target: self, action: #selector(longPressAction))
//        longPress.delegate = self
//        longPress.minimumPressDuration = 1
//        self.tableView!.addGestureRecognizer(longPress)
        
        //下拉刷新相关设置
        self.header.setTitle("下拉可以刷新", for: .idle)
        self.header.setTitle("松开立即刷新", for: .pulling)
        self.header.setTitle("正在刷新数据...", for: .refreshing)
        self.header.lastUpdatedTimeLabel.text = "最后更新"
        self.header.setTitle("没有更多数据啦~", for: .noMoreData)
        self.header.setRefreshingTarget(self, refreshingAction: #selector(OrderAllViewController.headerRefresh))
        self.tableView!.mj_header = self.header
        
        self.cover = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight))
        self.cover.backgroundColor = normalRGBA(r: 0, g: 0, b: 0, a: 0.3)
        self.cover.isHidden = true
        self.view.addSubview(self.cover)
        
        // 弹出阴影层 手势
        let tapCover = UITapGestureRecognizer(target: self, action: #selector(tapCover(_:)))
        self.cover.addGestureRecognizer(tapCover)
        
        self._setTabBarCart()
        // Do any additional setup after loading the view.
    }
    
    fileprivate func _setTabBarCart() {
        // tabBarView
        let _tabBarView = UIView()
        _tabBarView.backgroundColor = UIColor.orange
        self.view.addSubview(_tabBarView)
        _tabBarView.snp.makeConstraints { (make) -> Void in
            make.left.right.equalTo(0)
            make.bottom.equalTo(0)
            make.height.equalTo(self.tabBarHeight)
            make.width.equalTo(ScreenWidth)
        }
        
        let _HPickingView = self._HPickingView.cartDetailView(cartData: self.valueArr)
        _tabBarView.addSubview(_HPickingView)
        self._HPickingView._submitAdd.addTarget(self, action: #selector(actionCart), for: .touchUpInside)
        self._HPickingView._selectAllBtn.addTarget(self, action: #selector(actionSelectAll(_:)), for: .touchUpInside)
        
        self._tabBarCartView = UIView(frame: CGRect(x: 0, y: ScreenHeight - self.tabBarHeight - 125, width: ScreenWidth, height: self.tabBarHeight * 2))
        self.view.addSubview(self._tabBarCartView)
//        self._tabBarCartView.snp.makeConstraints { (make) -> Void in
//            make.left.right.equalTo(0)
//            make.bottom.equalTo(_tabBarView.snp.top).offset(-250)
//            make.height.equalTo(self.tabBarHeight * 2)
//            make.width.equalTo(ScreenWidth)
//        }
        let _HPickingCartEditView = self._HPickingView.cartEditView(cartData: self.valueArr)
        self._HPickingView._cartCancelBtn.addTarget(self, action: #selector(actionClose), for: .touchUpInside)
        self._tabBarCartView.isHidden = true
        self._tabBarCartView.backgroundColor = UIColor.orange
        self._tabBarCartView.addSubview(_HPickingCartEditView)
    }
    
    public func getCartModification(view: HPickingView, cartData: [String : String]) {
        self.keyboardHidden()
        if (cartData["amount"] == "") {
            return
        }
        var _totalText = ""
        let _totalValue = NSString(string: self.valueArr["total"]!)
        let _amountValue = NSString(string: cartData["amount"]!)
        if (cartData["discountType"] == "discount") {
            if (_amountValue.floatValue < 0.01 || _amountValue.floatValue > 0.99) {
                _alert(view: self, message: "折扣优惠时，优惠值只能为0.01~0.99之间", handler: actionEditActive)
                return
            }
            if (cartData["operateType"] == "minus") {
                _totalText = (String)(_totalValue.floatValue * (1.0 - _amountValue.floatValue))
            } else {
                _totalText = (String)(_totalValue.floatValue * (1.0 + _amountValue.floatValue))
            }
        } else {
            if (cartData["operateType"] == "minus") {
                if (_amountValue.floatValue > _totalValue.floatValue) {
                    _alert(view: self, message: "优惠金额不能大于总金额", handler: actionEditActive)
                    return
                }
                _totalText = (String)(_totalValue.floatValue - _amountValue.floatValue)
            } else {
                _totalText = (String)(_totalValue.floatValue + _amountValue.floatValue)
            }
        }
        self._HPickingView._totalValue.text = _totalText
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        //移除监听
        NotificationCenter.default.removeObserver(self)
    }

}

extension HPickingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArr.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ""
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    //设置分组头的高度
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "点击编辑按钮可修改总价；长按或向左滑可删除。"
    }
    
    //设置分组尾的高度
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return self.dataArr.count == 0 ? 0 : 30
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    //创建各单元显示内容(创建参数indexPath指定的单元）
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let count = self.dataArr.count
        let sectionNo = count - indexPath.row - 1
        
        let cell: HPickingGoodTableViewCell = tableView.dequeueReusableCell(withIdentifier: CELL_IDENTIFY_ID, for: indexPath) as! HPickingGoodTableViewCell
//        let cell = HPickingGoodTableViewCell(style:UITableViewCellStyle.default, reuseIdentifier: "HPickingGoodTableViewCell")
        if !(self.dataArr[sectionNo]?.isEmpty)! {
            var _data = self.dataArr[sectionNo]!
            let _priceArr: Array = _data["price"]!.components(separatedBy: ".")
            cell.avatar.image = UIImage(named: _data["avatar"]!)
            cell.suk.text = _data["suk"]
            cell.suk.sizeToFit()
            cell.name.text = _data["name"]
            cell.name.numberOfLines = 2
            cell.name.sizeToFit()
            cell.stock.text = "库存:" + _data["stock"]!
            cell.stock.sizeToFit()
            cell.location.text = "库位:" + _data["location"]!
            cell.location.sizeToFit()
            cell.priceInt.text = _priceArr[0].isEmpty ? "0" : _priceArr[0]
            cell.priceInt.sizeToFit()
            cell.priceDecimal.text = _priceArr[1].isEmpty ? ".00" : ".\(_priceArr[1])"
            cell.priceDecimal.sizeToFit()

            cell.accessoryType = .none
            
            
            //图片添加阴影
            cell.avatar.layer.shadowOpacity = 0.8
            cell.avatar.layer.shadowColor = UIColor.black.cgColor
            cell.avatar.layer.shadowOffset = CGSize(width: 1, height: 1)
            
            cell.quantity.layer.borderWidth = 1.0
            cell.quantity.layer.borderColor = UIColor.hexInt(0xdddddd).cgColor
//            cell.quantity.layer.masksToBounds = true
            cell.quantity.text = _data["quantity"]
            if (Int(_data["quantity"]!)! == 1) {
                cell.minus.setTitleColor(UIColor.hexInt(0xdddddd), for: UIControlState())
            }
            
            cell.plus.layer.borderWidth = 1.0
            cell.plus.layer.cornerRadius = 2.0
            cell.plus.layer.borderColor = UIColor.hexInt(0xdddddd).cgColor
            cell.plus.addTarget(self, action: #selector(actionPlus(_:)), for: .touchUpInside)
            cell.plus.tag = indexPath.row
            cell.plus.setTitleColor(UIColor.hexInt(0x000000), for: .selected)
            
            cell.minus.layer.borderWidth = 1.0
            cell.minus.layer.cornerRadius = 2.0
            cell.minus.layer.borderColor = UIColor.hexInt(0xdddddd).cgColor
            cell.minus.addTarget(self, action: #selector(actionMinus(_:)), for: .touchUpInside)
            cell.minus.tag = indexPath.row
            cell.minus.setTitleColor(UIColor.hexInt(0x000000), for: .selected)
            
            cell.selectBtn.addTarget(self, action: #selector(actionSelect(_:)), for: .touchUpInside)
            cell.selectBtn.tag = Int(_data["id"]!)!
            if (!self.selectedIds.isEmpty && self.selectedIds.contains(Int(_data["id"]!)!)) {
                cell.selectBtn.setImage(UIImage(named: "selected"), for: .normal)
            } else {
                cell.selectBtn.setImage(UIImage(named: "unselected"), for: .normal)
            }
        }
        cell.tag = indexPath.row
        cell.tintColor = Specs.color.red
        
        return cell
    }
    
//    private lazy var myLayer: CAShapeLayer = {
//        let path = UIBezierPath.init(roundedRect: self.myLabel.bounds, byRoundingCorners: [.topRight , .bottomRight] , cornerRadii: self.myLabel.bounds.size);
//        let layer = CAShapeLayer.init();
//        layer.path = path.cgPath;
//        layer.lineWidth = 5;
//        layer.lineCap = kCALineCapSquare;
//        layer.strokeColor = UIColor.red.cgColor;
//        return layer;
//    }()
        
    
//    //处理列表项的选中事件
//    private func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
//        let cell = self.tableView?.cellForRow(at: indexPath as IndexPath)
//        cell?.accessoryType = .checkmark
//    }
//
//    //处理列表项的取消选中事件
//    private func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: IndexPath) {
//        let cell = self.tableView?.cellForRow(at: indexPath as IndexPath)
//        cell?.accessoryType = .none
//    }
    
    // UITableViewDelegate 方法，处理列表项的选中事件
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
//        let _data = self.dataArr[indexPath.item]
        
        let cell = self.tableView?.cellForRow(at: indexPath as IndexPath)
        cell?.accessoryType = .checkmark
        
        let _target = HPickingGoodViewController()
        _target.valueArr = [
            "sn": "ZHG20180908142345098",
            "title": "京造 芝麻核桃黑豆粉代餐粉 黑芝麻蔓越莓枸杞粉 早餐禅食代餐22g*20 440g",
            "warehouse": "深圳仓库",
            "price": "80000.88",
            "total": "987452.00",
            "quantity": "12",
            "stock": "5600",
        ]

        _push(view: self, target: _target, rootView: false)
    }
}
