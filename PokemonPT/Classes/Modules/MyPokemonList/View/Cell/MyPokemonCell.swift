//
//  MyPokemonCell.swift
//  PokemonPT
//
//  Created by Nur Choirudin on 19/02/23.
//

import UIKit

class MyPokemonCell: UITableViewCell {
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(model: MyPokemonListModel?){
        guard let model = model else { return }
        pokemonNameLabel.text = model.pokemonName
        pokemonImageView.setImage(model.pokemonImageUrl ?? "")
    }
}
