//
//  BaseViewController.swift
//  currency-converter
//
//  Created by AGM Tazimon 29/10/21.
//

import UIKit
import RxSwift
import RxCocoa
import AsyncDisplayKit

public class BaseViewController: ASDKViewController<ASDisplayNode>, Storyboarded {
    public lazy var TAG = self.description
    public let disposeBag = DisposeBag()
    var viewModel: AbstractViewModel!
    public var isShimmerNeeded: Bool = false
    public let appColors = AppConfig.shared.getTheme().getColors()
    
    init(viewModel: AbstractViewModel) {
//        super.init(nibName: nil, bundle: nil)
        super.init()
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        bindViewModel()
        
        initNavigationBar()
        
        initView()
        
        addSubviews()
        addConstraints()
        
        setDataSource()
        addActionsToSubviews()
    }
    
    // bind respective viewmodel
    public func bindViewModel() {
        // TODO: Implement in child Class
    }
    
    // initialize navigation bar
    public func initNavigationBar() {
        // TODO: Implement in child Class
        navigationController?.navigationBar.isTranslucent = true
//        navigationController?.navigationBar.backgroundColor = appColors.primaryDark
//        navigationController?.navigationBar.barTintColor = appColors.textColorLight
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.overrideUserInterfaceStyle = .dark
//        navigationController?.setStatusBar(backgroundColor: appColors.primaryDark ?? .red)
//        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: appColors.textColorLight ?? .white]
        
        let barAppearance = UINavigationBarAppearance()
        
        if appColors.primaryDark != .white{
            barAppearance.backgroundColor = appColors.primaryDark
        }
        
        barAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: appColors.textColorLight]
            
//        navigationItem.standardAppearance = barAppearance
//        navigationItem.scrollEdgeAppearance = navigationItem.standardAppearance
        navigationController?.navigationBar.standardAppearance = barAppearance;
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
    }
    
    //initialize its subview
    public func initView() {
        // TODO: Implement in child Class
    }
    
    // add its subview 
    public func addSubviews() {
        // TODO: Implement in child Class
    }
    
    public func addConstraints() {
        // TODO: Implement in child Class 
    }
    
    //set its data source for subview/table/collection view
    public func setDataSource() {
        // TODO: Implement in child Class
    }
    
    // add actions to its subview
    public func addActionsToSubviews() {
        // TODO: Implement in child Class
    }
    
    //when theme change, we can also define dark mode color option in color asset
    override public func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        switch (traitCollection.userInterfaceStyle) {
            case .dark:
                self.applyDarkTheme()
                break
                
            case .light:
                self.applyNormalTheme()
                break
                
            default:
                break
        }
    }
    
    public func applyDarkTheme() {
        navigationController?.navigationBar.backgroundColor = .lightGray
        view.backgroundColor = .black
    }
    
    public func applyNormalTheme() {
        navigationController?.navigationBar.backgroundColor = .white
        view.backgroundColor = .white
    }
    
    //disbale keyboard
    public func disableKeyboard(tappingView: UIView) {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tappingView.isUserInteractionEnabled = true
        tappingView.addGestureRecognizer(tap)
    }
    
    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    //show alert dialog
    public func alert(_ title: String, text: String, actionTitle: String, handler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: actionTitle, style: .default, handler: handler))
        
        self.present(alert, animated: true, completion: nil)
    }
}



