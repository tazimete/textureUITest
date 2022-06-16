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
import SafariServices

// BaseViewController is ASDKViewController<ASDisplayNode> 
class AuthViewController: BaseViewController {
    weak var coordinator: AuthCoordinator?
    var authViewModel: AuthViewModel!
    let userAuthTokenTrigger = PublishSubject<URL>()
    
    let logoNode: ASImageNode = {
        let node = ASImageNode()
        node.clipsToBounds = true
        node.placeholderFadeDuration = 0.15
        node.contentMode = .center
        node.image = UIImage(named: "auth")
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
    init(viewModel: AuthViewModel) {
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
        view.addSubnode(logoNode)
        view.addSubnode(loginButton)
    }
    
    override func viewWillLayoutSubviews() {
      super.viewWillLayoutSubviews()
      
        let x = (10 as CGFloat).adaptiveWidth()
        let y = (view.frame.height/4 as CGFloat).adaptiveWidth()
        let height = (50 as CGFloat).adaptiveWidth()
        let fieldDiff = (60 as CGFloat).adaptiveWidth()
        
        logoNode.frame = CGRect(x: x, y: y, width: height*3, height: height*3)
        logoNode.view.center.x = view.center.x
        loginButton.frame = CGRect(x: x, y: logoNode.frame.maxY + fieldDiff, width: view.frame.width-(2*x), height: height)
    }
    
    override func addActionsToSubviews() {
        // did tap submit button
        loginButton.rx.tap.bind { [weak self] in
            self?.authenticateUser()
        }.disposed(by: disposeBag)
    }
    
    override func bindViewModel() {
        AppLogger.info("accessToken == \(UserSessionDataClient.shared.getAccessToken())")
        
        authViewModel = viewModel as! AuthViewModel
        let input = AuthViewModel.AuthInput(authTrigger: userAuthTokenTrigger)
        let output = authViewModel.getAuthOutput(input: input)
        
        output.authResponse
            .asDriver()
            .drive(onNext: { [weak self] data in
                guard let weakSelf = self, let data = data else {
                    return
                }
                
                AppLogger.info(data)
                weakSelf.handleAuthTokenResponse(credential: data)
                
        }).disposed(by: disposeBag)
    }
    
    //MARK: Authentication Process
    func authenticateUser() {
        guard let url = URL(string: "https://github.com/login/oauth/authorize?state=state&redirect_uri=it.iacopo.github://authentication&scope=repo%20user&client_id=fd2d97030f7ca8dfe654") else {
            return
        }
        
        let safariVC = SFSafariViewController(url: url)
        safariVC.modalPresentationStyle = .fullScreen
        present(safariVC, animated: true, completion: nil)
    }
    
    func receivedAuthCallback(url: URL) {
        userAuthTokenTrigger.onNext(url)
    }
    
    func handleAuthTokenResponse(credential: UserCredential) {
        presentedViewController?.dismiss(animated: true)
        coordinator?.navigatSearchScreen(credential: credential)
    }
    
    // MARK: DIALOG VIEW
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

