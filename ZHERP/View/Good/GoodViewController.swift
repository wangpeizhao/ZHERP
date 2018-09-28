//
//  GoodViewController.swift
//  ZHERP
//
//  Created by MrParker on 2018/7/29.
//  Copyright © 2018 MrParker. All rights reserved.
//

import UIKit
import SnapKit
import MJRefresh

class GoodViewController: UIViewController {
    
    var _title: String = "货品管理"
    var _placeholder: String = "搜索商品名称/货号"
    var navHeight: CGFloat!
    var tabBarHeight: CGFloat!
    var tableView: UITableView!
    let CELL_IDENTIFY_ID = "CELL_IDENTIFY_ID"
    
    var titleButton: UIButton!
    var titleBottomView: UIView!
    var buttonTags: Array<Int> = Array<Int>()
    var selectedButtonTag: Int!
    let smallMargin: CGFloat = 38.0
    let titleButtonOffset: CGFloat = 6.0
    var buttonClick: Int = 0 //记录当前按钮点击的次数
    
    // 分类按钮
    var categoryBtn: UIButton!
    
    // 阴影
    var cover: UIView!
    var moreView: UIView!
    
    // 分类View
    var categoryTable: UITableView!
    
    var goodListPopupViewController: GoodListPopupViewController!
    var goodListPopupView: UIView!
    var frame_width: CGFloat = 215
    
    // 顶部刷新
    let header = MJRefreshNormalHeader()
    // 底部刷新
    let footer = MJRefreshAutoNormalFooter()
    
    var dataArr = [
        ["avatar": "bayMax", "suk": "AB_PPC0201804451", "name": "六神花露水清新花香冰莲香型喷雾清凉防蚊", "price": "117.50", "stock": "121", "cost": "2150.00", "location": "广州白马1001", "status": "0"],
        ["avatar": "c#", "suk": "BC_PPC02434224", "name": "六神花露水清新花香冰莲香型喷雾清凉防蚊002", "price": "217.50", "stock": "122", "cost": "2250.00", "location": "广州白马1234", "status": "1"],
        ["avatar": "html", "suk": "CD_PPC122324567", "name": "六神花露清新花香冰莲香型喷雾清凉防蚊水", "price": "317.50", "stock": "123", "cost": "2350.00", "location": "广州白马3434", "status": "-1"],
        ["avatar": "java", "suk": "DE_PPC042335467", "name": "六神花露水清新花香冰莲香型喷雾清凉防蚊004", "price": "417.50", "stock": "124", "cost": "2450.00", "location": "广州白马4556", "status": "0"],
        ["avatar": "js", "suk": "EF_PPC05234567", "name": "六神花露水清新花香冰莲香型喷雾清凉防蚊", "price": "517.50", "stock": "125", "cost": "2550.00", "location": "广州白马6787", "status": "1"],
        ["avatar": "php", "suk": "FG_PPC062345678", "name": "六神花露水清新花香冰莲香型喷雾清凉防蚊006", "price": "617.50", "stock": "126", "cost": "2650.00", "location": "广州白马7856", "status": "-1"],
        ["avatar": "react", "suk": "GH_PPC0723456", "name": "六神花露水清新花香冰莲香型喷雾清凉防蚊", "price": "717.50", "stock": "127", "cost": "2570.00", "location": "广州白马4533", "status": "0"],
        ["avatar": "ruby", "suk": "HI_PPC0834567", "name": "六神花露水清新花香冰莲香型喷雾清凉防蚊008", "price": "817.50", "stock": "128", "cost": "2850.00", "location": "广州白马2131", "status": "1"],
        ["avatar": "swift", "suk": "IJ_PPC0924356", "name": "六神花露水清新花香冰莲香型喷雾清凉防蚊", "price": "917.50", "stock": "129", "cost": "2590.00", "location": "广州白马2233", "status": "1"],
        ["avatar": "xcode", "suk": "JK_PPC10", "name": "六神花露水清新花香冰莲香型喷雾清凉防蚊010", "price": "107.50", "stock": "120", "cost": "2500.00", "location": "广州白马3223", "status": "1"],
        ["avatar": "bayMax", "suk": "KL_PPC11", "name": "六神花露水清新花香冰莲香型喷雾清凉防蚊011", "price": "1700.50", "stock": "1200", "cost": "2590.00", "location": "广州白马2345", "status": "0"]
    ]
    
    let titlesArr = ["上架时间", "价格", "库存", "销量"]
    
    let categoryArr = ["最新", "价格", "库存", "销量"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = Specs.color.white
        setNavBarTitle(view: self, title: self._title)
        setNavBarBackBtn(view: self, title: "", selector: #selector(actionBack))
        
        // 设置右侧按钮
        let leftBarBtn = UIBarButtonItem(title: "入仓", style: .plain, target: self, action: #selector(actionAdd))
        leftBarBtn.tintColor = Specs.color.white
        self.navigationItem.leftBarButtonItems = [leftBarBtn]
        
        let rightBarBtn = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(actionScan))
        rightBarBtn.image = UIImage(named: "scan")
        rightBarBtn.tintColor = Specs.color.white
        self.navigationItem.rightBarButtonItems = [rightBarBtn]
        
        self._setup()
        // Do any additional setup after loading the view.
    }
    
    @objc func actionScan() {
        self.hidesBottomBarWhenPushed = true
        let _ZHQRCode = ZHQRCodeViewController()
        _ZHQRCode.actionType = "warehousing"
        _push(view: self, target: _ZHQRCode, rootView: true)
        
    }
    
    @objc func actionAdd() {
        let _target = GoodOperateFViewController()
        _target.dataType = .category
        _target.navTitle = "选择货品分类"
        _push(view: self, target: _target)
    }
    
    @objc func actionMore() {
        self.hideCategoryTable()
        self.moreView.isHidden = !self.moreView.isHidden
        self.hiddenGoodListPopupView()
    }
    
    @objc func hideMoreMenu(_ sender:UIView) {
        self.moreView.isHidden = true
    }
    
    @objc func actionBack() {
        
    }
    
    @objc func actionMoreItem(_ sender: UIButton) {
        self.hideCategoryTable()
        self.moreView.isHidden = true
    }
    
    @objc func actionSearch() {
        let _view = SearchViewController()
        _view.navBarTitle = self._title
        _view.searchBarPlaceholder = self._placeholder
        _view.searchType = "good"
        _push(view: self, target: _view)
    }
    
    private func _setup() {
        self.navHeight = self.navigationController?.navigationBar.frame.maxY
//        self.tabBarHeight = self.navigationController?.toolbar.frame.maxY
        self.tabBarHeight = self.tabBarController?.tabBar.bounds.size.height
        
        let dataView = UIView(frame: CGRect(x: 0, y: self.navHeight + 95, width: ScreenWidth, height: ScreenHeight))
        self.view.addSubview(dataView)
        
        self.cover = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight))
        self.cover.backgroundColor = normalRGBA(r: 0, g: 0, b: 0, a: 0.3)
        self.cover.isHidden = true
        self.view.addSubview(self.cover)
        
        // 弹出阴影层 手势
        let tapCover = UITapGestureRecognizer(target: self, action: #selector(tapCover(_:)))
        self.cover.addGestureRecognizer(tapCover)
        
        // 右上用下拉菜单 手势
        let tapMore = UITapGestureRecognizer(target: self, action: #selector(tapMore(_:)))
        tapMore.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapMore)
        
//        self._searchBarBtn()
        searchBarBtn(view: self, navHeight: self.navHeight, placeholder: "按货品名称或编号搜索", action: #selector(actionSearch))
        self._setupTitlesView()
        self._moreView()
        
        // 创建表视图
        self.tableView = UITableView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight - self.navHeight - 90 - self.tabBarHeight), style:.grouped)
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        self.tableView?.register(UINib(nibName: "GoodTableViewCell", bundle: nil), forCellReuseIdentifier: CELL_IDENTIFY_ID)
        self.tableView?.tableFooterView = UIView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0.1))
        self.tableView?.tableHeaderView = UIView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0.1))
        dataView.addSubview(self.tableView!)
        
        // 下拉刷新相关设置
        header.setTitle("下拉可以刷新", for: .idle)
        header.setTitle("松开立即刷新", for: .pulling)
        header.setTitle("正在刷新数据...", for: .refreshing)
        header.lastUpdatedTimeLabel.text = "最后更新"
        header.setTitle("没有更多数据啦~", for: .noMoreData)
        header.setRefreshingTarget(self, refreshingAction: #selector(headerRefresh))
        self.tableView!.mj_header = header
        
        // 上拉刷新相关设置
        footer.setRefreshingTarget(self, refreshingAction: #selector(footerRefresh))
        self.tableView?.mj_footer = footer
        
        self.categoryTable = UITableView(frame: CGRect(x: 0, y: self.navHeight + 95, width: ScreenWidth, height: 0), style: UITableViewStyle.plain)
        self.categoryTable.delegate = self
        self.categoryTable.dataSource = self
        self.categoryTable.backgroundColor = Specs.color.white
        self.categoryTable.tableFooterView = UIView.init()
        self.categoryTable.backgroundColor = Specs.color.white
        self.categoryTable.register(UITableViewCell.self, forCellReuseIdentifier: "CategoryTableCell")
        self.categoryTable.tableHeaderView = UIView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0.1))
        self.view.addSubview(self.categoryTable)
        
        // add button
//        self._setAddBtn()
    }
    
    fileprivate func _setAddBtn() {
        print(self.tabBarHeight)
        let _addBtnView = UIView(frame: CGRect(x: 0, y: ScreenHeight - self.tabBarHeight - 50, width: ScreenWidth, height: 50))
        _addBtnView.backgroundColor = normalRGBA(r: 0, g: 0, b: 0, a: 0.4)
        self.view.addSubview(_addBtnView)
        let _btn = UIButton(frame: CGRect(x: 20, y: 10, width: ScreenWidth - 40, height: 30))
        _btn.layer.cornerRadius = Specs.border.radius
        _btn.layer.masksToBounds = true
        _btn.setTitle("货品入仓", for: .normal)
        _btn.titleLabel?.font = UIFont.systemFont(ofSize: Specs.fontSize.regular)
        _btn.setTitleColor(Specs.color.white, for: UIControlState())
        _btn.backgroundColor = Specs.color.main
        _btn.addTarget(self, action: #selector(actionAdd), for: .touchUpInside)
        _addBtnView.addSubview(_btn)
    }
    
//    lazy var categoryTable: UITableView = {
//        let _categoryTable = UITableView(frame: CGRect(x: 0, y: 122, width: ScreenWidth, height: 0), style: UITableViewStyle.plain)
//        _categoryTable.delegate = self
//        _categoryTable.dataSource = self
//        _categoryTable.backgroundColor = Specs.color.white
//        _categoryTable.tableFooterView = UIView.init()
//        _categoryTable.backgroundColor = Specs.color.white
//        _categoryTable.register(UITableViewCell.self, forCellReuseIdentifier: "CategoryTableCell")
//        _categoryTable.tableHeaderView = UIView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0.1))
//        return _categoryTable
//    }()
    
    private func showCategoryTable() {
        self.categoryBtn.tag = 1
        UIView.animate(withDuration: 0.25) {
            self.cover.isHidden = false
            if self.categoryArr.count < 7 {
                self.categoryTable.frame.size.height = CGFloat(self.categoryArr.count * 45)
            } else {
                self.categoryTable.frame.size.height = CGFloat(270)
            }
            self.tabBarController?.tabBar.isHidden = true
        }
    }
    
    private func hideCategoryTable() {
        self.categoryBtn.tag = 0
        UIView.animate(withDuration: 0.25) {
            self.cover.isHidden = true
            self.categoryTable.frame.size.height = CGFloat(0)
            self.tabBarController?.tabBar.isHidden = false
        }
    }
    // 方法
    @objc func tapCover(_ tapCover : UITapGestureRecognizer){
//        print("tapGesLocation\(tapCover.location(in: view))")
        self.hideCategoryTable()
        self.hiddenGoodListPopupView()
    }
    // 方法
    @objc func tapMore(_ tapMore : UITapGestureRecognizer){
//        print("tapGesLocation\(tapMore.location(in: view))")
        self.moreView.isHidden = true
        self.hiddenGoodListPopupView()
    }
    
    @objc func footerRefresh(){
        print("上拉刷新")
        sleep(1)
        //重现生成数据
        refreshItemData(append: true)
//        self.hiddenGoodListPopupView()
        self.tableView?.mj_footer.endRefreshing()
        // 2次后模拟没有更多数据
        if (self.dataArr.count > 15) {
            footer.endRefreshingWithNoMoreData()
        }
    }
    
    //顶部下拉刷新
    @objc func headerRefresh(){
        print("下拉刷新.")
        sleep(1)
        self.hiddenGoodListPopupView()
        //重现生成数据
        refreshItemData(append: false)
        
        // self.tableView?.mj_header.endRefreshing(.)
//        if (self.dataArr.count > 6) {
//            DispatchQueue.main.async {
//                // 主线程中
//                // self.tableView!.mj_header.state = MJrefreshno
//            }
//
//        }
        //重现加载表格数据
        self.tableView!.reloadData()
        //结束刷新
        self.tableView!.mj_header.endRefreshing()
    }
    
    //初始化数据
    func refreshItemData(append: Bool) {
        let count = self.dataArr.count
        let imagePaths = ["java","php","html","react","ruby","swift","xcode","bayMax","c#"]
        
        for i in 0...2 {
            let index = arc4random_uniform(UInt32(imagePaths.count))
            let _imagePath = imagePaths[Int(index)]
            let _data = ["avatar": _imagePath, "suk": "AB_PPC\(count + i)", "name": "六神花露水清新花香冰莲香型喷雾清凉防蚊", "price": "117.50", "stock": "121", "cost": "2150.00", "location": "广州白马1001", "status": "1"]
            if (append) {
                self.dataArr.append(_data)
            } else {
                self.dataArr.insert(_data, at: 0)
            }
        }
    }
    
    @objc func titleClick(_ sender: UIButton) {
        // 上一次点击的
        let _selectedButton: UIButton = self.view.viewWithTag(self.selectedButtonTag) as! UIButton
        _selectedButton.setImage(UIImage(named: "arrange1"), for: .normal)
        
        // 正在点击的
        let _button: UIButton = self.view.viewWithTag(sender.tag) as! UIButton
        _button.titleLabel?.sizeToFit()
        
        // 连续点击两次
        var named: String = "arrange3"
        if (self.selectedButtonTag! == sender.tag) {
            named = self.buttonClick % 2 == 0 ? "arrange2" : "arrange3"
            self.buttonClick += 1
        } else {
            self.buttonClick = 0
        }
        _button.setImage(UIImage(named: named), for: .normal)
        
        UIView.animate(withDuration: 0.25) {
            self.titleBottomView.frame.size.width = (_button.titleLabel?.frame.width)! + self.smallMargin
            self.titleBottomView.center.x = _button.center.x + self.titleButtonOffset
        }
        self.selectedButtonTag = sender.tag
        self.tableView!.mj_header.beginRefreshing()
    }
    
    @objc func showCategory() {
        if (self.categoryArr.count > 1) {
            if (self.categoryBtn.tag == 0) {
                self.showCategoryTable()
            }else{
                self.hideCategoryTable()
            }
        }
        else{
            if (self.categoryBtn.tag == 0) {
//                ShowHUBInController
//                [[FAFApi sharedInstance] getGoodsCate:^(id result) {
//                    HideHUBInController
//                    NSArray *dataArr = [result objectForKey:@"data"];
//                    for (int i=0; i<dataArr.count; i++) {
//                    GoodTypeModel *item = [GoodTypeModel yy_modelWithDictionary:[dataArr objectAtIndex:i]];
//                    [categoryArray addObject:item];
//                    }
//                    [self.categoryTable reloadData];
//                    [self showCategoryTable];
//                    } failure:^(NSString *message) {
//                    HideHUBInController
//                    ShowHUBInWindowAutoHid(message)
//                    }];
            }else{
                self.hideCategoryTable()
            }
        }
    }
    
    // 右上角下拉菜单
    func _moreView() {
        self.moreView = UIView(frame: CGRect(x: ScreenWidth - 120, y: self.navHeight, width: 110, height: 145))
        self.moreView.isHidden = true
        let imgBgTop = UIImageView(frame: CGRect(x: self.moreView.frame.size.width - 35, y: 0, width: 20, height: 10))
        imgBgTop.image = UIImage(named: "jump_list_bg_top")
        self.moreView.addSubview(imgBgTop)
//        self.moreView.addTarget(self, action:#selector(hideMoreMenu(_:)), for:.touchUpInside)
        
        let vBg = UIView(frame: CGRect(x: 2, y: imgBgTop.frame.size.height, width: self.moreView.frame.size.width, height: self.moreView.frame.size.height))
        vBg.backgroundColor = normalRGBA(r: 49, g: 58, b: 67, a: 1)
        vBg.layer.cornerRadius = 5.0
        vBg.layer.masksToBounds = true
        self.moreView.addSubview(vBg)
        
        
        let moreArr = ["分组管理", "规格管理", "批量管理"]
        let _moreArrCount = moreArr.count
        if _moreArrCount > 0 {
            for index in 0..<_moreArrCount {
                let _moreBtn = UIButton(frame: CGRect(x: 0, y: 45 * index + 10, width: Int(self.moreView.frame.size.width), height: 45))
                _moreBtn.setTitle(moreArr[index], for: .normal)
                _moreBtn.setTitleColor(Specs.color.white, for: .normal)
                let _tag = index
                _moreBtn.tag = _tag
                _moreBtn.addTarget(self, action: #selector(actionMoreItem(_:)), for: .touchUpInside)
                _moreBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
                self.moreView.addSubview(_moreBtn)
                
                let _height = _moreBtn.frame.origin.y
//                print((_height + 5) * CGFloat(index + 1))
                // 分割线
                if index < _moreArrCount - 1 {
                    let _sigline = UIImageView(frame: CGRect(x: 0, y: (_height + 40), width: _moreBtn.frame.size.width, height: 11))
                    _sigline.image = UIImage(named: "line1")
                    self.moreView.addSubview(_sigline)
                }
            }
        }
        self.view.addSubview(self.moreView)
    }
    
    func _setupTitlesView() {
        let titlesView = UIView(frame: CGRect(x: 0, y: self.navHeight + 50, width: ScreenWidth, height: 45))
        titlesView.backgroundColor = Specs.color.white
        self.view.addSubview(titlesView)
        
        // 标签栏内部的标签按钮
        let count: Int = titlesArr.count
        let titleButtonH = titlesView.frame.height
        let titleButtonW = titlesView.frame.width * 0.80
        
        for index in 0..<count {
            // 创建
            let titleButton = UIButton()
            titleButton.addTarget(self, action: #selector(titleClick(_:)), for: .touchUpInside)
            self.titleButton = titleButton
            let _tag = 2000 + index
            titleButton.tag = _tag
            titleButton.setTitleColor(normalRGBA(r: 114, g: 114, b: 114, a: 1.0), for: .normal)
            titlesView.addSubview(titleButton)
            self.buttonTags.append(_tag)
            
            // 文字
            let title: String = titlesArr[index]
            titleButton.titleLabel?.font = UIFont.systemFont(ofSize: Specs.fontSize.regular)
            titleButton.titleLabel?.textAlignment = .center
            titleButton.set(image: UIImage(named: "arrange1"), title: title + "", titlePosition: .left, additionalSpacing: 10.0, state: .normal)
            
            // frame
            if (index == 0) {
                titleButton.frame = CGRect(x: 0, y: 0, width: titleButtonW * 0.31, height: titleButtonH)
            }else{
                let _titleButtonW = CGFloat(index - 1) * (titleButtonW)
                titleButton.frame = CGRect(x: (titleButtonW * 0.31 + _titleButtonW * 0.23), y: 0.0, width: titleButtonW * 0.23, height: titleButtonH)
            }
        }
        
        let lineLabel: UILabel = UILabel(frame: CGRect(x: titleButtonW, y: 15, width: 1, height: 20))
        lineLabel.backgroundColor = normalRGBA(r: 247, g: 247, b: 247, a: 1.0)
        titlesView.addSubview(lineLabel)

        self.categoryBtn = UIButton(frame: CGRect(x: titleButtonW, y: 0, width: titlesView.frame.width * 0.2, height: 45))
        self.categoryBtn.set(image: UIImage(named: "goodsmanage_list"), title: "分类 ", titlePosition: .left, additionalSpacing: -15.0, state: .normal)
        self.categoryBtn.titleLabel?.font = UIFont.systemFont(ofSize: Specs.fontSize.regular)
        self.categoryBtn.setTitleColor(normalRGBA(r: 114, g: 114, b: 114, a: 1.0), for: .normal)
        self.categoryBtn.addTarget(self, action: #selector(showCategory), for: .touchUpInside)
        titlesView.addSubview(self.categoryBtn)

        // 底部的线
        let lineView: UIView = UIView()
        let lineViewH: CGFloat = 1
        lineView.frame = CGRect(x: 0, y: titlesView.frame.height - lineViewH, width: ScreenWidth, height: lineViewH)
        lineView.backgroundColor = normalRGBA(r: 194, g: 194, b: 194, a: 0.8)
        titlesView.addSubview(lineView)

        // 标签栏底部的指示器控件
        let titleBottomView: UIView = UIView()
        titleBottomView.backgroundColor = normalRGBA(r: 226, g: 80, b: 44, a: 1.0)
        titleBottomView.frame.size.height = 2
        titleBottomView.frame.origin.y = titlesView.frame.height - titleBottomView.frame.height
        titlesView.addSubview(titleBottomView)
        self.titleBottomView = titleBottomView

        // 默认点击最前面的按钮
        let _currTag: Int = self.buttonTags.first!
        self.selectedButtonTag = _currTag
        let firstTitleButton: UIButton = self.view.viewWithTag(_currTag) as! UIButton
        firstTitleButton.titleLabel?.sizeToFit()
        firstTitleButton.setImage(UIImage(named: "arrange3"), for: .normal)
        titleBottomView.frame.size.width = (firstTitleButton.titleLabel?.frame.width)! + self.smallMargin
        titleBottomView.center.x = firstTitleButton.center.x + self.titleButtonOffset
    }
//
//    func _searchBarBtn() {
//        let frame = self.view.frame.size
//        let buttonView = UIView(frame: CGRect(x: 0, y: self.navHeight!, width: frame.width, height: 50))
//        buttonView.backgroundColor = UIColor(hex: 0xefeef4)
//        self.view.addSubview(buttonView)
//
//        let button = UIButton(frame: CGRect(x: 10, y: 10, width: frame.width - 20, height: 30))
//        button.setTitle(self._placeholder, for: UIControlState())
//        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
//        button.setTitleColor(UIColor(hex: 0x8e8e93), for: UIControlState())
//        button.backgroundColor = Specs.color.white
//        button.layer.borderWidth = 0;
//        button.layer.borderColor = UIColor(hex: 0xf5f5f5).cgColor
//        button.layer.cornerRadius = Specs.border.radius
//        button.layer.masksToBounds = true
//        button.addTarget(self, action: #selector(goSearch), for: .touchUpInside)
//        buttonView.addSubview(button)
//    }
    
    private func hiddenGoodListPopupView() {
        if (self.goodListPopupView != nil){
            // self.goodListPopupView.removeFromParentViewController()
            self.goodListPopupView.removeFromSuperview()
            self.goodListPopupView = nil
        }
    }
    
    @objc func clickedMoreBtn(_ sender: UIButton) {
        print("sender.tag:\(sender.tag)")
        self.hiddenGoodListPopupView()
        self.goodListPopupView = UIView(frame: CGRect(x: 0, y: 40, width: 0, height: 50))
        self.goodListPopupView.tag = sender.tag
        
        let count = self.dataArr.count
        let sectionNo = count - sender.tag - 1
        
        self.goodListPopupViewController = GoodListPopupViewController()
        self.goodListPopupViewController.frame_width = self.frame_width
        
        let _data = dataArr[sectionNo]
        self.goodListPopupViewController.good_status = _data["status"]
        
//        let cell = sender.superView(of: GoodTableViewCell.self)!
//        cell.addSubview(goodListPopupView)
//        let indexPath = self.tableView.indexPath(for: cell)
        
        let _indexPath: IndexPath = IndexPath(row: sender.tag, section: 0)
        let _cell: GoodTableViewCell = self.tableView.cellForRow(at: _indexPath as IndexPath) as! GoodTableViewCell
        _cell.addSubview(self.goodListPopupView)
        self.goodListPopupView.addSubview(self.goodListPopupViewController.view)
        
        self.goodListPopupView.frame.size.width = self.goodListPopupViewController.popupViewWidth
        self.goodListPopupView.frame.origin.x = sender.frame.origin.x - self.goodListPopupViewController.popupViewWidth
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

extension GoodViewController: UITableViewDataSource ,UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rows = 0;
        if tableView.isEqual(self.tableView) {
            rows = self.dataArr.count
        } else if tableView.isEqual(self.categoryTable) {
            rows = self.categoryArr.count
        }
        return rows
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 105
    }
    
    //设置分组尾的高度
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView.isEqual(self.tableView) {
//            let count = self.dataArr.count
//            let sectionNo = count - indexPath.row - 1

            let cell: GoodTableViewCell = tableView.dequeueReusableCell(withIdentifier: CELL_IDENTIFY_ID, for: indexPath) as! GoodTableViewCell
            
            let _data = dataArr[indexPath.item]
                
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
            cell.price.text = "售价:" + _data["price"]! + "元/包"
            cell.price.sizeToFit()
            cell.cost.text = "成本:" + _data["price"]! + "元/包"
            cell.cost.sizeToFit()
            cell.accessoryType = .disclosureIndicator

            cell.tag = indexPath.row
            cell.moreBtn.tag = indexPath.row
            cell.moreBtn.addTarget(self, action: #selector(clickedMoreBtn(_:)), for: .touchUpInside)
            return cell
        } else if tableView.isEqual(self.categoryTable) {
            let count = self.categoryArr.count
            let sectionNo = count - indexPath.row - 1
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableCell", for: indexPath) as UITableViewCell
            
            if !(self.categoryArr[sectionNo].isEmpty) {
                let _data = self.categoryArr[sectionNo]
                cell.textLabel?.text = _data
                cell.textLabel?.font = Specs.font.regular
                cell.textLabel?.textColor = normalRGBA(r: 114, g: 114, b: 114, a: 1.0)
                cell.accessoryType = .checkmark
            }
            return cell
        }
        return UITableViewCell()
    }
    
    // UITableViewDelegate 方法，处理列表项的选中事件
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if tableView.isEqual(self.tableView) {
            let _target = GoodDetailViewController()
            _target.valueArr = [
                "sn": "ZHG20180908142345098",
                "title": "京造 芝麻核桃黑豆粉代餐粉 黑芝麻蔓越莓枸杞粉 早餐禅食代餐22g*20 440g",
                "warehouse": "深圳仓库",
                "price": "80000.88",
                "total": "987452.00",
                "quantity": "12",
                "stock": "5600",
            ]
            
            _push(view: self, target: _target, rootView: true)
        } else if tableView.isEqual(self.categoryTable) {
            self.hideCategoryTable()
        }
    }
}
