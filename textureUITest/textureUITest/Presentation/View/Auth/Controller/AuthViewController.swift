//
//  ViewController.swift
//  currency-converter
//
//  Created by AGM Tazimon 29/10/21.
//

import UIKit
import RxSwift
import RxCocoa
import AsyncDisplayKit

class AuthViewController: BaseViewController {
    var coordinator: AuthCoordinator?
    
    let emailField: ASEditableTextNode = {
        let node = ASEditableTextNode()
        node.attributedPlaceholderText = NSAttributedString(string: "Email", attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.gray,
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .regular)
            ]
        )
        node.textContainerInset = UIEdgeInsets(
            top: (15 as CGFloat).adaptiveWidth(),
            left: (10 as CGFloat).adaptiveWidth(),
            bottom: (15 as CGFloat).adaptiveWidth(),
            right: (10 as CGFloat).adaptiveWidth()
        )
        node.typingAttributes = [NSAttributedString.Key.strokeColor.rawValue: UIColor.black]
        node.borderWidth = 1
        node.borderColor = UIColor.gray.cgColor
        node.textView.font = UIFont.systemFont(ofSize: 16)
        node.keyboardType = .emailAddress
        node.maximumLinesToDisplay = 1
        node.cornerRadius = 10
        node.textView.applyAdaptiveLayout()
        return node
    }()
    
    let passwordField: ASEditableTextNode = {
        let node = ASEditableTextNode()
        node.attributedPlaceholderText = NSAttributedString(string: "Password", attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.gray,
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .regular)
            ]
        )
        node.textContainerInset = UIEdgeInsets(
            top: (15 as CGFloat).adaptiveWidth(),
            left: (10 as CGFloat).adaptiveWidth(),
            bottom: (15 as CGFloat).adaptiveWidth(),
            right: (10 as CGFloat).adaptiveWidth()
        )
        node.typingAttributes = [NSAttributedString.Key.strokeColor.rawValue: UIColor.black]
        node.borderWidth = 1
        node.borderColor = UIColor.gray.cgColor
        node.textView.font = UIFont.systemFont(ofSize: 16)
        node.keyboardType = .default
        node.maximumLinesToDisplay = 1
        node.isSecureTextEntry = true
        node.cornerRadius = 10
        node.textView.applyAdaptiveLayout()
        return node
    }()
    
    let loginButton: ASButtonNode = {
        let node = ASButtonNode()
        node.setAttributedTitle(NSAttributedString(string: "LOGIN", attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.white,
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .medium)
            ]
        ), for: .normal)
        
        node.borderWidth = 1
        node.borderColor = UIColor.white.cgColor
        node.backgroundColor = .systemBlue
        node.cornerRadius = 10
        return node
    }()
    
    // MARK: Constructors
    init(viewModel: MyBalanceViewModel) {
        super.init(viewModel: viewModel)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: Overrriden MethodS
    override func initView() {
        super.initView()
        //setup view
        view.backgroundColor = .white
        disableKeyboard(tappingView: view)
    }
    
    override func initNavigationBar() {
        super.initNavigationBar()
        
        self.navigationItem.title = "Authentication"
    }
    
    override func addSubviews() {
        view.addSubnode(emailField)
        view.addSubnode(passwordField)
        view.addSubnode(loginButton)
    }
    
    override func viewWillLayoutSubviews() {
      super.viewWillLayoutSubviews()
      
        let x = (10 as CGFloat).adaptiveWidth()
        let y = (view.frame.height/3 as CGFloat).adaptiveWidth()
        let height = (50 as CGFloat).adaptiveWidth()
        let fieldDiff = (15 as CGFloat).adaptiveWidth()
        
        emailField.frame = CGRect(x: x, y: y, width: view.frame.width-(2*x), height: height)
        passwordField.frame = CGRect(x: x, y: emailField.frame.maxY + fieldDiff, width: emailField.frame.width, height: height)
        loginButton.frame = CGRect(x: x, y: passwordField.frame.maxY + fieldDiff, width: passwordField.frame.width, height: height)
    }
    
    override func addActionsToSubviews() {
        // did tap submit button
        loginButton.rx.tap.subscribe(onNext: { [weak self] in
            self?.coordinator?.navigateRepositoryScreen()
        }).disposed(by: disposeBag)
    }
    
    override func bindViewModel() {
        AppLogger.info("conversionCount == \(UserSessionDataClient.shared.conversionCount)")
    }
    
    
    // MARK: DIALOG VIEW
    private func showAlertDialog(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.destructive, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func showAddCurrencyDialog() {
        let alertController = UIAlertController(title: "Search repository", message: "Enter epository name. Ex - testProject", preferredStyle: UIAlertController.Style.alert)
        
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Repository name"
        }
        
        let saveAction = UIAlertAction(title: "Search", style: UIAlertAction.Style.default, handler: { [weak self] alert -> Void in
            let repoName = (alertController.textFields?[0])?.text?.uppercased() ?? ""
            
            if !repoName.isEmpty {
            }
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: {
            (action : UIAlertAction!) -> Void in })
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
}

