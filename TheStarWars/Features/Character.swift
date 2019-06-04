//
//  Character.swift
//  TheStarWars
//
//  Created by Ellan Esenaliev on 6/3/19.
//  Copyright © 2019 Ellan Esenaliev. All rights reserved.
//

import Foundation
import ObjectMapper

class Character: Mappable {
    var birth_year: String = ""
    var eye_color: String = ""
    var gender: String = ""
    var hair_color: String = ""
    var height: String = ""
    var homeworld: String = ""
    var mass: String = ""
    var name: String = ""
    var skin_color: String = ""
    var created: Date = Date()
    var edited: Date = Date()
    var url: String = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        self.birth_year <- map["birth_year"]
        self.eye_color <- map["eye_color"]
        self.gender <- map["gender"]
        self.hair_color <- map["hair_color"]
        self.height <- map["height"]
        self.mass <- map["mass"]
        self.name <- map["name"]
        self.skin_color <- map["skin_color"]
        self.created <- map["created"]
        self.edited <- map["edited"]
        self.url <- map["url"]
    }

}
