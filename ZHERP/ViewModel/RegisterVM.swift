//
//  Register.swift
//  ZHERP
//
//  Created by MrParker on 2018/7/19.
//  Copyright © 2018 MrParker. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RegisterVM {
    // input
    let username = Variable<String>("MrParker")// init value
    let password = Variable<String>("")// init value
    let repassword = Variable<String>("")// init value
    
    // output
    let usernameUseable: Observable<Result>
    let passwordUseable: Observable<Result>
    let repasswordUseable: Observable<Result>
    
    init() {
        let service = ValidationService.instance
        
        usernameUseable = username.asObservable()
            .flatMapLatest{ username in
                return service.validateUsername(username)
                .observeOn(MainScheduler.instance)
                    .catchErrorJustReturn(.failed(message: "Username Check Wrong!"))
                .share()
        }
        
        passwordUseable = password.asObservable()
            .map { password in
                print("asObservable password: \(password)")
                return service.validatePassword(password)
        }.share()
        
        repasswordUseable = Observable.combineLatest(password.asObservable(), repassword.asObservable()) {
            return service.validateRepassword($0, repassword: $1)
        }.share()
        
    }
}
