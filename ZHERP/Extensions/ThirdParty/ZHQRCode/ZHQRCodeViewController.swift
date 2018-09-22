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
    
    var actionType: String = "good"
    var config = ZHQRCodeConfig()
    let session = AVCaptureSession()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        self.navigationItem.title = ZHQRCodeManager.zh_navigationItemTitle(type: self.config.scannerType)
        _setupUI()
        
        NotificationCenter.default.addObserver(self, selector: #selector(appDidBecomeActive), name: .UIApplicationDidBecomeActive, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(appWillResignActive), name: .UIApplicationWillResignActive, object: nil)

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        _resumeScanning()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // 关闭并隐藏手电筒
        self.scannerView.zh_setFlashlight(on: false)
        self.scannerView.zh_hideFlashlight(animated: true)
    }
    
    private func _setupUI() {
        self.view.backgroundColor = .black
        
        // 右键按钮
        let albumItem = UIBarButtonItem(title: "相册", style: .plain, target: self, action: #selector(showAlbum))
        albumItem.tintColor = .white
        self.navigationItem.rightBarButtonItem = albumItem
        
        // 左键（返回）按钮
        let backBtn = UIBarButtonItem(title: self.navigationItem.title, style: .plain, target: self, action: #selector(callback))
        backBtn.tintColor = Specs.color.white
        self.navigationItem.backBarButtonItem = backBtn
        
        self.view.addSubview(self.scannerView)
        
        self.showCamera()
    }
    
    @objc func callback() {
        print("callback")
    }
    
    @objc func showAlbum() {
        ZHQRCodeManager.zh_checkAlbum { (granted) in
            if granted {
                self.session.stopRunning()
                self._pauseScanning()
                self.imagePicker()
            }
        }
    }
    
    private func showCamera() {
        ZHQRCodeManager.zh_checkCamera { (granted) in
            if granted {
                self.setupScanner()
            }
        }
    }
    
    // 跳转相册
    private func imagePicker() {
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
    
    // 跳转并创建扫描器（即开启相机）
    private func setupScanner() {
        guard let device = AVCaptureDevice.default(for: .video) else {
            return
        }
        if let deviceInput = try? AVCaptureDeviceInput(device: device) {
            let metadataOutput = AVCaptureMetadataOutput()
            metadataOutput.setMetadataObjectsDelegate(self, queue: .main)
            
            let videoDataOutput = AVCaptureVideoDataOutput()
            videoDataOutput.setSampleBufferDelegate(self, queue: .main)
            
            self.session.canSetSessionPreset(.high)
            if self.session.canAddInput(deviceInput) {
                self.session.addInput(deviceInput)
            }
            if self.session.canAddOutput(metadataOutput) {
                self.session.addOutput(metadataOutput)
            }
            if self.session.canAddOutput(videoDataOutput) {
                self.session.addOutput(videoDataOutput)
            }
            
            metadataOutput.metadataObjectTypes = ZHQRCodeManager.zh_metadataObjectTypes(type: self.config.scannerType)
            
            DispatchQueue.main.async {
                let videoPreviewLayer = AVCaptureVideoPreviewLayer(session: self.session)
                videoPreviewLayer.videoGravity = .resizeAspectFill
                videoPreviewLayer.frame = self.view.layer.bounds
                self.view.layer.insertSublayer(videoPreviewLayer, at: 0)
            }
            
            self.session.startRunning()
        }
    }
    
    // 从后台进入前台
    @objc func appDidBecomeActive() {
        _resumeScanning()
    }
    
    // 从前台进入后台
    @objc func appWillResignActive() {
        _pauseScanning()
    }
    
    lazy var scannerView: ZHScannerView = {
        let scannerView = ZHScannerView(frame: self.view.bounds, config: self.config)
        return scannerView
    }()
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: - 识别选择图片
extension ZHQRCodeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        picker.dismiss(animated: true) {
            if !self.handlePickerInfo(info) {
                self.zh_didReadFromAlbumFailed()
            }
        }
    }
    
    // 识别二维码并返回识别结果
    func handlePickerInfo(_ info: [String : Any]) -> Bool {
        let image: UIImage = info[UIImagePickerControllerOriginalImage] as! UIImage
//        self.imageView.image = image
//        let imageUrl: NSURL = info[UIImagePickerControllerImageURL] as! NSURL
//        print(imageUrl)
        
        //二维码读取
        let ciImage:CIImage = CIImage(image: image)!
        let context = CIContext(options: nil)
        let detector = CIDetector(ofType: CIDetectorTypeQRCode, context: context, options: [CIDetectorAccuracy:CIDetectorAccuracyHigh])
        if let features = detector?.features(in: ciImage) {
            print("扫描到二维码个数：\(features.count)")
            //遍历所有的二维码，并框出
            // 获取第一个
            // let feature = features.first as? CIQRCodeFeature
            for feature in features as! [CIQRCodeFeature] {
                print(feature.messageString ?? "")
                
                self.zh_handle(value: feature.messageString!)
                return true
            }
            return false
        }
        return true
    }
    
    
}

// MARK: - 扫描结果处理
extension ZHQRCodeViewController: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        var resultValue:String?
        if metadataObjects.count > 0 {
            _pauseScanning()
            
            if let metadataObject = metadataObjects[0] as? AVMetadataMachineReadableCodeObject {
                resultValue = metadataObject.stringValue
                if resultValue != nil{
                    zh_handle(value: resultValue!)
                }
            }
            
        }
        // self.session.stopRunning()
    }
}

// MARK: - 监听光线亮度
extension ZHQRCodeViewController: AVCaptureVideoDataOutputSampleBufferDelegate {
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        
        let metadataDict = CMCopyDictionaryOfAttachments(nil, sampleBuffer, kCMAttachmentMode_ShouldPropagate)
        
        if let metadata = metadataDict as? [AnyHashable: Any]{
            if let exifMetadata = metadata[kCGImagePropertyExifDictionary as String] as? [AnyHashable: Any] {
                if let brightness = exifMetadata[kCGImagePropertyExifBrightnessValue as String] as? NSNumber {
                    
                    // 亮度值
                    let brightnessValue = brightness.floatValue
                    if !self.scannerView.zh_setFlashlightOn() {
                        if brightnessValue < -2.0 { // -4.0
                            self.scannerView.zh_showFlashlight(animated: true)
                        } else {
                            self.scannerView.zh_hideFlashlight(animated: true)
                        }
                    }
                }
            }
        }
    }
}

// MARK: - 扫一扫API
extension ZHQRCodeViewController {
    
    /// 相册选取图片无法读取数据
    func zh_didReadFromAlbumFailed() {
        print("zh_didReadFromAlbumFailed")
    }
    
    // 处理扫一扫结果
    //
    // - Parameter value: 扫描结果
    func zh_handle(value: String) {
        switch self.actionType {
        case "good":
            self._action_good(value: value)
        case "allocating":
            self._action_allocating(value: value)
        case "picking":
            self._action_picking(value: value)
        case "warehousing":
            self._action_warehousing(value: value)
        default:
            self._action_common(value: value)
        }
    }
    
    // 输出结果
    func _action_common(value: String) {
        let alertController = UIAlertController(title: "二维码", message: value,preferredStyle: .alert)
        let okAction = UIAlertAction(title: "确定", style: .default, handler: {
            action in
            // 继续扫描
            self.session.startRunning()
            self._resumeScanning()
        })
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    // 商品
    func _action_good(value: String) {
        let sb = UIStoryboard(name:"Main", bundle: nil)
        let orderView = sb.instantiateViewController(withIdentifier: "OrderDetailViewController") as! OrderDetailViewController
        orderView.navTitle = "广发银行CGB"
        orderView.order_image = "codeBg"
        orderView.order_price = "20000"
        orderView.order_title = "信用卡"
        orderView.actionValue = value
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(orderView, animated: true)
    }
    
    // 扫码货品调配
    fileprivate func _action_allocating(value: String) {
        let pattern = "^[0-9]+$"
        guard NSPredicate(format: "SELF MATCHES %@", pattern).evaluate(with: value) else {
            _alert(view: self, message: "货品编号格式不正确", handler: _continueScan)
            return
        }
        let _target = HAllocatingViewController()
        _target.valueArr = [
            "sn": value,
            "name": "汤臣倍健多种维生素",
            "warehouse": "广州仓库",
            "outWarehouse": "10000"
        ]
        
        _push(view: self, target: _target, rootView: false)
    }
    
    // 扫码拣货
    fileprivate func _action_picking(value: String) {
        let pattern = "^[0-9]+$"
        guard NSPredicate(format: "SELF MATCHES %@", pattern).evaluate(with: value) else {
            _alert(view: self, message: "货品编号格式不正确", handler: _continueScan)
            return
        }
        let _target = HPickingGoodViewController()
        _target.valueArr = [
            "sn": value,
            "warehouse": "深圳仓库",
            "price": "80000.88",
            "total": "987452.00",
            "quantity": "12",
            "stock": "5600",
            "title": "美的（Midea）电饭煲 气动涡轮防溢 金属机身 圆灶釜内胆4L电饭锅MB-WFS4037",
        ]
        
        _push(view: self, target: _target, rootView: false)
    }
    
    fileprivate func _action_warehousing(value: String) {
        let pattern = "^[0-9]+$"
        guard NSPredicate(format: "SELF MATCHES %@", pattern).evaluate(with: value) else {
            _alert(view: self, message: "货品编号格式不正确", handler: _continueScan)
            return
        }
        let _target = GoodOperateFViewController()
        _target.dataType = .category
        _target.navTitle = "选择货品分类"
        _target.sn = value
        _push(view: self, target: _target, rootView: false)
    }
    
    // 继续扫描
    @objc func _continueScan(_: UIAlertAction)->Void {
        self.session.startRunning()
        self._resumeScanning()
    }
}

// MARK: - 恢复/暂停扫一扫功能
extension ZHQRCodeViewController {
    
    /// 恢复扫一扫功能
    private func _resumeScanning() {
        self.session.startRunning()
        self.scannerView.zh_addScannerLineAnimation()
    }
    
    /// 暂停扫一扫功能
    private func _pauseScanning() {
        self.session.stopRunning()
        self.scannerView.zh_pauseScannerLineAnimation()
    }
}




