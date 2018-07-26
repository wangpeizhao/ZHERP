//
//  EditPersonalViewController.swift
//  ZHERP
//
//  Created by MrParker on 2018/7/24.
//  Copyright © 2018 MrParker. All rights reserved.
//

import UIKit
import SnapKit

class EditPersonalViewController: UIViewController {

    var personalValue: String? = nil
    var personalTitle: String? = nil
    var personalKey: String? = nil
    
    lazy var box = UIView()
    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = Specs.color.white
        
//        print(personalTitle)
        setNavBarTitle(view: self, title: personalTitle!, transparent: false, ofSize: 18)
        
        let selector: Selector = #selector(actionSave)
        
//        setNavBarLeftBtn(view: self, title: "", selector: selector)
        switch personalKey {
        case "username":
            setNavBarRightBtn(view: self, title: "保存", selector: selector)
            break
        case "signature":
            setNavBarRightBtn(view: self, title: "完成", selector: selector)
            break
        default:
            setNavBarRightBtn(view: self, title: "保存", selector: selector)
            break
        }
        
        box.backgroundColor = UIColor.orange
        
        
        self.view.addSubview(box)
        
        let textF=UITextField(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        //设置textF边框，默认空白边框
        textF.borderStyle=UITextBorderStyle.bezel
        self.view.addSubview(textF)
        
        box.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(100)
            make.height.equalTo(100)
            make.center.equalTo(self.view)
        }
        

        // Do any additional setup after loading the view.
    }
    
    @objc func actionSave() {
        print("EditPersonalViewController actionSave ")
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
