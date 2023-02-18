//
//  PokemonTypeCell.swift
//  PokemonPT
//
//  Created by Nur Choirudin on 18/02/23.
//

import UIKit

class PokemonTypeCell: UICollectionViewCell {
    @IBOutlet weak var pokemonTypeLabel: UILabel!
    @IBOutlet weak var pokemonTypeImageView: UIImageView!
    @IBOutlet weak var pokemonTypeContainerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(model: PokemonDetailModel.TypeElement?) {
        guard let model = model else { return }
        pokemonTypeLabel.text = model.type?.name?.capitalized
        pokemonTypeImageView.image = model.type?.getPokemonTypeImage()
        pokemonTypeContainerView.layer.cornerRadius = 20
        pokemonTypeContainerView.backgroundColor = model.type?.getPokemonTypeColor()
//        getPokemonTypeImage
    }
}
