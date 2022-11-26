//
//  ViewController.swift
//  SharingExpenses
//
//  Created by Setare Yek on 10/23/22.
//

import UIKit

enum CollectionType {
    case events
    case users
    case owner (users: Users)
}

class HomeVC: ViewController {
    
    weak var homeCoordinator: HomeCoordinator?
    
    @IBOutlet weak var topParentView: UIView!
    @IBOutlet weak var usersCollectionView: UICollectionView!
    @IBOutlet weak var eventsCollectionView: UICollectionView!
    @IBOutlet weak var usersLabel: UILabel!
    @IBOutlet weak var spendsLabel: UILabel!
    @IBOutlet weak var eventsLabel: UILabel!
    
    private let homeViewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadViews()
    }
    
    deinit {
        print("removed \(self) from memory")
    }
}

// MARK: - Functions
extension HomeVC {
    
    @objc func addTapped() {
        homeCoordinator?.rotateToSpends()
    }
    
    func setupView() {
        title = "Home"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "+", style: .plain, target: self, action: #selector(addTapped))
        
        // CollectionViews
        usersCollectionView.tag = 100
        usersCollectionView.delegate = self
        usersCollectionView.dataSource = self
        let layout1 = usersCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout1.itemSize = CGSize(width: 300, height: 280)
        usersCollectionView.register(UINib(nibName: "EventsColectionViewCell", bundle: nil), forCellWithReuseIdentifier: "EventsColectionViewCell")
        
        eventsCollectionView.tag = 200
        eventsCollectionView.delegate = self
        eventsCollectionView.dataSource = self
        let layout2 = eventsCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout2.itemSize = CGSize(width: 300, height: 280)
        eventsCollectionView.register(UINib(nibName: "EventsColectionViewCell", bundle: nil), forCellWithReuseIdentifier: "EventsColectionViewCell")
    }
    
    func loadData() {
        spendsLabel.text = homeViewModel.allSpendsAmopunt.description
        usersLabel.text = homeViewModel.usersCount.description
        eventsLabel.text = homeViewModel.eventsCount.description
    }
    
    func reloadData() {
        usersCollectionView.reloadData()
        eventsCollectionView.reloadData()
    }
}

// MARK: - Setup CollectionViews

extension HomeVC: UICollectionViewDelegate {
    
}

extension HomeVC: UICollectionViewDataSource {
    
    func reloadViews() {
        usersCollectionView.reloadData()
        eventsCollectionView.reloadData()
    }
    
//    func setupCollectionViews() {
//        
//    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (collectionView == usersCollectionView) ? homeViewModel.numberofRowsInSection(.users) : homeViewModel.numberofRowsInSection(.events)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = usersCollectionView.dequeueReusableCell(withReuseIdentifier: "EventsColectionViewCell", for: indexPath) as! EventsColectionViewCell
        switch collectionView {
        case usersCollectionView:
            cell.configureCell(event: nil, user: homeViewModel.userForRow(indexPath: indexPath), type: .users )
        case eventsCollectionView:
            cell.configureCell(event: homeViewModel.eventsForRow(indexPath: indexPath), user: nil, type: .events )
        default:
            break
        }
        return cell

    }
}
