//
//  WarehouseDetailViewController.swift
//  ZHERP
//
//  Created by MrParker on 2018/9/2.
//  Copyright © 2018 MrParker. All rights reserved.
//

import UIKit

class WarehouseDetailViewController: UIViewController {
    
    let Id: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(hex: 0xf7f7f7)
        if(self.Id > 0) {
            setNavBarTitle(view: self, title: "编辑")
        } else {
            setNavBarTitle(view: self, title: "添加")
        }
        setNavBarRightBtn(view: self, title: "添加", selector: #selector(actionSave))
        
        self._setup()

        // Do any additional setup after loading the view.
    }
    
    @objc func actionSave() {
        
    }
    
    private func _setup() {
        let nameView = UIView(frame: CGRect(x: 0, y: 5, width: ScreenWidth, height: 40))
        nameView.backgroundColor = Specs.color.white
        self.view.addSubview(nameView)
        
        let name = UILabel(frame: CGRect(x: 10, y: 10, width: ScreenWidth - 10, height: 20))
        name.text = "仓库名称"
        name.textColor = Specs.color.gray
        nameView.addSubview(name)
        
        let addressView = UIView(frame: CGRect(x: 0, y: 50, width: ScreenWidth, height: 40))
        addressView.backgroundColor = Specs.color.white
        self.view.addSubview(addressView)
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
