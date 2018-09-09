//
//  HPickingGoodViewController.swift
//  ZHERP
//
//  Created by MrParker on 2018/9/8.
//  Copyright © 2018 MrParker. All rights reserved.
//

import UIKit

class HPickingGoodViewController: UIViewController, SliderGalleryControllerDelegate {

    var tableView: UITableView!
    let CELL_IDENTIFY_ID = "CELL_IDENTIFY_ID"
    var navHeight: CGFloat!
    var tabBarHeight: CGFloat!
    
    // 添加数量
    var _quantityValue: String!
    
    var _HPickingGoodView: HPickingGoodView!
    
    // 初始数据
    var valueArr = [String: String]()
    
    //图片轮播组件
    var sliderGallery : SliderGalleryController!
    
    //图片集合
    var images = ["http://bm.51afa.com/upload/news/2018/09/09/2018090908562314785.jpg",
                  "http://bm.51afa.com/upload/news/2018/09/09/2018090908561880369.jpg",
                  "http://bm.51afa.com/upload/news/2018/09/09/2018090908561518138.jpg",
                  "http://bm.51afa.com/upload/news/2018/09/09/2018090908561187033.jpg"]
    
    // 字段数据
    var dataArr = [[String: Any]]()
    
    // 数据model
    var _initData = [String: String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = Specs.color.white
        setNavBarTitle(view: self, title: "拣货商品")
        setNavBarBackBtn(view: self, title: "", selector: #selector(actionBack))
        
        // 设置右侧按钮
        let rightBarBtnRefresh = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(actionRefresh))
        rightBarBtnRefresh.image = UIImage(named: "refresh")
        rightBarBtnRefresh.tintColor = Specs.color.white
        self.navigationItem.rightBarButtonItems = [rightBarBtnRefresh]
        
        self._setup()
        // Do any additional setup after loading the view.
    }
    
    @objc func actionBack() {
        
    }
    
    @objc func actionRefresh() {
        sliderGallery.reloadData()
    }
    
    @objc func actionAdd() {
        if self._quantityValue == nil || Int(self._quantityValue) == 0 {
            _alert(view: self, message: "请先填写拣货数量.")
            return
        }
        let _target = HPickingViewController()
        _push(view: self, target: _target, rootView: false)
    }
    
    @objc func actionTextField(_ sender: UITextField) {
        sender.resignFirstResponder()
        self._quantityValue = sender.text!
    }
    
    fileprivate func _setup() {
        self.navHeight = self.navigationController?.navigationBar.frame.maxY
        self.tabBarHeight = self.tabBarController?.tabBar.bounds.size.height
        
        self.initData()
        
        self._HPickingGoodView = HPickingGoodView()
        _HPickingGoodView.tabBarHeight = self.tabBarHeight
        self.addChildViewController(_HPickingGoodView)
        
        let _frame = CGRect(x: 0, y: self.navHeight, width: ScreenWidth, height: ScreenHeight - self.navHeight - self.tabBarHeight)
        self.tableView = UITableView(frame: _frame, style: .grouped)
        
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: CELL_IDENTIFY_ID)
        self.tableView!.register(SimpleBasicsCell.self, forCellReuseIdentifier: SimpleBasicsCell.identifier)
        // 可填写
        self.tableView?.register(UINib(nibName: "SMemberOperateTableViewCell", bundle: nil), forCellReuseIdentifier: "SMemberOperateTableViewCell")
        self.tableView!.tableHeaderView = UIView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0.1))
        self.view.addSubview(self.tableView!)
        
        self._setTabBarCart()
    }
    
    fileprivate func initData() {
        if self.valueArr.count == 0 {
            self.valueArr = [
                "price": "270.50",
                "stock": "5600",
                "title": "美的（Midea）电饭煲 气动涡轮防溢 金属机身 圆灶釜内胆4L电饭锅MB-WFS4037",
                "sn": "201809101454560090",
                "warehouse": "广州仓库",
                "quantity": "12",
                "total": "56740.00"
            ]
        }
        self.dataArr = [
            [
                "rows": [
                    ["title":"拣货数量", "key":"quantity", "value": "", "placeholder": "请输入大于0的整数"],
                    ["title":"货品编号", "key":"sn", "value": self.valueArr["sn"]],
                    ["title":"所属仓库", "key":"warehouse", "value": self.valueArr["warehouse"]]
                ]
            ]
        ]
    }
    
    fileprivate func _setTabBarCart() {
        // tabBarView
        let _tabBarView = UIView()
        self.view.addSubview(_tabBarView)
        _tabBarView.snp.makeConstraints { (make) -> Void in
            make.left.right.equalTo(0)
            make.bottom.equalTo(0)
            make.height.equalTo(self.tabBarHeight)
            make.width.equalTo(ScreenWidth)
        }
        
        let _HPickingGoodView = self._HPickingGoodView.cartDetailView(cartData: self.valueArr)
        _tabBarView.addSubview(_HPickingGoodView)
        self._HPickingGoodView._submitAdd.addTarget(self, action: #selector(actionAdd), for: .touchUpInside)
    }
    
    //图片轮播组件协议方法：获取内部scrollView尺寸
    func galleryScrollerViewSize() -> CGSize {
        return CGSize(width: ScreenWidth, height: ScreenWidth/2)
    }
    
    //图片轮播组件协议方法：获取数据集合
    func galleryDataSource() -> [String] {
        return self.images
    }
    
    //点击事件响应
    @objc func handleTapAction(_ tap:UITapGestureRecognizer)->Void{
        //获取图片索引值
        let index = sliderGallery.currentIndex
        //弹出索引信息
        let alertController = UIAlertController(title: "您点击的图片索引是：",
                                                message: "\(index)", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    fileprivate func _rowsModel(at section: Int) -> [Any] {
        return self.dataArr[section]["rows"] as! [Any]
    }
    
    fileprivate func _rowModel(at indexPath: IndexPath) -> [String: String] {
        return self._rowsModel(at: indexPath.section)[indexPath.row] as! [String : String]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension HPickingGoodViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataArr.count;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self._rowsModel(at: section).count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ""
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SelectCellHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let _hearderView = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenWidth/2 + 90))
        
        let _sliderGalleryView = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenWidth/2))
        _hearderView.addSubview(_sliderGalleryView)
        
        let _sukView = UIView(frame: CGRect(x: 0, y: _sliderGalleryView.frame.size.height, width: ScreenWidth, height: 90))
        _hearderView.addSubview(_sukView)
        
        //初始化图片轮播组件
        self.sliderGallery = SliderGalleryController()
        self.sliderGallery.delegate = self
        self.sliderGallery.view.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenWidth/2);
        //将图片轮播组件添加到当前视图
        self.addChildViewController(self.sliderGallery)
        _sliderGalleryView.addSubview(self.sliderGallery.view)
//        //添加组件的点击事件
//        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTapAction(_:)))
//        sliderGallery.view.addGestureRecognizer(tap)
        
        _sukView.addSubview(self._HPickingGoodView.goodDeatilView(sukData: self.valueArr))
        
        return _hearderView
    }
    
    //设置分组头的高度
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return ScreenWidth / 2 + 90
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return ""
    }
    
    //设置分组尾的高度
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 30
    }
    
    //创建各单元显示内容(创建参数indexPath指定的单元）
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let _row = self._rowModel(at: indexPath)
        let key: String = _row["key"]!
        
        let textFields = ["quantity"]
        if (textFields.contains(key)) {
            let cell: SMemberOperateTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SMemberOperateTableViewCell") as! SMemberOperateTableViewCell
            cell.TextFieldLabel.text = _row["title"]
            cell.TextFieldLabel.sizeToFit()
            cell.TextFieldLabel.font = Specs.font.regular
            
            cell.TextFieldValue.text = _row["value"]
            cell.TextFieldValue.textColor = UIColor(hex: 0x666666)
            cell.TextFieldValue.placeholder = _row["placeholder"]
            cell.TextFieldValue.clearButtonMode = UITextFieldViewMode.always
            cell.TextFieldValue.adjustsFontSizeToFitWidth = true
            cell.TextFieldValue.returnKeyType = UIReturnKeyType.done
            cell.TextFieldValue.keyboardType = UIKeyboardType.numberPad
            cell.TextFieldValue.delegate = self
            
            cell.accessoryType = .none
            return cell
        }
        
        var cell = UITableViewCell()
        cell = tableView.dequeueReusableCell(withIdentifier: SimpleBasicsCell.identifier, for: indexPath)
        
        cell.textLabel?.text = _row["title"]
        cell.textLabel?.font = Specs.font.regular
        cell.textLabel?.textColor = UIColor(hex: 0x666666)
        
        cell.detailTextLabel?.text = _row["value"]
        cell.detailTextLabel?.font = Specs.font.regular
        
        cell.accessoryType = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension HPickingGoodViewController: UITextFieldDelegate {
    
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
        //        textField.resignFirstResponder()
        self.actionTextField(textField)
        return true
    }
    // 该方法当文本框内容出现变化时 及时获取文本最新内容
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        return true
    }
}
