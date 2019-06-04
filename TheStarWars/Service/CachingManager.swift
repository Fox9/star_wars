//
//  CachingManager.swift
//  TheStarWars
//
//  Created by Ellan Esenaliev on 6/4/19.
//  Copyright © 2019 Ellan Esenaliev. All rights reserved.
//

import Foundation
import RealmSwift

class CachingManager {
    
    static let shared = CachingManager()
    
    private let realm = try! Realm()
    
    private init() { }
    
    func write(_ character: Character) {
        do {
            try realm.write {
                realm.add(character, update: true)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func delete(_ character: Character) {
        do {
            try realm.write {
                realm.delete(character)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getCharacter(by url: String) -> Character? {
        return realm.objects(Character.self).filter("%url = \(url)").first
    }
    
    func getCharacters() -> Results<Character> {
        return realm.objects(Character.self)
    }
    
}
