//
//  MoviePosterCell.swift
//  PokemonPT
//
//  Created by Nur Choirudin on 18/02/23.
//

import UIKit
import SkeletonView

class PokemonListCell: UICollectionViewCell {
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var containerShadowView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var pokemonImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureView(){
        DispatchQueue.main.async {
            self.containerView.layer.cornerRadius = 4
            self.containerShadowView.layer.masksToBounds = false
            self.containerShadowView.layer.shadowColor = UIColor.black.cgColor
            self.containerShadowView.layer.shadowOpacity = 0.4
            self.containerShadowView.layer.shadowOffset = CGSize(width: -1, height: 1)
            self.containerShadowView.layer.shadowRadius = 4
            self.containerShadowView.layer.shadowPath = UIBezierPath(rect: self.containerShadowView.bounds).cgPath
            self.containerShadowView.layer.shouldRasterize = true
            self.containerShadowView.layer.rasterizationScale = UIScreen.main.scale
        }
    }
    
    func configureCell(model: PokemonListModel.Result?){
        if let model = model, let pokemonId = model.url {
            DispatchQueue.main.async {[weak self] in
                guard let self = self else { return }
               
                self.pokemonImageView.loadImage(url: URL(string: model.getPokemonImageOriginal()))
                self.pokemonNameLabel.text = model.name?.capitalized
            }
        }
    }
}
