//
//  RepositoryViewController.swift
//  textureUITest
//
//  Created by AGM Tazim on 6/5/22.
//

import UIKit
import RxSwift
import RxCocoa
import AsyncDisplayKit

// BaseViewController is ASDKViewController<ASDisplayNode> 
class SearchViewController: BaseViewController {
    var coordinator: SearchCoordinator?
    var userList: [User] = [User]()
    var userViewModel: UserViewModel!
    let inputSubject = PublishSubject<UserViewModel.UserSearchInputModel>()
    var query = ""
    
    // MAR: UI Objects
    lazy var tableNode: ASTableNode = {
        let tableNode = ASTableNode(style: .plain)
        tableNode.delegate = self
        tableNode.dataSource = self
        tableNode.reloadData()
        tableNode.view.leadingScreensForBatching = 1.0;
        
        return tableNode
    }()
    
    let noDataNode: ASTextNode = {
        let node = ASTextNode()
        
        let paragraphStyleName = NSMutableParagraphStyle()
        paragraphStyleName.alignment = .center
        
        node.attributedText = NSAttributedString(string: "No Data Available, Plz Search", attributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .medium),
            NSAttributedString.Key.paragraphStyle: paragraphStyleName
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
    
    override func viewDidAppear(_ animated: Bool) {
        coordinator?.backFromChild()
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
        
        self.navigationItem.title = "Search User"
        
        let btnAction = UIBarButtonItem(title: "SEARCH", style: .done, target: self, action: #selector(didTapSearchButton))
        btnAction.tintColor = appColors.textColorLight
        self.navigationItem.rightBarButtonItem = btnAction
    }
    
    override func addSubviews() {
        view.addSubnode(tableNode)
        tableNode.addSubnode(noDataNode)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tableNode.frame = view.frame
        noDataNode.frame = CGRect(origin: CGPoint(x: 0, y: tableNode.frame.midY-15), size: CGSize(width: tableNode.frame.width, height: 30))
    }
    
    override func bindViewModel() {
        userViewModel = viewModel as! UserViewModel
        let input = UserViewModel.UserSearchInput(searchUserTrigger: inputSubject)
        let output = userViewModel.getUserSearchOutput(input: input)
        
        output.users
            .asDriver()
            .drive(onNext: { [weak self] data in
                guard let weakSelf = self, let data = data else {
                    return
                }
                
                weakSelf.insertNewRows(data)
            })
            .disposed(by: disposeBag)
    }
    
    func triggerEventForsearchUser(query: String) {
        inputSubject.onNext(UserViewModel.UserSearchInputModel(accessToken: UserSessionDataClient.shared.getAccessToken(), query: query, page: userViewModel.pageNo))
    }
    
    @objc func didTapSearchButton(sender : AnyObject){
        showSearchDialog()
    }
    
    func clearAndRelaoad() {
        userViewModel.isNewSearch = true
        userList.removeAll()
        tableNode.reloadData()
    }
    
    private func showSearchDialog() {
        let alertController = UIAlertController(title: "Search User", message: "Enter user name", preferredStyle: UIAlertController.Style.alert)
        
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Username"
        }
        
        let saveAction = UIAlertAction(title: "Search", style: UIAlertAction.Style.default, handler: { [weak self] alert -> Void in
            let username = (alertController.textFields?[0])?.text?.uppercased() ?? ""
            
            if !username.isEmpty {
                self?.query = username
                self?.triggerEventForsearchUser(query: username)
                self?.clearAndRelaoad()
            }
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: {
            (action : UIAlertAction!) -> Void in })
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
}


// MARK: - ASTableDelegate

extension SearchViewController: ASTableDelegate {
    func tableView(_ tableView: ASTableView, willBeginBatchFetchWith context: ASBatchContext) {
        userViewModel.isNewSearch = false 
        triggerEventForsearchUser(query: query)
        context.completeBatchFetching(true)
    }
    
    func shouldBatchFetch(for tableView: ASTableView) -> Bool {
        guard let totalDataCount = userViewModel.totalDataCount else {
            return false
        }
        
        if totalDataCount > userList.count {
            return true
        }
        return false
    }
    
    func tableView(_ tableView: ASTableView, constrainedSizeForRowAt indexPath: IndexPath) -> ASSizeRange {
        return ASSizeRangeMake(CGSize(width: UIScreen.main.bounds.size.width-20, height: 120), CGSize(width: UIScreen.main.bounds.size.width-20, height: .greatestFiniteMagnitude))
    }
    
    func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
        coordinator?.navigateToUserDetails(user: userList[indexPath.row].asDomain)
    }
}

// MARK: - ASTableDataSource

extension SearchViewController: ASTableDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userList.count
    }
    
    func tableView(_ tableView: ASTableView, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        let item = userList[(indexPath as NSIndexPath).row]
        
        return {
            let node = UserCellNode(item: item)
            return node
        }
    }
}

// MARK: - Helpers

extension SearchViewController {
    func insertNewRows(_ newUSers: [User]) {
        let section = 0
        var indexPaths = [IndexPath]()
        
        let newTotalUsers = userList.count + newUSers.count
        
        for row in userList.count ..< newTotalUsers {
            let path = IndexPath(row: row, section: section)
            indexPaths.append(path)
        }
        
        userList.append(contentsOf: newUSers)
        tableNode.insertRows(at: indexPaths, with: .none)
        
        showHideNoDataNode()
    }
    
    func showHideNoDataNode () {
        var isHidden = false
        
        if userList.count > 0 {
            isHidden = true
        }
        
        noDataNode.isHidden = isHidden
    }
}
