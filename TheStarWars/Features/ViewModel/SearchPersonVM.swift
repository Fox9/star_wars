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
}

class SearchPersonVM {
    
    weak var delegate: SearchPersonVMDelegate?
    
    var baseModel: BaseModel?
    var characters: [Character] = []
    
    private var repository: SearchPersonRepository
    
    init() {
        self.repository = SearchPersonRepository()
    }
    
    func loadCharacters(text: String) {
        self.repository.loadCharacters(text: text)
            .subscribe(onNext: { (baseModel) in
                self.baseModel = baseModel
                self.characters = baseModel.results
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
                self.characters.append(contentsOf: baseModel.results)
                self.delegate?.searchPersonVM(self, didLoadCharacters: self.characters)
            }, onError: { (error) in
                self.delegate?.searchPersonVM(self, didRecieveError: error.localizedDescription)
            })
    }
}
