//
//  PokemonDetailVC.swift
//  PokemonPT
//
//  Created by Nur Choirudin on 18/02/23.
//

import UIKit
import RxCocoa
import RxSwift
import FloatingPanel

class PokemonDetailVC: BaseViewController {
    @IBOutlet weak var pokemonAbillitiesTableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var pokemonAbillitiesTableView: UITableView!
    @IBOutlet weak var pokemonWeightLabel: UILabel!
    @IBOutlet weak var pokemonHeightLabel: UILabel!
    @IBOutlet weak var pokemonTypeCollectionView: UICollectionView!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var catchButton: UIButton!
    var viewModel = Injection().resolve(PokemonDetailViewModel.self)
    var pokemonSaveModalView: FloatingPanelController!
    
    init(pokemonName: String?) {
        super.init(nibName: String(describing: PokemonDetailVC.self), bundle: nil)
        self.viewModel.setPokemonName(pokemonName: pokemonName)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        bindView()
    }
    
    
    private func configureView(){
        configureButton()
        self.setupMovieDetailNavigation()
        configureCollectionView()
        configureTableView()
    }
    
    private func configureButton(){
        catchButton.layer.cornerRadius = catchButton.frame.height / 2
        catchButton.rx.tap.subscribe(onNext: {[weak self] _ in
            guard let self = self else { return }
            let isCatch = Bool.random()
            if isCatch {
                let pokemonSaveModalVC = Injection().resolve(PokemonSaveModalVC.self, args: self.viewModel.getPokemonDetailModel())
                self.pokemonSaveModalView = FloatingPanelControllerHelper.createFloatingPanelController()
                guard let validFPC = self.pokemonSaveModalView else { return }
                validFPC.set(contentViewController: pokemonSaveModalVC)
                validFPC.delegate = self
                
                pokemonSaveModalVC.didSaveButton = {[weak self] model in
                    self?.viewModel.catchPokemon(model: model)
                    self?.dismiss(animated: true)
                }
                
                self.present(validFPC, animated: true, completion: nil)
            } else {
                let alert = UIAlertController(title: "Darn!", message: "The Pokémon broke free!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                }))
                self.present(alert, animated: true, completion: nil)
            }
        }).disposed(by: self.disposeBag)
    }
    
    
    private func configureCollectionView(){
        pokemonTypeCollectionView.delegate = self
        pokemonTypeCollectionView.dataSource = self
        let nibName = UINib(nibName: String(describing: PokemonTypeCell.self), bundle: nil)
        pokemonTypeCollectionView.register(nibName, forCellWithReuseIdentifier: String(describing: PokemonTypeCell.self))
    }
    
    private func configureTableView(){
        pokemonAbillitiesTableView.delegate = self
        pokemonAbillitiesTableView.dataSource = self
        let nibName = UINib(nibName: String(describing: PokemonAbillitiesCell.self), bundle: nil)
        pokemonAbillitiesTableView.register(nibName, forCellReuseIdentifier: String(describing: PokemonAbillitiesCell.self))
    }
    
    
    private func bindView(){
        viewModel.state.asObservable().observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] loading in
                guard let self = self else { return }
                switch loading {
                case .loading:
                   
                    break
                case .finished:
                    self.finishLoading()
                    break
                case .failed:
                    self.showErrorr(self.viewModel.errorModelObservable.value) {
                        if self.viewModel.errorModelObservable.value?.status == 0 {
                            self.viewModel.getPokemonDetail()
                        }
                    }
                    break
                default:
                    break
                }
            }).disposed(by: disposeBag)
        viewModel.getPokemonDetail()
    }
    
    
    private func finishLoading(){
        guard let model = viewModel.getPokemonDetailModel() else { return }
        pokemonImageView.loadImage(url: URL(string: model.getPokemonImageOriginal()))
        pokemonNameLabel.text = model.name?.capitalized
        pokemonWeightLabel.text = "\(Double((model.weight ?? 0)) / 10) kg"
        pokemonHeightLabel.text = "\(Double(model.height ?? 0) * 10 / 100) m" 
        pokemonTypeCollectionView.reloadData()
        pokemonAbillitiesTableView.reloadData()
        guard let resultCount = viewModel.getPokemonDetailModel()?.abilities?.count else { return }
        pokemonAbillitiesTableViewHeightConstraint.constant = CGFloat(resultCount * 44)
    }
}


//MARK: - Collection View Delegate
extension PokemonDetailVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let resultCount = viewModel.getPokemonDetailModel()?.types?.count else { return 0 }
        return resultCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PokemonTypeCell.self), for: indexPath) as? PokemonTypeCell else {
            return UICollectionViewCell()
        }
        
        if let pokemonType = viewModel.getPokemonDetailModel()?.types {
            cell.configureCell(model: pokemonType[indexPath.row])
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == pokemonTypeCollectionView {
            guard let type = viewModel.getPokemonDetailModel()?.types else { return CGSize.zero }
            let width = type[indexPath.row].type?.name?.widthOfString(usingFont: UIFont.boldSystemFont(ofSize: 16.0))
            return CGSize(width: 74 + (width ?? 0), height: 48)
            
        } else {
            let width = (collectionView.frame.width - 4 * 2) / 3
            return CGSize(width: width, height: width * 1.5)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension PokemonDetailVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let resultCount = viewModel.getPokemonDetailModel()?.abilities?.count else { return 0 }
        return resultCount

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PokemonAbillitiesCell.self), for: indexPath) as? PokemonAbillitiesCell else { return UITableViewCell() }
        
        cell.selectionStyle = .none
        if let model = viewModel.getPokemonDetailModel()?.abilities {
            cell.configureCell(model: model[indexPath.row])
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}


extension PokemonDetailVC: FloatingPanelControllerDelegate {
    func floatingPanel(_ vc: FloatingPanelController, layoutFor newCollection: UITraitCollection) -> FloatingPanelLayout {
        return FixedHeightLayout(height: 400)
    }
    
    func floatingPanelDidMove(_ fpc: FloatingPanelController) {
        if fpc.isAttracting == false {
            let loc = fpc.surfaceLocation
            let minY = fpc.surfaceLocation(for: .full).y - 6.0
            let maxY = fpc.surfaceLocation(for: .tip).y + 6.0
            fpc.surfaceLocation = CGPoint(x: loc.x, y: min(max(loc.y, minY), maxY))
        }
    }
    
    func floatingPanelShouldBeginDragging(_ vc: FloatingPanelController) -> Bool {
        return false
    }
}
