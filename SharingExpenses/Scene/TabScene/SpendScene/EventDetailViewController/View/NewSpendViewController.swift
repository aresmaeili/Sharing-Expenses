//
//  NewSpendViewController.swift
//  SharingExpenses
//
//  Created by Alireza on 8/23/1401 AP.
//

import Foundation
import UIKit

protocol NewSpendViewControllerDelegate {
    func newSpendAdded()
}

class NewSpendViewController: ViewController {
    
    weak var coordinator: SpendsCoordinator?
    private var spendsViewModel = SpendViewModel(delegate: nil)
    private var userViewModel = UsersViewModel()
    private var eventViewModel = EventsViewModel()

    @IBOutlet weak private var editingParentView: UIView!
    @IBOutlet weak private var costTextField: UITextField!
    @IBOutlet weak private var costlabel: UILabel!
    @IBOutlet weak private var titleTextField: UITextField!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var addUserButton: UIButton!
    @IBOutlet weak private var eventsCollectionView: UICollectionView!
    @IBOutlet weak private var ownersCollectionView: UICollectionView!
    @IBOutlet weak private var addEventsButton: UIButton!
    @IBOutlet weak private var usersLabel: UILabel!
    @IBOutlet weak var usersCollectionView: UICollectionView!
    
    // MARK: - Button Actions
    @IBAction private func addEventsButtonAction(_ sender: Any) {

        coordinator?.navToEvents(delegate: self)
    }
    
    @IBAction private func addUserButtonAction(_ sender: Any) {
        coordinator?.navToUsers(delegate: self)
    }
    
    @IBAction private func importSpendButtonAction(_ sender: Any) {
        let titlee = titleTextField.text ?? ""
        let cost = Int(costTextField.text ?? "0") ?? 0
        spendsViewModel.setNewSpendToDataManaer(title: titlee, cost: cost)
//        spendsTableView.reloadData()
        titleTextField.text = ""
        costTextField.text = ""
        spendsViewModel.resetContent()
        delegate?.newSpendAdded()
        navigationController?.popViewController(animated: true)

    }
    var delegate: NewSpendViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spendsViewModel.delegate = self
        setupCollectionViews()
    }
    
    private func reloadData() {
        usersCollectionView.reloadData()
        eventsCollectionView.reloadData()
        ownersCollectionView.reloadData()
//        spendsTableView.reloadData()
    }
}

// MARK: - Setup CollectionView
extension NewSpendViewController: UICollectionViewDataSource {
//    TODO: Auto naming
    private func setupCollectionViews() {
        usersCollectionView.delegate = self
        usersCollectionView.dataSource = self
        usersCollectionView.register(UINib(nibName: "UserCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "UserCollectionViewCell")
        let layout = usersCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: 30, height: 30)
        
        eventsCollectionView.delegate = self
        eventsCollectionView.dataSource = self
        eventsCollectionView.register(UINib(nibName: "UserCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "UserCollectionViewCell")
        let layout2 = eventsCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout2.itemSize = CGSize(width: 30, height: 30)

        ownersCollectionView.delegate = self
        ownersCollectionView.dataSource = self
        ownersCollectionView.register(UINib(nibName: "UserCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "UserCollectionViewCell")
        let layout3 = ownersCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout3.itemSize = CGSize(width: 30, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserCollectionViewCell", for: indexPath) as! UserCollectionViewCell

        switch collectionView {
        case eventsCollectionView:
            let event = spendsViewModel.events[indexPath.row]
            cell.configureCell(type: .events, event: event, user: nil, selectedEvent: spendsViewModel.selectedEvent, selectedUsersId: spendsViewModel.selectedUsers, Owner: spendsViewModel.owner)
        case usersCollectionView:
            let user = spendsViewModel.userForRow(indexPath: indexPath, isOwner: false)
            cell.configureCell(type: .users, event: nil, user: user, selectedEvent: spendsViewModel.selectedEvent, selectedUsersId: spendsViewModel.selectedUsers, Owner: spendsViewModel.owner)
        default:
            let user = spendsViewModel.userForRow(indexPath: indexPath, isOwner: true)
            cell.configureCell(type: .owner(users: spendsViewModel.users), event: nil, user: user, selectedEvent: spendsViewModel.selectedEvent, selectedUsersId: spendsViewModel.selectedUsers, Owner: spendsViewModel.owner)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == usersCollectionView {
            return spendsViewModel.numberofRowsInSection(.users)
        } else if collectionView == eventsCollectionView {
            return spendsViewModel.numberofRowsInSection(.events)
        } else {
            return spendsViewModel.numberofRowsInSection(.owner(users: spendsViewModel.users))
        }
    }
}

extension NewSpendViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case usersCollectionView:
            let user =  spendsViewModel.users[indexPath.row]
            if !((spendsViewModel.selectedUsers.compactMap({$0.id}).contains(user.id))) {
                spendsViewModel.setSelectedUser(user: spendsViewModel.users[indexPath.row])
            } else {
                if let index = spendsViewModel.selectedUsers.firstIndex(of: spendsViewModel.users[indexPath.row]) {
                    spendsViewModel.removeAtIndex(index: index)
                }
            }
        case eventsCollectionView:
            let event =  spendsViewModel.events[indexPath.row]
            spendsViewModel.setSelectedEvents(event: event)
        default:
            let owner =  spendsViewModel.selectedUsers[indexPath.row]
            spendsViewModel.setOwner(owner: owner)
            collectionView.reloadData()
        }
    }
}

extension NewSpendViewController: SpendViewModelDelegate, NewUserViewControlerDelegate, NewEventViewControllerDelegate {
    func userAdded() {
        usersCollectionView.reloadData()
    }
    
    func newEventAdded() {
        eventsCollectionView.reloadData()
    }
    
    func dataChanged() {
        usersCollectionView.reloadData()
        eventsCollectionView.reloadData()
        ownersCollectionView.reloadData()
    }
}
