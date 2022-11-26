//
//  UserManagerViewController.swift
//  SharingExpenses
//
//  Created by Alireza on 8/10/1401 AP.
//

import Foundation
import UIKit

class UserManagerViewController: ViewController {
    
    weak var coordinator: UsersCoordinator?

    @IBOutlet weak var showParentView: UIView!
    @IBOutlet weak var usersTableView: UITableView!
    @IBOutlet weak var usersCountLabel: UILabel!
    @IBOutlet weak var totalSpendLabel: UILabel!
    
    let userViewModel = UsersViewModel()
    var isEdit: Bool = false
    
    override func viewWillAppear(_ animated: Bool) {
        setupContent()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
//        setupEditModeView()
        setupTableView()
    }

    override func viewDidDisappear(_ animated: Bool) {
         isEdit = false
//        setupEditModeView()
        usersTableView.reloadData()

    }
    
    deinit {
        print("removed \(self) from memory")
    }
}

// MARK: - Functions
extension UserManagerViewController {
    func setupTableView() {
       usersTableView.delegate = self
       usersTableView.dataSource = self
       usersTableView.register(UINib(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: "UserTableViewCell")
   }

//    func setupEditModeView() {
//        editParentView.isHidden = !isEdit
//        showParentView.isHidden = isEdit
//    }
    
    func setupContent() {
        usersCountLabel.text = userViewModel.usersCount.description
        totalSpendLabel.text = userViewModel.usersTotalSpend.description
    }
    
    func setupView() {
        title = "Users"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "+", style: .plain, target: self, action: #selector(addTapped))
        setupContent()
    }
    
    @objc func addTapped() {
        isEdit.toggle()
        coordinator?.popEditUser(delegate: self)
//        setupEditModeView()
    }
}

// MARK: - Setup TableView
extension UserManagerViewController: UITableViewDelegate {
    
}

extension UserManagerViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        userViewModel.usersCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as! UserTableViewCell
        
        cell.configureCell(user: userViewModel.getUserForRow(indexPath: indexPath))
        return cell
    }
}

extension UserManagerViewController: NewUserViewControlerDelegate {
    func userAdded() {
        usersTableView.reloadData()
    }
}
