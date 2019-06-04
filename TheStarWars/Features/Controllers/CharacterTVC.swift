//
//  CharacterTVC.swift
//  TheStarWars
//
//  Created by Ellan Esenaliev on 6/4/19.
//  Copyright © 2019 Ellan Esenaliev. All rights reserved.
//

import UIKit

class CharacterTVC: UITableViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var birthLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var massLabel: UILabel!
    @IBOutlet weak var heirColorLabel: UILabel!
    @IBOutlet weak var skinColorLabel: UILabel!
    @IBOutlet weak var eyeColorLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    
    var viewModel: CharacterVM? {
        didSet {
            guard let viewModel = viewModel else { return }
            viewModel.delegate = self
        }
    }
    
    var character: Character!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.tableFooterView = UIView(frame: .zero)
        
        self.viewModel = CharacterVM(url: self.character.url)
        self.setup(character: self.character)
    }
    
    private func setup(character: Character) {
        
        self.title = character.name
        
        self.nameLabel.text = character.name
        self.birthLabel.text = character.birth_year
        self.heightLabel.text = character.height
        self.massLabel.text = character.mass
        self.heirColorLabel.text = character.hair_color
        self.skinColorLabel.text = character.skin_color
        self.eyeColorLabel.text = character.eye_color
        self.genderLabel.text = character.gender
    }
}

extension CharacterTVC: CharacterVMDelegate {
    func characterVM(_ class: CharacterVM, didLoadCharacter character: Character) {
        self.setup(character: character)
    }
    
    func characterVM(_ class: CharacterVM, didRecieveError message: String) {
        self.showAlert(message: message)
    }
}
