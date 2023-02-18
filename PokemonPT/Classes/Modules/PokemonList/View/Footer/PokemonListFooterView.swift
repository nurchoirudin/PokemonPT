//
//  MoviePosterFooterView.swift
//  PokemonPT
//
//  Created by Nur Choirudin on 18/02/23.
//

import UIKit
import NVActivityIndicatorView

class PokemonListFooterView: UICollectionReusableView {
    @IBOutlet weak var loadingIndicatorView: NVActivityIndicatorView!
    var isAnimatingFinal: Bool = false

    override func awakeFromNib() {
        super.awakeFromNib()
        configureLoading()
    }
    
    func configureLoading(){
        loadingIndicatorView.type = .ballScaleMultiple
        loadingIndicatorView.color = PokeColor.tmdbDarkBlue.getColor()!
        loadingIndicatorView.startAnimating()
    }
    
    func animateFinal() {
        if isAnimatingFinal {
            return
        }
        self.isAnimatingFinal = true
    }
}
