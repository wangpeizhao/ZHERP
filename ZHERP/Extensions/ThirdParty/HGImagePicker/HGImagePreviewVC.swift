//
//  HGImagePreviewVC.swift
//  hangge_1513
//
//  Created by hangge on 2017/1/11.
//  Copyright © 2017年 hangge.com. All rights reserved.
//

import UIKit

//图片浏览控制器
class HGImagePreviewVC: UIViewController {
    
    //存储图片数组
    var images:[UIImage]
    //存储图片数组URL
    var imagesURL:[String]
    
    //默认显示的图片索引
    var index:Int
    
    //用来放置各个图片单元
    var collectionView:UICollectionView!
    
    //collectionView的布局
    var collectionViewLayout: UICollectionViewFlowLayout!
    
    //页控制器（小圆点）
    var pageControl : UIPageControl!
    
    var navHeight: CGFloat!
    var statusbarHeight: CGFloat!
    
    //初始化
    init(images:[UIImage], imagesURL:[String], index:Int = 0){
        self.images = images
        self.imagesURL = imagesURL
        self.index = index
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //初始化
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navHeight = self.navigationController?.navigationBar.frame.size.height
        self.statusbarHeight = UIApplication.shared.statusBarFrame.height
        //背景设为黑色
        self.view.backgroundColor = UIColor.black
//        setNavBarTitle(view: self, title: "", transparent: true)
        
//        self.navigationController?.navigationBar.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: 104)
//        self.navigationController?.navigationBar.frame.origin.y = 104
        self.navigationController?.navigationBar.isTranslucent = true
//        self.navigationController?.navigationBar.barTintColor = UIColor.black
//        self.navigationController?.navigationBar.backgroundColor = UIColor.black
//        self.navigationController?.navigationBar.alpha = 0.3
        
        //collectionView尺寸样式设置
        collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.minimumLineSpacing = 0
        collectionViewLayout.minimumInteritemSpacing = 0
        //横向滚动
        collectionViewLayout.scrollDirection = .horizontal
        
        //collectionView初始化
        collectionView = UICollectionView(frame: self.view.bounds,
                                          collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = UIColor.black
        collectionView.register(HGImagePreviewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        //不自动调整内边距，确保全屏
        if #available(iOS 11.0, *) {
            collectionView.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        self.view.addSubview(collectionView)
        
        //将视图滚动到默认图片上
        let indexPath = IndexPath(item: index, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
        
        //设置页控制器
        pageControl = UIPageControl()
        pageControl.center = CGPoint(x: UIScreen.main.bounds.width/2,
                                     y: UIScreen.main.bounds.height - 20)
        pageControl.numberOfPages = self.imagesURL.count > 0 ? self.imagesURL.count : self.images.count
        pageControl.isUserInteractionEnabled = false
        pageControl.currentPage = index
        view.addSubview(self.pageControl)
    }
    
    //视图显示时
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //隐藏导航栏
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
 
    //视图消失时
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        print("viewWillDisappearviewWillDisappear")
        //显示导航栏
        self.navigationController?.setNavigationBarHidden(false, animated: false)
//        self.navigationController?.navigationBar.frame = CGRect(x: 0, y: self.statusbarHeight, width: ScreenWidth, height: self.navHeight)
        self.navigationController?.navigationBar.barTintColor = Specs.color.main
    }
    
    //隐藏状态栏
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    //将要对子视图布局时调用（横竖屏切换时）
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        //重新设置collectionView的尺寸
        collectionView.frame.size = self.view.bounds.size
        collectionView.collectionViewLayout.invalidateLayout()
        
        //将视图滚动到当前图片上
        let indexPath = IndexPath(item: self.pageControl.currentPage, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
        
        //重新设置页控制器的位置
        pageControl.center = CGPoint(x: UIScreen.main.bounds.width/2,
                                     y: UIScreen.main.bounds.height - 20)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

//HGImagePreviewVC的CollectionView相关协议方法实现
extension HGImagePreviewVC:UICollectionViewDelegate, UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout{
    
    //collectionView单元格创建
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath)
        -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell",  for: indexPath) as! HGImagePreviewCell
//        let image = UIImage(named: self.images[indexPath.row])
//        cell.imageView.image = image
        if self.imagesURL.count > 0 {
            cell.imageView.imageFromURL(self.imagesURL[indexPath.row], placeholder: UIImage(), fadeIn: true, shouldCacheImage: true) { (image: UIImage?) in
                if image != nil {
//                    print("图片加载成功!")
                }
            }
        } else {
            cell.imageView.image = self.images[indexPath.row]
        }
        return cell
    }
    
    //collectionView单元格数量
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return self.imagesURL.count > 0 ? self.imagesURL.count : self.images.count
    }
    
    //collectionView单元格尺寸
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.view.bounds.size
    }
    
    //collectionView里某个cell将要显示
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        if let cell = cell as? HGImagePreviewCell{
            //由于单元格是复用的，所以要重置内部元素尺寸
            cell.resetSize()
        }
    }
    
    //collectionView里某个cell显示完毕
    func collectionView(_ collectionView: UICollectionView,
                        didEndDisplaying cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        //当前显示的单元格
        let visibleCell = collectionView.visibleCells[0]
        //设置页控制器当前页
        self.pageControl.currentPage = collectionView.indexPath(for: visibleCell)!.item
    }
}


