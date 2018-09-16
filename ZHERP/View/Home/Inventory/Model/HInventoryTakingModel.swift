//
//  HInventoryTakingModel.swift
//  ZHERP
//
//  Created by MrParker on 2018/9/16.
//  Copyright © 2018 MrParker. All rights reserved.
//

import Foundation

class HInventoryTakingModel: NSObject {
    var id: Int
    var category: String
    var cId: Int
    var warehouse: String
    var wId: Int
    var location: String
    var lId: Int
    var employee: String
    var datetime: Date
    
    init(id: Int, category: String, cId: Int, warehouse: String, wId: Int, location: String, lId: Int, employee: String, datetime: Date) {
        self.id = id
        self.category = category
        self.cId = cId
        self.warehouse = warehouse
        self.wId = wId
        self.location = location
        self.lId = lId
        self.employee = employee
        self.datetime = datetime
    }
}
