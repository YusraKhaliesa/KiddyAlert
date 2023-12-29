//
//  KidDetail.swift
//  KiddyAlert
//
//  Created by user on 05/12/2023.
//

import Foundation
import SwiftData

@Model
class KidDetail {
    @Attribute(.unique) var id: String = UUID().uuidString
    var name: String
    var scName: String
    var doTime: Date
    var pTime: Date
    var gender : Int

    
    
    init(id: String = UUID().uuidString, name: String = "", scName: String = "", doTime: Date = Date.now, pTime: Date = Date.now, gender: Int = 0) {
        self.id = id
        self.name = name
        self.scName = scName
        self.doTime = doTime
        self.pTime = pTime
        self.gender = gender
        
    }
}
