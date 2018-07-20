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
    let registerTaps = PublishSubject<Void>()
    
    // output
    let usernameUseable: Observable<Result>
    let passwordUseable: Observable<Result>
    let repasswordUseable: Observable<Result>
    let registerButtonEnabled: Observable<Bool>
    let registerResult: Observable<Result>
    
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
                return service.validatePassword(password)
        }.share()
        
        repasswordUseable = Observable.combineLatest(password.asObservable(), repassword.asObservable()) {
//            print("combineLatest:\($0) \($1)")
            return service.validateRepassword($0, repassword: $1)
        }.share()
        
        registerButtonEnabled = Observable.combineLatest(usernameUseable, passwordUseable, repasswordUseable){ (username, password, repassword) in
            username.isValid && password.isValid && repassword.isValid
        }
            .distinctUntilChanged()
            .share()
        
        let usernameAndpassword = Observable.combineLatest(username.asObservable(), password.asObservable()) {
            ($0, $1)
        }
        
        registerResult = registerTaps.asObservable().withLatestFrom(usernameAndpassword)
            .flatMap {(username, password) in
                return service.register(username, password: password)
                    .observeOn(MainScheduler.instance)
                    .catchErrorJustReturn(.failed(message: "Register Wrong!"))
                    .share()
        }.share()
        
    }
}
