//
//  ZHQRCodeViewController.swift
//  ZHERP
//
//  Created by MrParker on 2018/8/16.
//  Copyright © 2018 MrParker. All rights reserved.
//

import UIKit
import  AVFoundation

class ZHQRCodeViewController: UIViewController {

    var config = ZHQRCodeConfig()
    let session = AVCaptureSession()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = ZHQRCodeManager.zh_navigationItemTitle(type: self.config.scannerType)

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // 关闭并隐藏手电筒
//        self.s
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func _setupUI() {
        self.view.backgroundColor = .black
        
        let albumItem = UIBarButtonItem(title: "相册", style: .plain, target: self, action: #selector(showAlbum))
        albumItem.tintColor = .black
    }
    
    @objc func showAlbum() {
        ZHQRCodeManager.zh_checkAlbum { (granted) in
            if granted {
                self.imagePicker()
            }
        }
    }
    
    func imagePicker() {
        //初始化图片控制器
        let picker = UIImagePickerController()
        //设置代理
        picker.delegate = self
        //指定图片控制器类型
        picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        //设置是否允许编辑
        // picker.allowsEditing = true
        //弹出控制器，显示界面
        self.present(picker, animated: true, completion: nil)
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

// MARK: - 识别选择图片
extension ZHQRCodeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true) {
            
        }
    }
}





