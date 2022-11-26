//
//  EventManagerViewController.swift
//  SharingExpenses
//
//  Created by Alireza on 8/10/1401 AP.
//

import Foundation
import UIKit

class EventManagerViewController: ViewController {
    
    var coordinator: EventsCoordinator?

    @IBOutlet weak var eventsTableView: UITableView!
    @IBOutlet weak var showParrentView: UIView!
    @IBOutlet weak var totalSpendLabel: UILabel!
    @IBOutlet weak var eventsCountLabel: UILabel!
   
    var eventsViewModel =  EventsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
//        setupEditModeView()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupContent()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        eventsViewModel.isEdit = false
//        setupEditModeView()
    }
    
    deinit {
        print("removed \(self) from memory")
    }
}

// MARK: - Functions
extension EventManagerViewController {
    
    func setupContent() {
        eventsCountLabel.text = eventsViewModel.eventsCount.description
        totalSpendLabel.text = eventsViewModel.eventTotalSpends.description
        eventsTableView.reloadData()
    }
    
    func setupView() {
        title = "Events"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "+", style: .plain, target: self, action: #selector(addTapped))
        setupContent()
    }
//
//    func setupEditModeView() {
//        editingParentView.isHidden = !eventsViewModel.isEdit
//        showParrentView.isHidden = eventsViewModel.isEdit
//    }
    
    func setupTableView() {
        eventsTableView.dataSource = self
        eventsTableView.delegate = self
        eventsTableView.register(UINib(nibName: "EventsTableViewCell", bundle: nil), forCellReuseIdentifier: "EventsTableViewCell")
    }
    
    @objc func  addTapped() {
        eventsViewModel.isEdit.toggle()
        coordinator?.popEditEvent(delegate: self)
    }
}

// MARK: - Setup TableView
extension EventManagerViewController: UITableViewDelegate {
    
}

extension EventManagerViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        eventsViewModel.eventsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventsTableViewCell", for: indexPath) as! EventsTableViewCell
        let event = eventsViewModel.eventsForRow(indexPath: indexPath)
        cell.configureCell(event: event)
        return cell
    }
}

extension EventManagerViewController: NewEventViewControllerDelegate {
    func newEventAdded() {
        eventsTableView.reloadData()
    }
}
