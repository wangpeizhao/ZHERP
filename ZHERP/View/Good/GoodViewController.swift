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
    var tableView: UITableView!
    let CELL_IDENTIFY_ID = "CELL_IDENTIFY_ID"
    
    var titleButton: UIButton!
    // 顶部刷新
    let header = MJRefreshNormalHeader()
    // 底部刷新
    let footer = MJRefreshAutoNormalFooter()
    
    var itemArray : [Int: [String:String]] = [
        0: ["avatar": "bayMax", "suk": "AB_PPC01", "name": "六神花露水001", "price": "117.50", "stock": "121", "cost": "2150.00", "location": "广州白马1001"],
        1: ["avatar": "c#", "suk": "BC_PPC02", "name": "六神花露水002", "price": "217.50", "stock": "122", "cost": "2250.00", "location": "广州白马1234"],
        2: ["avatar": "html", "suk": "CD_PPC03", "name": "六神花露水003", "price": "317.50", "stock": "123", "cost": "2350.00", "location": "广州白马3434"],
        3: ["avatar": "java", "suk": "DE_PPC04", "name": "六神花露水004", "price": "417.50", "stock": "124", "cost": "2450.00", "location": "广州白马4556"],
        4: ["avatar": "js", "suk": "EF_PPC05", "name": "六神花露水005", "price": "517.50", "stock": "125", "cost": "2550.00", "location": "广州白马6787"],
        5: ["avatar": "php", "suk": "FG_PPC06", "name": "六神花露水006", "price": "617.50", "stock": "126", "cost": "2650.00", "location": "广州白马7856"],
        6: ["avatar": "react", "suk": "GH_PPC07", "name": "六神花露水007", "price": "717.50", "stock": "127", "cost": "2570.00", "location": "广州白马4533"],
        7: ["avatar": "ruby", "suk": "HI_PPC08", "name": "六神花露水008", "price": "817.50", "stock": "128", "cost": "2850.00", "location": "广州白马2131"],
        8: ["avatar": "swift", "suk": "IJ_PPC09", "name": "六神花露水009", "price": "917.50", "stock": "129", "cost": "2590.00", "location": "广州白马2233"],
        9: ["avatar": "xcode", "suk": "JK_PPC10", "name": "六神花露水010", "price": "107.50", "stock": "120", "cost": "2500.00", "location": "广州白马3223"],
        10: ["avatar": "bayMax", "suk": "KL_PPC11", "name": "六神花露水011", "price": "1700.50", "stock": "1200", "cost": "2590.00", "location": "广州白马2345"]
    ]
    
    let titlesArr = ["上架时间", "价格", "库存", "销量"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = Specs.color.white
        setNavBarTitle(view: self, title: self._title)
        setNavBarBackBtn(view: self, title: self._title, selector: #selector(actionBack))
        
        self._setup()
        // Do any additional setup after loading the view.
    }
    
    @objc func actionBack() {
        
    }
    
    private func _setup() {
        self.navHeight = self.navigationController?.navigationBar.frame.maxY
        
        self._searchBarBtn()
        self._setupTitlesView()
        
        let dataView = UIView(frame: CGRect(x: 0, y: self.navHeight + 95, width: ScreenWidth, height: ScreenHeight))
        self.view.addSubview(dataView)
        
        // 创建表视图
        self.tableView = UITableView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight - self.navHeight - 38), style:.grouped)
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
    }
    
    @objc func footerRefresh(){
        print("上拉刷新")
        self.tableView?.mj_footer.endRefreshing()
        // 2次后模拟没有更多数据
        if (self.itemArray.count > 10) {
            footer.endRefreshingWithNoMoreData()
        }
    }
    
    //顶部下拉刷新
    @objc func headerRefresh(){
        print("下拉刷新.")
        sleep(1)
        //重现生成数据
        refreshItemData()
        
        // self.tableView?.mj_header.endRefreshing(.)
        if (self.itemArray.count > 6) {
            DispatchQueue.main.async {
                // 主线程中
                // self.tableView!.mj_header.state = MJrefreshno
            }
            
        }
        //重现加载表格数据
        self.tableView!.reloadData()
        //结束刷新
        self.tableView!.mj_header.endRefreshing()
    }
    
    //初始化数据
    func refreshItemData() {
        let count = self.itemArray.count
        for i in 0...2 {
            print(i)
            self.itemArray[count + i] = ["avatar": "c#", "suk": "AB_PPC\(count + i)", "name": "六神花露水001", "price": "117.50", "stock": "121", "cost": "2150.00", "location": "广州白马1001"]
        }
    }
    
//    - (void)setupTitlesView
//    {
//    // topView
//    UIView *topView = [[UIView alloc]init];
//    topView.frame = CGRectMake(0,0, SCREENWIDTH, TopViewH);
//    topView.backgroundColor = ViewBackgroundColor;
//    [self.view addSubview:topView];
//    self.topView = topView;
//
//    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH , 50)];
//    [topView addSubview:searchBar];
//    searchBar.delegate = self;
//    searchBar.backgroundColor = Color(245, 245, 245, 1);
//    [[[searchBar.subviews objectAtIndex:0].subviews objectAtIndex:0]removeFromSuperview];
//
//    searchBar.placeholder =  @"搜索商品名称/货号";
//
//    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    searchBtn.frame = CGRectMake(0, 0, SCREENWIDTH , 50);
//    [searchBtn addTarget:self action:@selector(didClickSearchBtn) forControlEvents:UIControlEventTouchUpInside];
//    [topView addSubview:searchBtn];
//
//
//    // titlesView
//    UIView *titlesView = [[UIView alloc] init];
//    titlesView.backgroundColor = [UIColor whiteColor];
//    titlesView.frame = CGRectMake(0, 50, SCREENWIDTH, TitlesViewH);
//    [topView addSubview:titlesView];
//
//
//
//    self.titlesView = titlesView;
//
//    // 标签栏内部的标签按钮
//    NSInteger count = titlesArr.count;
//    CGFloat titleButtonH = titlesView.height;
//    CGFloat titleButtonW = (titlesView.width*0.75);
//
//    for (int i = 0; i < count; i++) {
//    // 创建
//    TitleButton *titleButton = [TitleButton buttonWithType:UIButtonTypeCustom];
//    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
//    self.titleButton = titleButton;
//    titleButton.tag = 2000+i;
//    [titleButton setTitleColor:Color(226, 80, 44, 1) forState:UIControlStateSelected];
//    [titlesView addSubview:titleButton];
//    [self.titleButtons addObject:titleButton];
//
//    // 文字
//    NSString *title = [titlesArr objectAtIndex:i];
//    [titleButton setTitle:title forState:UIControlStateNormal];
//    [titleButton setImage:[UIImage imageNamed:@"arrange1"] forState:UIControlStateNormal];
//
//    // frame
//    if (i==0) {
//    titleButton.frame = CGRectMake(0, 0, titleButtonW*0.31, titleButtonH);
//    }
//    else{
//    titleButton.frame = CGRectMake(titleButtonW*0.31+(i-1)*titleButtonW*0.23, 0, titleButtonW*0.23, titleButtonH);
//    }
//    }
//
//    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleButtonW, 15, 1, 20)];
//    lineLabel.backgroundColor = ViewBackgroundColor;
//    [titlesView addSubview:lineLabel];
//
//    categoryBtn = [TitleButton buttonWithType:UIButtonTypeCustom];
//    categoryBtn.frame = CGRectMake(titleButtonW, 0, titlesView.width*0.25, TitlesViewH);
//    [categoryBtn setTitle:@"分类" forState:UIControlStateNormal];
//    [categoryBtn setImage:[UIImage imageNamed:@"goodsmanage_list"] forState:UIControlStateNormal];
//    [categoryBtn setTitleColor:Color(226, 80, 44, 1) forState:UIControlStateSelected];
//    [categoryBtn addTarget:self action:@selector(showCategory:) forControlEvents:UIControlEventTouchUpInside];
//    [titlesView addSubview:categoryBtn];
//
//    // 底部的线
//    UIView *lineView = [[UIView alloc] init];
//    CGFloat lineViewH = 1;
//    lineView.frame = CGRectMake(0, titlesView.height - lineViewH, SCREENWIDTH, lineViewH);
//    lineView.backgroundColor = Color(194, 194, 194, 0.8);
//    self.lineView = lineView;
//    [titlesView addSubview:lineView];
//
//    // 标签栏底部的指示器控件
//    UIView *titleBottomView = [[UIView alloc] init];
//    titleBottomView.backgroundColor = Color(226, 80, 44, 1);
//    titleBottomView.height = 2;
//    titleBottomView.y = titlesView.height - titleBottomView.height;
//    [titlesView addSubview:titleBottomView];
//    self.titleBottomView = titleBottomView;
//
//    // 默认点击最前面的按钮
//    TitleButton *firstTitleButton = self.titleButtons.firstObject;
//    [firstTitleButton.titleLabel sizeToFit];
//    titleBottomView.width = firstTitleButton.titleLabel.width + SmallMargin;
//    titleBottomView.centerX = firstTitleButton.centerX;
//    [self titleClick:firstTitleButton];
//    _buttonTag = 2000;
//    }
    
    @objc func titleClick() {
        self.tableView!.mj_header.beginRefreshing()
    }
    
    @objc func showCategory() {
        
    }
    
    func _setupTitlesView() {
        let titlesView = UIView(frame: CGRect(x: 0, y: self.navHeight + 50, width: ScreenWidth, height: 45))
        titlesView.backgroundColor = Specs.color.white
        self.view.addSubview(titlesView)
        
        // 标签栏内部的标签按钮
        let count: Int = titlesArr.count
        let titleButtonH = titlesView.frame.height
        let titleButtonW = titlesView.frame.width * 0.75
        
        for index in 0..<count {
            // 创建
            let titleButton = UIButton()
            titleButton.addTarget(self, action: #selector(titleClick), for: .touchUpInside)
            self.titleButton = titleButton
            titleButton.tag = 2000 + index
            titleButton.setTitleColor(normalRGBA(r: 226, g: 80, b: 44, a: 1.0), for: .normal)
            
            // 文字
            let title: String = titlesArr[index]
            titleButton.titleLabel?.font = UIFont.systemFont(ofSize: Specs.fontSize.regular)
            titleButton.setTitle(title, for: .normal)
            titleButton.setImage(UIImage(named: "arrange1"), for: .normal)
            
            // frame
            if (index == 0) {
                titleButton.frame = CGRect(x: 0, y: 0, width: titleButtonW * 0.31, height: titleButtonH)
            }else{
                let _titleButtonW = CGFloat(index - 1) * (titleButtonW)
                titleButton.frame = CGRect(x: (titleButtonW * 0.31 + _titleButtonW * 0.23), y: 0.0, width: titleButtonW * 0.23, height: titleButtonH)
            }
            titlesView.addSubview(titleButton)
        }
        
        let lineLabel: UILabel = UILabel(frame: CGRect(x: titleButtonW, y: 15, width: 1, height: 20))
        lineLabel.backgroundColor = normalRGBA(r: 247, g: 247, b: 247, a: 1.0)
        titlesView.addSubview(lineLabel)
//
        let categoryBtn = UIButton()
        categoryBtn.frame = CGRect(x: titleButtonW, y: 0, width: titlesView.frame.width * 0.25, height: 45)
        categoryBtn.setTitle("分类", for: .normal)
        categoryBtn.titleLabel?.font = UIFont.systemFont(ofSize: Specs.fontSize.regular)
        categoryBtn.setImage(UIImage(named: "goodsmanage_list"), for: .normal)
        categoryBtn.setTitleColor(normalRGBA(r: 226, g: 80, b: 44, a: 1.0), for: .normal)
        categoryBtn.addTarget(self, action: #selector(showCategory), for: .touchUpInside)
        titlesView.addSubview(categoryBtn)
//
        // 底部的线
        let lineView: UIView = UIView()
        let lineViewH: CGFloat = 1
        lineView.frame = CGRect(x: 0, y: titlesView.frame.height - lineViewH, width: ScreenWidth, height: lineViewH)
        lineView.backgroundColor = normalRGBA(r: 194, g: 194, b: 194, a: 0.8)
        titlesView.addSubview(lineView)
//
        // 标签栏底部的指示器控件
        let titleBottomView: UIView = UIView()
        titleBottomView.backgroundColor = normalRGBA(r: 226, g: 80, b: 44, a: 1.0)
        titleBottomView.frame.size.height = 2
        titleBottomView.frame.origin.y = titlesView.frame.height - titleBottomView.frame.height
        titlesView.addSubview(titleBottomView)
//        self.titleBottomView = titleBottomView;
//
//        // 默认点击最前面的按钮
//        TitleButton *firstTitleButton = self.titleButtons.firstObject;
//        [firstTitleButton.titleLabel sizeToFit];
//        titleBottomView.width = firstTitleButton.titleLabel.width + SmallMargin;
//        titleBottomView.centerX = firstTitleButton.centerX;
//        [self titleClick:firstTitleButton];
//        _buttonTag = 2000;

    }
    
    func _searchBarBtn() {
//        print("self.navHeight:\(self.navHeight!)")
        let frame = self.view.frame.size
        let buttonView = UIView(frame: CGRect(x: 0, y: self.navHeight!, width: frame.width, height: 50))
        buttonView.backgroundColor = UIColor(hex: 0xefeef4)
        self.view.addSubview(buttonView)
        
        let button = UIButton(frame: CGRect(x: 10, y: 7, width: frame.width - 20, height: 36))
        button.setTitle(self._placeholder, for: UIControlState())
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.setTitleColor(UIColor(hex: 0x939395), for: UIControlState())
        button.backgroundColor = Specs.color.white
        button.layer.borderWidth = 1;
        button.layer.borderColor = UIColor(hex: 0xd7d7d7).cgColor
        button.layer.cornerRadius = Specs.border.radius
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(goSearch), for: .touchUpInside)
        buttonView.addSubview(button)
    }
    
    @objc func goSearch() {
        let _view = SearchViewController()
        _view.navBarTitle = self._title
        _view.searchBarPlaceholder = self._placeholder
        _view.searchType = "good"
        _push(view: self, target: _view)
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
        return self.itemArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    //设置分组尾的高度
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let count = self.itemArray.count
        let sectionNo = count - indexPath.row - 1

        let cell: GoodTableViewCell = tableView.dequeueReusableCell(withIdentifier: CELL_IDENTIFY_ID) as! GoodTableViewCell
        if !(self.itemArray[sectionNo]?.isEmpty)! {
            var _data = self.itemArray[sectionNo]!
            
            cell.avatar.image = UIImage(named: _data["avatar"]!)
            cell.suk.text = _data["suk"]
            cell.name.text = _data["name"]
            cell.stock.text = _data["stock"]
            cell.stock.text = _data["cost"]
            cell.stock.text = _data["location"]
            cell.stock.text = _data["price"]
            cell.accessoryType = .disclosureIndicator
        }
        return cell
    }
    
    // UITableViewDelegate 方法，处理列表项的选中事件
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let sb = UIStoryboard(name:"Main", bundle: nil)
        let orderView = sb.instantiateViewController(withIdentifier: "GoodDetailViewController") as! GoodDetailViewController

        let count = self.itemArray.count
        let sectionNo = count - indexPath.row - 1
        var _data = self.itemArray[sectionNo]!
//        orderView.hidesBottomBarWhenPushed = true
        
//        orderView.navTitle = _data["suk"]
//        orderView.order_image = _data["avatar"]
//        orderView.order_price = _data["price"]
//        orderView.order_title = _data["name"]
//        orderView.actionValue = ""
        
        _push(view: self, target: orderView, rootView: true)
    }
}
