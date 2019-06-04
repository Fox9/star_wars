//
//  BaseModel.swift
//  TheStarWars
//
//  Created by Ellan Esenaliev on 6/4/19.
//  Copyright © 2019 Ellan Esenaliev. All rights reserved.
//

import Foundation
import ObjectMapper

class BaseModel: Mappable {
    
    var count: Int = 0
    var next: String?
    var previous: String?
    var results: [Character] = []
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        self.count <- map["count"]
        self.next <- map["next"]
        self.previous <- map["previous"]
        self.results <- map["results"]
    }
    
}
