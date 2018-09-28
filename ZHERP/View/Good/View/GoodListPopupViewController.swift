//
//  GoodListPopupViewController.swift
//  ZHERP
//
//  Created by MrParker on 2018/8/27.
//  Copyright © 2018 MrParker. All rights reserved.
//

import UIKit

class GoodListPopupViewController: UIViewController {
    
    var good_status: String!
    var frame_width: CGFloat!
    var popupViewWidth: CGFloat!
    var titleArr = [String]()
    var imageArr = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.layoutButtons()
        // Do any additional setup after loading the view.
    }
    
    func layoutButtons() {
        self.view.frame = CGRect(x: 0, y: 0, width: 0, height: 50)
        let popupView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        popupView.layer.cornerRadius = 5.0
        popupView.layer.masksToBounds = true
        popupView.backgroundColor = Specs.color.black
        self.view.addSubview(popupView)
        
        switch self.good_status {
        case "0":
            self.titleArr = ["编辑", "删除"]
            self.imageArr = ["goodsmanage_edit", "goodsmanage_delete"]
            break
        case "-1":
            self.titleArr = ["编辑", "上架", "删除"]
            self.imageArr = ["goodsmanage_edit", "GoodManage_Added", "goodsmanage_delete"]
            break
        case "1":
            self.titleArr = ["编辑", "下架", "删除"]
            self.imageArr = ["goodsmanage_edit", "goodsmanage_download", "goodsmanage_delete"]
            break
        default:
            self.titleArr = ["编辑", "删除"]
            self.imageArr = ["goodsmanage_edit", "goodsmanage_delete"]
            break
        }
        
        let popupViewWidth = self.frame_width / 3 * CGFloat(self.titleArr.count)
        popupView.frame.size.width = popupViewWidth
        
        let rightImage = UIImage(named: "GoodsManage_rightArrow")
        let imageView = UIImageView(frame: CGRect(x: popupViewWidth, y: self.view.frame.size.height - 18, width: (rightImage?.size.width)!, height: (rightImage?.size.height)!))
        imageView.image = rightImage
        self.view.addSubview(imageView)
        self.popupViewWidth = popupViewWidth + (rightImage?.size.width)!
        
        let _height = self.view.frame.size.height
        let _pre = Int(popupViewWidth - (rightImage?.size.width)!)/self.titleArr.count
        for index in 0..<self.titleArr.count {
            let _btn = UIButton(frame: CGRect(x: _pre * index, y: 0, width: _pre, height: Int(_height) - 15 ))
            
            _btn.set(image: UIImage(named: self.imageArr[index]), title: self.titleArr[index], titlePosition: .bottom, additionalSpacing: 5.0, state: .normal)
            _btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
            _btn.setTitleColor(Specs.color.white, for: .normal)
            _btn.tag = index
            _btn.addTarget(self, action: #selector(clickedGoodList(_:)), for: .touchUpInside)
            popupView.addSubview(_btn)
        }
//        self.view.frame.size.width = 
    }
    
    @objc func clickedGoodList(_ sender: UIButton) {
//        print(sender.tag)
        if sender.tag == 0 { // 编辑
            let _target = GoodOperateSViewController()
            _target.navTitle = "编辑货品"
            _push(view: self, target: _target)
        } else if sender.tag == -1 { // 上架
            
        } else if sender.tag == 1 { // 下架
            
        }  else {
            
        }
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
