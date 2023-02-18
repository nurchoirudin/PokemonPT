//
//  PokemonAbillitiesCell.swift
//  PokemonPT
//
//  Created by Nur Choirudin on 18/02/23.
//

import UIKit

class PokemonAbillitiesCell: UITableViewCell {
    @IBOutlet weak var pokemonAbbLabel: UILabel!
    
    @IBOutlet weak var isHiddenLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(model: PokemonDetailModel.Ability?){
        pokemonAbbLabel.text = model?.ability?.name?.capitalized
        guard let isHidden = model?.isHidden else { return }
        if isHidden {
            isHiddenLabel.isHidden = false
        } else {
            isHiddenLabel.isHidden = true
        }
    }
}
