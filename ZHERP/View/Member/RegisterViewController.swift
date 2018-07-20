//
//  RegisterViewController.swift
//  ZHERP
//
//  Created by MrParker on 2018/7/18.
//  Copyright © 2018 MrParker. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RegisterViewController: UIViewController {
    
    // 输入文本框Observable流->ViewModel中username对文本框进行监听->然后username调用service进行处理得到usernameUsable结果流->提示lable对usernameUsable进行监听刷新UI
    // https://www.jianshu.com/p/089ae5bececa
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var usernameTip: UILabel!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var passwordTip: UILabel!
    @IBOutlet weak var repasswordTxt: UITextField!
    @IBOutlet weak var repasswordTip: UILabel!
    
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    
    @IBAction func registerBtn(_ sender: Any) {
        
    }
    @IBAction func LoginBtn(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        _open(view: self, vc: vc)
    }
    
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let registerVM = RegisterVM()
        
        usernameTxt.rx.text.orEmpty
            .bind(to: registerVM.username)
            .disposed(by: disposeBag)
        
        passwordTxt.rx.text.orEmpty
            .bind(to: registerVM.password)
            .disposed(by: disposeBag)
        
        repasswordTxt.rx.text.orEmpty
            .bind(to: registerVM.repassword)
            .disposed(by: disposeBag)
        
        registerBtn.rx.tap
            .bind(to: registerVM.registerTaps)
        .disposed(by: disposeBag)
        
        
        registerVM.usernameUseable
            .bind(to: usernameTip.rx.validationResult)
            .disposed(by: disposeBag)
        
        registerVM.usernameUseable
            .bind(to: passwordTxt.rx.inputEnabled)
            .disposed(by: disposeBag)
        
        registerVM.passwordUseable
            .bind(to: passwordTip.rx.validationResult)
            .disposed(by: disposeBag)
        
        registerVM.passwordUseable
            .bind(to: repasswordTxt.rx.inputEnabled)
            .disposed(by: disposeBag)
        
        registerVM.repasswordUseable
            .bind(to: repasswordTip.rx.validationResult)
            .disposed(by: disposeBag)
        
        registerVM.registerButtonEnabled
            .subscribe(onNext: { [unowned self] valid in
                self.registerBtn.isEnabled = valid
                self.registerBtn.alpha = valid ? 1.0 : 0.5
            })
        .disposed(by: disposeBag)
        
        registerVM.registerResult
            .subscribe(onNext: { [unowned self] result in
                switch result {
                case let .ok(message):
                    self.showAlert(message: message)
                case .empty:
                    self.showAlert(message: "")
                case let .failed(message):
                    self.showAlert(message: message)
                }
            })
        .disposed(by: disposeBag)
        // Do any additional setup after loading the view.
    }
    
    func showAlert(message: String) {
        let action = UIAlertAction(title: "确定", style: .default, handler: nil)
        let alertViewController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alertViewController.addAction(action)
        present(alertViewController, animated: true, completion: nil)
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
