//
//  IntroductionViewController.swift
//  ZHERP
//
//  Created by MrParker on 2018/7/22.
//  Copyright © 2018 MrParker. All rights reserved.
//

import UIKit

class IntroductionViewController: UIPageViewController, UIScrollViewDelegate{
    //页面数量
    var numOfPages = 5
    var imageArray:[String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let frame = self.view.bounds
        //scrollView的初始化
        let scrollView = UIScrollView()
        scrollView.frame = self.view.bounds
        scrollView.delegate = self
        //为了能让内容横向滚动，设置横向内容宽度为3个页面的宽度总和
        scrollView.contentSize = CGSize(width:frame.size.width * CGFloat(numOfPages), height:frame.size.height)
        //        print("\(frame.size.width*CGFloat(numOfPages)),\(frame.size.height)")
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.scrollsToTop = false
        
        let size = UIScreen.main.bounds.size
        imageArray = ["adImage4.gif","guideImage5.jpg","guideImage7.gif","guideImage3.jpg", "shopping.gif"]
        for i in 0..<numOfPages{
//            let imgfile = "guideImage\(Int(i) + 1).jpg"
            
//            let imgfile = imageArray[i]
//            let image = UIImage(named:"\(imgfile)")
//            let imgView = UIImageView(image: image)
//            imgView.frame = CGRect(x:frame.size.width*CGFloat(i), y:CGFloat(0), width:frame.size.width, height:frame.size.height)
//            scrollView.addSubview(imgView)

            
            let name = imageArray[i]
            let imageFrame = CGRect.init(x: size.width * CGFloat(i), y: 0.0, width: size.width, height: size.height)
            let filePath = Bundle.main.path(forResource: name, ofType: nil)
            let data: Data? = try? Data.init(contentsOf: URL.init(fileURLWithPath: filePath!), options: Data.ReadingOptions.uncached)
            var view: UIView
            let type = GifImageOperation.checkDataType(data: data)
            if type == DataType.gif{
                view = GifImageOperation.init(frame: imageFrame, gifData: data!)
            } else {
                // Warning: 假如说图片是放在Assets中的，使用Bundle的方式加载不到，需要使用init(named:)方法加载。
                view = UIImageView.init(frame: imageFrame)
                view.contentMode = .scaleAspectFill
                (view as! UIImageView).image = (data != nil ? UIImage.init(data: data!) : UIImage.init(named: name))
            }
            scrollView.addSubview(view)
            
        }
        scrollView.contentOffset = CGPoint.zero
        self.view.addSubview(scrollView)
        
        
        skipButton.frame = CGRect.init(x: size.width - 70.0, y: 40.0, width: 50.0, height: 24.0)
        self.view.addSubview(skipButton)
        
        self.view.addSubview(pageControl)
        self.view.addSubview(loginButton)
        // Do any additional setup after loading the view.
    }
    
    
    private lazy var skipButton: UIButton = {
        let button = UIButton.init(type: .custom)
        button.setTitle("跳过", for: .normal)
        button.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
        button.layer.cornerRadius = 5.0
        button.layer.masksToBounds = true
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.sizeToFit()
        button.addTarget(self, action: #selector(skipButtonClicked), for: .touchUpInside)
        return button
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect.init(x: view.center.x - 60, y: UIScreen.main.bounds.size.height - 120, width: 120, height: 30)
        button.setTitle("立即体验", for:.normal )
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setTitleColor(UIColor.green, for: .normal)
        button.isHidden = true
        button.backgroundColor = Specs.color.white
        button.layer.cornerRadius = Specs.border.radius
        button.addTarget(self, action: #selector(loginButtonClick), for: .touchUpInside)
        return button
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl(frame: CGRect.init(x: view.center.x - 60, y: UIScreen.main.bounds.size.height - 80, width: 120, height: 20))
        pageControl.numberOfPages = (self.imageArray.count)
        pageControl.currentPage = 0
        pageControl.hidesForSinglePage = true
        pageControl.currentPageIndicatorTintColor = UIColor.green
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        return pageControl
    }()
    
    //scrollview滚动的时候就会调用
    func scrollViewDidScroll(_ scrollView: UIScrollView){
        // print("scrolled:\(scrollView.contentOffset)")
        
        let page: Int = Int(scrollView.contentOffset.x / scrollView.bounds.size.width)
        // 设置指示器
        pageControl.currentPage = page
        print("\(page) = \(numOfPages)")
        if page == numOfPages - 1 {
            loginButton.isHidden = false
        }
        
        let twidth = CGFloat(numOfPages-1) * self.view.bounds.size.width
        //如果在最后一个页面继续滑动的话就会跳转到主页面
        if(scrollView.contentOffset.x > twidth){
            openMain()
//            _open(view: self, vcName: "login")
        }
    }
    
    //MARK: private
    @objc private func skipButtonClicked(){
        openMain()
//        _open(view: self, vcName: "home")
    }
    
    @objc private func loginButtonClick(){
        openMain()
//        _open(view: self, vcName: "login")
    }
    
    func openMain() {
        let mainStoryboard = UIStoryboard(name:"Main", bundle:nil)
        let viewController = mainStoryboard.instantiateInitialViewController()
        self.present(viewController!, animated: true, completion:nil)
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
