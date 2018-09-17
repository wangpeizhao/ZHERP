//
//  HDeliverModel.swift
//  ZHERP
//
//  Created by MrParker on 2018/9/17.
//  Copyright © 2018年 MrParker. All rights reserved.
//

import Foundation

class HDeliverModel: NSObject {
    var id: Int
    var orderId: String
    var orderAmount: String
    var orderRealPaid: String
    var orderTime: String
    var expressCompany: String
    var expressNumber: String
    var expressNote: String
    var receiver: String
    var receiverPhone: String
    var receiverRegion: String
    var receiverDetail: String
    var employee: String
    var datetime: Date
    
    init(id: Int, orderId: String, orderAmount: String, orderRealPaid: String, orderTime: String, expressCompany: String, expressNumber: String, expressNote: String, receiver: String, receiverPhone: String, receiverRegion: String, receiverDetail: String, employee: String, datetime: Date) {
        self.id = id
        self.orderId = orderId
        self.orderAmount = orderAmount
        self.orderRealPaid = orderRealPaid
        self.orderTime = orderTime
        self.expressCompany = expressCompany
        self.expressNumber = expressNumber
        self.expressNote = expressNote
        self.receiver = receiver
        self.receiverPhone = receiverPhone
        self.receiverRegion = receiverRegion
        self.receiverDetail = receiverDetail
        self.employee = employee
        self.datetime = datetime
    }
}

