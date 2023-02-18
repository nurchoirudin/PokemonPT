//
//  PokeColor.swift
//  PokemonPT
//
//  Created by Nur Choirudin on 18/02/23.
//

import UIKit

enum PokeColor: String {
    case baseRed = "#E3350D"
    case tmdbDarkBlue = "#032541"
    case tmdbLightBlue = "#01b4e4"
    
    func getColor() -> UIColor? {
        return UIColor(hexString: self.rawValue)
    }
}
