//
//  CharacterVM.swift
//  TheStarWars
//
//  Created by Ellan Esenaliev on 6/4/19.
//  Copyright © 2019 Ellan Esenaliev. All rights reserved.
//

import Foundation
import Alamofire
protocol CharacterVMDelegate: class {
    func characterVM(_ class: CharacterVM, didLoadCharacter character: Character)
    func characterVM(_ class: CharacterVM, didRecieveError message: String)
}

class CharacterVM {
    
    weak var delegate: CharacterVMDelegate?
    
    var repository: SearchPersonRepository
    var character: Character?
    
    var characterURL: String {
        didSet {
            self.loadCharacter()
        }
    }
    
    init(url: String) {
        self.repository = SearchPersonRepository()
        self.characterURL = url
    }
    
    func loadCharacter() {
        
        guard NetworkReachabilityManager()?.isReachable ?? false else {
            if let character = CachingManager.shared.getCharacter(by: self.characterURL) {
                self.character = character
                self.delegate?.characterVM(self, didLoadCharacter: character)
            }
            return
        }
        
        self.repository.loadCharacter(by: self.characterURL)
            .subscribe(onNext: { (character) in
                CachingManager.shared.write(character)
                self.delegate?.characterVM(self, didLoadCharacter: character)
            }, onError: { (error) in
                self.delegate?.characterVM(self, didRecieveError: error.localizedDescription)
            })
    }
}
