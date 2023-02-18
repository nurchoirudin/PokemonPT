//
//  BaseViewController.swift
//  PokemonPT
//
//  Created by Nur Choirudin on 18/02/23.
//

import RxSwift
import RxCocoa

class BaseViewController: UIViewController {
    let disposeBag = DisposeBag()
    deinit {
        print("Deinit \(type(of: self))")
    }
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
   
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 12.0, *) {
            if traitCollection.userInterfaceStyle == .light {
                if #available(iOS 13.0, *) {
                    return .lightContent
                } else {
                    return .lightContent
                }
            } else {
                return .lightContent
            }
        } else {
            return .lightContent
        }
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action:#selector(dismissKeyboard(_:)))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
        
    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    func setupRefreshControl(_ scrollView: UIScrollView) {
        refreshControl.addTarget(self, action: #selector(BaseViewController.triggerRefreshControl), for: .valueChanged)
        scrollView.addSubview(refreshControl)
    }
    
    @objc func triggerRefreshControl() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.refreshControl.endRefreshing()
        }
        handleRefreshContent()
    }
    
    func handleRefreshContent() {

    }
    
    func setupHomeNavigation(title: String) {
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = PokeColor.baseRed.getColor()
            appearance.shadowColor = .clear
            appearance.shadowImage = UIImage()
            self.navigationController?.navigationBar.standardAppearance = appearance
            self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
        }

        navigationController?.navigationBar.setBackgroundImage(nil, for:.default)
        navigationController?.navigationBar.shadowImage = nil
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.layoutIfNeeded()
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barTintColor = PokeColor.tmdbLightBlue.getColor()
        navigationController?.navigationBar.barStyle = .default

        guard let navigationWidth = navigationController?.navigationBar.frame.width else { return }
        guard let navigationHeight = navigationController?.navigationBar.frame.height else { return }

        let titleView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: navigationWidth * 0.6, height: navigationHeight))

        let titleLabel: UILabel = UILabel(frame: titleView.frame)
        titleLabel.text = title
        titleLabel.textAlignment  = .center
        titleLabel.font = UIFont.Barlow(type: .Bold, ofSize: 21.0)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleView.addSubview(titleLabel)
        self.navigationItem.titleView = titleView
    }
    
    func setupMovieDetailNavigation() {
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = PokeColor.baseRed.getColor()
            appearance.shadowColor = .clear
            appearance.shadowImage = UIImage()
            self.navigationController?.navigationBar.standardAppearance = appearance
            self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
        }

        navigationController?.navigationBar.setBackgroundImage(nil, for:.default)
        navigationController?.navigationBar.shadowImage = nil
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.layoutIfNeeded()
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barTintColor = PokeColor.baseRed.getColor()
        
        guard let navigationWidth = navigationController?.navigationBar.frame.width else { return }
        guard let navigationHeight = navigationController?.navigationBar.frame.height else { return }

        let stackView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: navigationWidth - 32, height: navigationHeight))
        let backIcon = UIImage(named: "back_icon")
        let backButton = UIButton(type: .custom)
        backButton.contentMode = .center
        backButton.imageView?.contentMode = .scaleAspectFit
        backButton.setImage(backIcon, for: .normal)
        backButton.frame = CGRect(x: 0, y: 0, width: 16, height: navigationHeight)
        backButton.addTarget(self, action: #selector(self.customBackButtonTapped), for: .touchUpInside)
        stackView.addSubview(backButton)
        let leftButton = UIBarButtonItem(customView: stackView)
        self.navigationItem.leftBarButtonItem = leftButton

    }
    
    @objc func customBackButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    func showErrorr(_ errorModel: ResponseErrorModel?, didAction: (() -> Void)?){
        guard let model = errorModel else { return }
        let alert = UIAlertController(title: model.title, message: model.detail, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            didAction?()
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

extension UITabBarController {
    open override var childForStatusBarStyle: UIViewController? {
        return selectedViewController?.childForStatusBarStyle ?? selectedViewController
    }
}

extension UINavigationController {
    open override var childForStatusBarStyle: UIViewController? {
        return topViewController?.childForStatusBarStyle ?? topViewController
    }
}
