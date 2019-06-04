//
//  Character.swift
//  TheStarWars
//
//  Created by Ellan Esenaliev on 6/3/19.
//  Copyright © 2019 Ellan Esenaliev. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

class Character: Object, Mappable {
    @objc dynamic var birth_year: String = ""
    @objc dynamic var eye_color: String = ""
    @objc dynamic var gender: String = ""
    @objc dynamic var hair_color: String = ""
    @objc dynamic var height: String = ""
    @objc dynamic var homeworld: String = ""
    @objc dynamic var mass: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var skin_color: String = ""
    @objc dynamic var created: Date = Date()
    @objc dynamic var edited: Date = Date()
    @objc dynamic var url: String = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    override static func primaryKey() -> String? {
        return "url"
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
