//
//  GoodModel.swift
//  ZHERP
//
//  Created by MrParker on 2018/9/22.
//  Copyright © 2018 MrParker. All rights reserved.
//

import Foundation

class GoodModel: NSObject {
    var id: Int
    var category: String
    var cId: Int
    var warehouse: String
    var wId: Int
    var location: String
    var lId: Int
    var supplier: String
    var sId: Int
    var unit: String
    var uId: Int
    var sn: String
    var title: String
    var salePrice: String
    var costPrice: String
    var quantity: String
    var employee: String
    var datetime: Date
    
    init(id: Int, category: String, cId: Int, warehouse: String, wId: Int, location: String, lId: Int, supplier: String, sId: Int, unit: String, uId: Int, sn: String, title: String, salePrice: String, costPrice: String, quantity: String, employee: String, datetime: Date) {
        self.id = id
        self.category = category
        self.cId = cId
        self.warehouse = warehouse
        self.wId = wId
        self.location = location
        self.lId = lId
        self.supplier = supplier
        self.sId = sId
        self.unit = unit
        self.uId = uId
        self.sn = sn
        self.title = title
        self.salePrice = salePrice
        self.costPrice = costPrice
        self.quantity = quantity
        self.employee = employee
        self.datetime = datetime
    }
}
