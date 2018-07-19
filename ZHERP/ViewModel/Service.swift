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
        print("Password: \(password)")
        if password.count == 0 {
            return .empty
        }
        if password.count < minCharactersCount {
            return .failed(message: "密码长度至少6个字符")
        }
        return .ok(message: "密码可用")
    }
    
    func validateRepassword(_ password: String, repassword: String) -> Result {
        if password.count == 0 {
            return .empty
        }
        if password.count < minCharactersCount {
            return .failed(message: "密码长度至少6个字符")
        }
        return .ok(message: "密码可用")
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
}

















