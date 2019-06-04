//
//  SearchPersonVM.swift
//  TheStarWars
//
//  Created by Ellan Esenaliev on 6/3/19.
//  Copyright © 2019 Ellan Esenaliev. All rights reserved.
//

import Foundation
import RxSwift

protocol SearchPersonVMDelegate: class {
    func searchPersonVM(_ class: SearchPersonVM, didLoadCharacters character: [Character])
    func searchPersonVM(_ class: SearchPersonVM, didRecieveError message: String)
    func searchPersonVM(_ class: SearchPersonVM, didUpdateCachingCharacters characters: [Character])
}

class SearchPersonVM {
    
    weak var delegate: SearchPersonVMDelegate?
    
    var baseModel: BaseModel?
    var characters: [Character] = []
    
    lazy var chachedCharacters = CachingManager.shared.getCharacters()
    
    var searchChachedCharacters: [Character] = []
    
    private var repository: SearchPersonRepository
    
    init() {
        self.repository = SearchPersonRepository()
    }
    
    func search(text: String) {
        if text == "" {
            self.searchChachedCharacters = Array(self.chachedCharacters)
        } else {
            self.searchChachedCharacters = self.chachedCharacters.filter({ $0.name.range(of: text, options: .caseInsensitive) != nil })
        }
        self.delegate?.searchPersonVM(self, didUpdateCachingCharacters: self.searchChachedCharacters)

    }
    
    func loadCharacters(text: String) {
        self.repository.loadCharacters(text: text)
            .subscribe(onNext: { (baseModel) in
                self.baseModel = baseModel
                self.characters = baseModel.results.filter({ (character) -> Bool in
                    return !self.characters.contains(where: { $0.url == character.url })
                })
                self.delegate?.searchPersonVM(self, didLoadCharacters: self.characters)
            }, onError: { (error) in
                self.delegate?.searchPersonVM(self, didRecieveError: error.localizedDescription)
            })
    }
    
    func loadCharactersNextPage() {
        guard let nextPage = self.baseModel?.next else { return }
        self.repository.loadCharacters(nextPage: nextPage)
            .subscribe(onNext: { (baseModel) in
                self.baseModel = baseModel
                let characters = baseModel.results.filter({ (character) -> Bool in
                    return !self.characters.contains(where: { $0.url == character.url })
                })
                self.characters.append(contentsOf: characters)
                self.delegate?.searchPersonVM(self, didLoadCharacters: self.characters)
            }, onError: { (error) in
                self.delegate?.searchPersonVM(self, didRecieveError: error.localizedDescription)
            })
    }
}
