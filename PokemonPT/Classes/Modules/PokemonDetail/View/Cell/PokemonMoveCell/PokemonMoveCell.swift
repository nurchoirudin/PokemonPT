//
//  PokemonMoveCell.swift
//  PokemonPT
//
//  Created by Nur Choirudin on 19/02/23.
//

import UIKit

class PokemonMoveCell: UITableViewCell {
    @IBOutlet weak var moveLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(model: PokemonDetailModel.Move?){
        guard let model = model else { return }
        moveLabel.text = model.move?.name?.replacingOccurrences(of: "-", with: " ").capitalized
    }
}
