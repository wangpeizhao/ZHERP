//
//  Service.swift
//  ZHERP
//
//  Created by MrParker on 2018/7/19.
//  Copyright © 2018 MrParker. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

class ValidationService {
    static let instance = ValidationService()
    
    private init() {}
    
    let minCharactersCount = 6
    
    func validateUsername(_ username: String) -> Observable<Result> {
//        print("validateUsername: \(username)")
        if username.count == 0 {
            return .just(.empty)
        }
        
        if username.count < minCharactersCount {
            return .just(.failed(message: "号码长度至少6个字符"))
        }
        
        if usernameValid(username) {
            return .just(.failed(message: "账户已存在"))
        }
        
        return .just(.ok(message: "用户名可用"))
    }
    
    func validatePassword(_ password: String) -> Result {
//        print("validatePassword: \(password)")
        if password.count == 0 {
            return .empty
        }
        if password.count < minCharactersCount {
            return .failed(message: "密码长度至少6个字符")
        }
        return .ok(message: "密码可用")
    }
    
    func validateRepassword(_ password: String, repassword: String) -> Result {
//        print("validateRepassword: \(password)")
        if repassword.count == 0 {
            return .empty
        }
        if repassword.count == password.count {
            return .ok(message: "密码可用")
        }
        return .failed(message: "两次密码不一样")
    }
    
    func usernameValid(_ username: String) -> Bool {
        let filePath = NSHomeDirectory() + "/Documents/users.plist"
        let userDic = NSDictionary(contentsOfFile: filePath)
        let usernameArray = userDic?.allKeys
        guard usernameArray != nil else {
            return false
        }
        if (usernameArray! as NSArray).contains(username) {
            return true
        } else {
            return false
        }
    }
    
    func register(_ username: String, password: String) -> Observable<Result> {
        let userDic = [username: password]
        
        let filePath = NSHomeDirectory() + "/Documents/users.plist"
        
        if (userDic as NSDictionary).write(toFile: filePath, atomically: true) {
            return .just(.ok(message: "恭喜注册成功"))
        }
        
        return .just(.failed(message: "Failed"))
    }
}

















