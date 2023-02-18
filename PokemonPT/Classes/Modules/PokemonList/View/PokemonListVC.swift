//
//  PokemonListVC.swift
//  PokemonPT
//
//  Created by Nur Choirudin on 18/02/23.
//

import UIKit
import SkeletonView
import RxSwift
import RxCocoa

class PokemonListVC: BaseViewController {
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    var viewModel = Injection().resolve(PokemonListViewModel.self)
    
    @IBOutlet weak var myPokemonListButton: UIButton!
    private var footerView: PokemonListFooterView?
    
    init() {
        super.init(nibName: String(describing: PokemonListVC.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private func configureView(){
        self.setupHomeNavigation(title: "POKEMON")
        
        configureCollectionView()
        setupRefreshControl(collectionView)
        bindView()
        configureButton()
    }
    
    private func configureCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        
        var nibName = UINib(nibName: String(describing: PokemonListCell.self), bundle: nil)
        
        collectionView.register(nibName, forCellWithReuseIdentifier: String(describing: PokemonListCell.self))
        
        nibName = UINib(nibName: String(describing: PokemonListFooterView.self), bundle: nil)
        collectionView.register(nibName, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: String(describing: PokemonListFooterView.self))
    }
    
    private func bindView(){
        viewModel.state.asObservable().observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] loading in
                guard let self = self else { return }
                switch loading {
                case .loading:
                    self.emptyView.isHidden = true
                    if !self.viewModel.isLoadmore() {
                        self.collectionView.showAnimatedGradientSkeleton()
                    } else {
                        self.footerView?.loadingIndicatorView.startAnimating()
                    }
                    break
                case .finished:
                    self.collectionView.reloadData()
                    self.collectionView.hideSkeleton()
                    if self.viewModel.getPokemonListModel()?.results?.count == 0 {
                        self.emptyView.isHidden = false
                        self.collectionView.isHidden = true
                    } else {
                        self.emptyView.isHidden = true
                        self.collectionView.isHidden = false
                    }
                    break
                case .failed:
                    self.collectionView.hideSkeleton()
                    self.showErrorr(self.viewModel.errorModelObservable.value) {
                        if self.viewModel.errorModelObservable.value?.status == 0 {
                            self.viewModel.getPokemonList()
                        }
                    }
                    break
                default:
                    self.collectionView.hideSkeleton()
                    break
                }
            }).disposed(by: disposeBag)
        viewModel.getPokemonList()
    }
    
    private func configureButton(){
        myPokemonListButton.rx.tap.bind{[weak self] in
            guard let self = self else { return }
            let myPokemonVC = Injection().resolve(MyPokemonVC.self)
            self.navigationController?.pushViewController(myPokemonVC, animated: true)

        }.disposed(by: self.disposeBag)
    }
    
    override func handleRefreshContent() {
        viewModel.getPokemonList()
    }
}

//MARK: - Collection View Delegate
extension PokemonListVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let resultCount = viewModel.getPokemonListModel()?.results?.count else { return 0 }
        return resultCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PokemonListCell.self), for: indexPath) as? PokemonListCell else {
            return UICollectionViewCell()
        }
        cell.configureView()
        if let model = viewModel.getPokemonListModel() {
            cell.configureCell(model: model.results?[indexPath.item])
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 4 * 2) / 3
        return CGSize(width: width, height: width * 1.5)
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
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
            guard let  aFooterView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String(describing: PokemonListFooterView.self), for: indexPath) as? PokemonListFooterView else {
                return UICollectionReusableView()
                
            }
            self.footerView = aFooterView
            self.footerView?.backgroundColor = UIColor.clear
            return aFooterView
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        if elementKind == UICollectionView.elementKindSectionFooter {
            //            self.footerView?.loadingIndicatorView.stopAnimating()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, at indexPath: IndexPath) {
        if elementKind == UICollectionView.elementKindSectionFooter {
            //            self.footerView?.configureLoading()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if viewModel.isLoadmore() {
            return CGSize.zero
        }
        return CGSize(width: collectionView.bounds.size.width, height: 62)
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let threshold = 100.0 ;
        let contentOffset = scrollView.contentOffset.y;
        let contentHeight = scrollView.contentSize.height;
        let diffHeight = contentHeight - contentOffset;
        let frameHeight = scrollView.bounds.size.height;
        var triggerThreshold = Float((diffHeight - frameHeight))/Float(threshold);
        triggerThreshold = min(triggerThreshold, 0.0)
        let pullRatio = min(abs(triggerThreshold),1.0);
        if pullRatio >= 0.8 {
            self.footerView?.animateFinal()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let contentOffset = scrollView.contentOffset.y;
        let contentHeight = scrollView.contentSize.height;
        let diffHeight = contentHeight - contentOffset;
        let frameHeight = scrollView.bounds.size.height;
        let pullHeight = abs(diffHeight - frameHeight);
        if pullHeight >= 0.0 {
            guard let footerView = self.footerView, footerView.isAnimatingFinal else { return }
            if let result = viewModel.getPokemonListModel()?.results?.count, let totalResult = viewModel.getPokemonListModel()?.count {
                if result < totalResult {
                    self.viewModel.loadMore(status: true)
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let model = viewModel.getPokemonListModel()?.results?[indexPath.row] else {
            return
        }
        
        let pokemonName = model.name
        let pokemonDetailVC = Injection().resolve(PokemonDetailVC.self, args: pokemonName)
        navigationController?.pushViewController(pokemonDetailVC, animated: true)
    }
}

//MARK: - UITextFieldDelegate
extension PokemonListVC: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        collectionView.showAnimatedGradientSkeleton()
        collectionView.setContentOffset(CGPoint.zero, animated: false)
        return true
    }
}

extension PokemonListVC: SkeletonCollectionViewDataSource, SkeletonTableViewDelegate {
    func numSections(in collectionSkeletonView: UICollectionView) -> Int {
        return 5
    }
    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return String(describing: PokemonListCell.self)
    }
}
