//
//  GoodViewController.swift
//  ZHERP
//
//  Created by MrParker on 2018/7/29.
//  Copyright © 2018 MrParker. All rights reserved.
//

import UIKit

class GoodViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = Specs.color.white
        setNavBarTitle(view: self, title: "货品管理")
        setNavBarBackBtn(view: self, title: "", selector: #selector(goSearch))
        
        searchBarBtn()
        // Do any additional setup after loading the view.
    }
    
    func searchBarBtn() {
        let frame = self.view.frame.size
        let navHeight = self.navigationController?.navigationBar.frame.maxY
        let buttonView = UIView(frame: CGRect(x: 0, y: navHeight!, width: frame.width, height: 50))
        buttonView.backgroundColor = UIColor(hex: 0xefeef4)
        self.view.addSubview(buttonView)
        
        let button = UIButton(frame: CGRect(x: 10, y: 10, width: frame.width - 20, height: 30))
        button.setTitle("搜索商品名称/货号", for: UIControlState())
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
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
        _push(view: self, target: SearchViewController())
//        _open(view: self, vcName: "search", withNav: false)
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
