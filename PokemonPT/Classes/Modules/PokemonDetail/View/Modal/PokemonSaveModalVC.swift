//
//  PokemonSaveModalVC.swift
//  PokemonPT
//
//  Created by Nur Choirudin on 19/02/23.
//

import UIKit

class PokemonSaveModalVC: BaseViewController {

    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var pokemonNameLabel: UITextField!
    @IBOutlet weak var pokemonImageView: UIImageView!
    var model: PokemonDetailModel?
    var didSaveButton: ((MyPokemonListModel) -> Void)?
    init(model: PokemonDetailModel?) {
        super.init(nibName: String(describing: PokemonSaveModalVC.self), bundle: nil)
        self.model = model
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    private func configureView(){
        guard let model = self.model else { return }
        pokemonImageView.loadImage(url: URL(string: model.getPokemonImageOriginal()))
        pokemonNameLabel.text = model.name?.capitalized
    }
    
    @IBAction func saveButton(_ sender: Any) {
        if pokemonNameLabel.text != "" {
            let date = Date()
            let id = UInt64(floor(date.timeIntervalSince1970 * 1000))
            let pokemonId = model?.id
            let pokemonImageUrl = model?.getPokemonImageOriginal()
            let pokemonName = pokemonNameLabel.text
            self.didSaveButton?(MyPokemonListModel(id: "\(id)", pokemonId: pokemonId, pokemonImageUrl: pokemonImageUrl, pokemonName: pokemonName))
        }
    }
}
