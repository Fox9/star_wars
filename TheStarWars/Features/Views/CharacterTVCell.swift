//
//  CharacterTVCell.swift
//  TheStarWars
//
//  Created by Ellan Esenaliev on 6/4/19.
//  Copyright © 2019 Ellan Esenaliev. All rights reserved.
//

import UIKit

class CharacterTVCell: UITableViewCell {

    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var characterBithLabel: UILabel!
    @IBOutlet weak var characterGenderLabel: UILabel!
    
    
    var character: Character? {
        didSet {
            guard let character = character else { return }
            self.characterNameLabel.text = character.name
            self.characterBithLabel.text = character.birth_year
            self.characterGenderLabel.text = character.gender
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(character: Character) {
        self.character = character
    }
    
}
