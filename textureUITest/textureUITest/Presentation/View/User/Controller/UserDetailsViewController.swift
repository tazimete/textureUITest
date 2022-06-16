//
//  RepositoryDetailsViewController.swift
//  textureUITest
//
//  Created by AGM Tazim on 6/15/22.
//

import UIKit
import RxSwift
import RxCocoa
import AsyncDisplayKit
import SafariServices

// BaseViewController is ASDKViewController<ASDisplayNode>
class UserDetailsViewController: BaseViewController {
    weak var coordinator: UserDetailsCoordinator?
    var userViewModel: UserViewModel!
    var user: UserData!
    let userDetailsTrigger = PublishSubject<UserViewModel.UserDetailsInputModel>()
    
    let avatarNode: ASNetworkImageNode = {
        let node = ASNetworkImageNode()
        node.clipsToBounds = true
        node.placeholderFadeDuration = 0.15
        node.contentMode = .scaleAspectFill
        node.shouldRenderProgressImages = true
        return node
    }()
    
    let nameNode: ASTextNode = {
        let node = ASTextNode()
        node.placeholderEnabled = true
        node.placeholderFadeDuration = 0.15
        node.placeholderColor = UIColor(white: 0.777, alpha: 1.0)
        node.attributedText = NSAttributedString(string: "nameNode... ", attributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .medium)
        ])
        return node
    }()
    
    let descriptionNode: ASTextNode = {
        let node = ASTextNode()
        node.truncationAttributedText = NSAttributedString(string: "…")
        node.truncationMode = .byTruncatingTail
        node.style.spacingAfter = 10
        node.backgroundColor = UIColor.clear
        node.placeholderEnabled = true
        node.placeholderFadeDuration = 0.15
        node.placeholderColor = UIColor(white: 0.777, alpha: 1.0)
        node.maximumNumberOfLines = 0
        node.isLayerBacked = true
        node.isOpaque = false
        node.attributedText = NSAttributedString(string: "descriptionNode .. descriptionNode .. descriptionNode .. descriptionNode .. descriptionNode .. descriptionNode . descriptionNode .. descriptionNode descriptionNode .. descriptionNode .. descriptionNode .. descriptionNode .. descriptionNode .. descriptionNode . descriptionNode .. descriptionNode", attributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .medium)
        ])
        return node
    }()
    
    let followerNode: ASTextNode = {
        let node = ASTextNode()
        node.placeholderEnabled = true
        node.placeholderFadeDuration = 0.15
        node.placeholderColor = UIColor(white: 0.777, alpha: 1.0)
        node.attributedText = NSAttributedString(string: "Followers: ", attributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .medium)
        ])
        return node
    }()
    
    let followingNode: ASTextNode = {
        let node = ASTextNode()
        node.placeholderEnabled = true
        node.placeholderFadeDuration = 0.15
        node.placeholderColor = UIColor(white: 0.777, alpha: 1.0)
        node.attributedText = NSAttributedString(string: "Following: ", attributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .medium)
        ])
        return node
    }()
    
    // MARK: Constructors
    init(viewModel: UserViewModel) {
        super.init(viewModel: viewModel)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: Overrriden Methods
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
        view.addSubnode(avatarNode)
        view.addSubnode(nameNode)
        view.addSubnode(descriptionNode)
        view.addSubnode(followerNode)
        view.addSubnode(followingNode)
    }
    
    override func viewWillLayoutSubviews() {
      super.viewWillLayoutSubviews()
        
        let x = (10 as CGFloat).adaptiveWidth()
        let avatarHeight = (120 as CGFloat).adaptiveWidth()
        let fieldDiff = (10 as CGFloat).adaptiveWidth()
        
        let textHeight = (20 as CGFloat).adaptiveHeight()
        
        avatarNode.frame = CGRect(x: x, y: 0, width: view.frame.width-(2*x), height: avatarHeight)
        followerNode.frame = CGRect(x: x, y: avatarNode.frame.maxY + fieldDiff, width: avatarNode.frame.width/2, height: textHeight)
        followingNode.frame = CGRect(x: followerNode.frame.maxX, y: avatarNode.frame.maxY + fieldDiff, width: followerNode.frame.width, height: textHeight)
        nameNode.frame = CGRect(x: x, y: followingNode.frame.maxY + fieldDiff, width: avatarNode.frame.width, height: textHeight)
        nameNode.view.center.x = view.center.x
        descriptionNode.frame = CGRect(x: x, y: nameNode.frame.maxY + fieldDiff, width: nameNode.frame.width, height: 3*textHeight)
        
    }
    
    override func bindViewModel() {
        userViewModel = viewModel as! UserViewModel
        
        let input = UserViewModel.UserDetailsInput(userDetailsTrigger: userDetailsTrigger)
        let output = userViewModel.getUserDeatilsOutput(input: input)
        
        output.user
            .asDriver()
            .drive(onNext: { [weak self] user in
                AppLogger.info(user)
            }).disposed(by: disposeBag)
        
        userDetailsTrigger.onNext(UserViewModel.UserDetailsInputModel(myAccessToken: UserSessionDataClient.shared.getAccessToken(), name: user.name.unwrappedValue, id: user.id.unwrappedValue))
    }
}

