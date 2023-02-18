//
//  UISearchBar+Extension.swift
//  PokemonPT
//
//  Created by Nur Choirudin on 18/02/23.
//

import UIKit


extension UISearchBar {
    func setNewcolor(color: UIColor) {
        let colorChange = subviews.flatMap { $0.subviews }
        guard let searchBar = (colorChange.filter { $0 is UITextField }).first as? UITextField else { return }
        searchBar.textColor = color
    }
    
    var compatibleSearchTextField: UITextField {
        guard #available(iOS 13.0, *) else { return legacySearchField }
        return self.searchTextField
    }
    
    private var legacySearchField: UITextField {
        if let textField = self.subviews.first?.subviews.last as? UITextField {
            return textField
        } else if let textField = self.value(forKey: "searchField") as? UITextField {
            return textField
        } else {
            return UITextField()
        }
    }
}
