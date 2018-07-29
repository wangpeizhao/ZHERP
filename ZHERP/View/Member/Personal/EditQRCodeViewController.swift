//
//  EditQRCodeViewController.swift
//  ZHERP
//
//  Created by MrParker on 2018/7/28.
//  Copyright © 2018 MrParker. All rights reserved.
//

import UIKit

class EditQRCodeViewController: UIViewController {

    var personalValue: String? = nil
    var personalTitle: String? = nil
    var personalKey: String? = nil
    var avatarValue: String? = nil
    var usernameValue: String? = nil
    var regionValue: String? = nil
    
    let imageView = UIImageView()
    var formView: UIView!
    var avatarView: UIImageView!
    var username: UILabel!
    var region: UILabel!
    var RQView: UIView!
    var RQBg: UIImageView!
    var RQ: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(hex: 0x2f3032)
        
        self.formView = UIView()
        self.formView.backgroundColor = Specs.color.white
        self.formView.layer.borderWidth = 0
        self.view.addSubview(self.formView)
        self.formView.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.center.equalTo(self.view)
            make.height.equalTo(400)
        }
        
        self.avatarView = UIImageView()
        self.avatarView.image = UIImage(named: avatarValue!)
        self.formView.addSubview(self.avatarView)
        self.avatarView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(15)
            make.left.equalTo(15)
            make.width.height.equalTo(50)
        }
        
        self.username = UILabel()
        self.username.textColor = Specs.color.black
        self.username.font = UIFont.systemFont(ofSize: Specs.fontSize.large)
        self.username.text = usernameValue!
        self.formView.addSubview(self.username)
        self.username.snp.makeConstraints{ (make) -> Void in
            make.left.equalTo(self.avatarView.snp.right).offset(20)
            make.top.equalTo(self.avatarView).offset(5)
        }
        
        self.region = UILabel()
        self.region.textColor = Specs.color.gray
        self.region.text = regionValue!
        self.region.font = UIFont.systemFont(ofSize: Specs.fontSize.regular)
        self.formView.addSubview(self.region)
        self.region.snp.makeConstraints{ (make) -> Void in
            make.left.equalTo(self.avatarView.snp.right).offset(20)
            make.top.equalTo(self.username.snp.bottom).offset(5)
        }
        
        self.RQView = UIView(frame: CGRect(x: 0, y: 0, width: 250, height: 250))
//        self.RQView.backgroundColor = UIColor(patternImage: UIImage(named: "QRBg")!)
        let RQViewBg = UIImage.init(named: "QRBg")
        self.RQView.layer.contents = RQViewBg?.cgImage
        self.RQView.layer.borderWidth = 0
        self.formView.addSubview(self.RQView)
        self.RQView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.avatarView.snp.bottom).offset(20)
            make.left.equalTo(15)
            make.right.equalTo(-15)
//            make.width.height.equalTo(200)
            make.bottom.equalTo(self.formView.snp.bottom).offset(-15)
            make.centerX.equalTo(self.formView)
        }
        
        
        
//        self.RQBg = UIImageView()
//        // imageAdaptive(imageView: self.RQ, imageName: personalValue!)
//        self.RQBg.image = UIImage(named: "QRBg")
//        self.formView.addSubview(self.RQBg)
//        self.RQBg.snp.makeConstraints { (make) -> Void in
//            //            make.width.height.equalTo(300)
//            make.top.equalTo(80)
//            make.left.equalTo(15)
//            make.right.equalTo(-15)
//            make.bottom.equalTo(self.formView.snp.bottom).offset(-15)
//            make.centerX.equalTo(self.formView)
//            //            make.centerY.equalTo(self.formView).offset(50)
//        }
//
//        self.RQ = UIImageView()
//        // imageAdaptive(imageView: self.RQ, imageName: personalValue!)
//        self.RQ.image = UIImage(named: personalValue!)
//        self.formView.addSubview(self.RQ)
//        self.RQ.snp.makeConstraints { (make) -> Void in
//            make.top.equalTo(140)
//            make.left.equalTo(75)
//            make.right.equalTo(-75)
//            make.bottom.equalTo(self.RQBg.snp.bottom).offset(-75)
//            //            make.width.height.equalTo(150)
//            make.centerX.equalTo(self.formView)
//            //            make.centerY.equalTo(self.formView).offset(100)
//        }
        
        self.RQ = UIImageView()
        // imageAdaptive(imageView: self.RQ, imageName: personalValue!)
        self.RQ.image = UIImage(named: personalValue!)
        self.RQView.addSubview(self.RQ)
        self.RQ.snp.makeConstraints { (make) -> Void in
            make.width.height.equalTo(170)
//            make.left.equalTo(65)
//            make.right.equalTo(-65)
            make.center.equalTo(self.RQView)
        }

        // Do any additional setup after loading the view.
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
