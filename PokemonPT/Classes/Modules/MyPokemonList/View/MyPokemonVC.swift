//
//  MyPokemonVC.swift
//  PokemonPT
//
//  Created by Nur Choirudin on 18/02/23.
//

import UIKit
import RxSwift
import RxCocoa

class MyPokemonVC: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
    var viewModel = Injection().resolve(MyPokemonListViewModel.self)

    init() {
        super.init(nibName: String(describing: MyPokemonVC.self), bundle: nil)
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
        tableView.delegate = self
        tableView.dataSource = self
        let nibName = UINib(nibName: String(describing: MyPokemonCell.self), bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: String(describing: MyPokemonCell.self))
    }

}

extension MyPokemonVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let model = viewModel.getMyPokemon()?.count else { return 0 }
        return model
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MyPokemonCell.self), for: indexPath) as? MyPokemonCell else { return UITableViewCell() }
        if let model = viewModel.getMyPokemon() {
            cell.configureCell(model: model[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
  
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            if let model = viewModel.getMyPokemon() {
                viewModel.deletePokemon(model: model[indexPath.row])
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Release"
    }
}
