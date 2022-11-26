//
//  SpendsViewController.swift
//  SharingExpenses
//
//  Created by Alireza on 8/9/1401 AP.
//

import Foundation
import UIKit

class SpendsViewController: ViewController {
    
    weak var coordinator: SpendsCoordinator?
    
    private var spendsViewModel = SpendViewModel(delegate: nil)

    @IBOutlet weak private var totalSpendLabel: UILabel!
    @IBOutlet weak private var eventsCountLabel: UILabel!
    @IBOutlet weak private var showParentView: UIView!
  
    @IBOutlet weak var spendsTableView: UITableView!
    
// MARK: - Variables
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupData()
        reloadData()
    }

    override func viewDidDisappear(_ animated: Bool) {
        spendsViewModel.isEdit = false
//        setupEditModeView(isEdit: spendsViewModel.isEdit)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView(isEdit: spendsViewModel.isEdit)
        setupTableView()
        
    }
    
    deinit {
        print("removed \(self) from memory")
    }
}
// MARK: - Functions
extension SpendsViewController {
    
    private func reloadData() {
        spendsTableView.reloadData()
    }
    
    @objc func addTapped() {
        spendsViewModel.isEdit.toggle()
        coordinator?.popEditSpendView(delegate: self)
//        setupEditModeView(isEdit: spendsViewModel.isEdit)
    }
    
//    private func setupEditModeView(isEdit: Bool) {
//        editingParentView.isHidden = !isEdit
//        showParentView.isHidden = isEdit
//        costlabel.isHidden = isEdit
//        titleLabel.isHidden = isEdit
//        titleTextField.isHidden = !isEdit
//        addUserButton.isHidden = !isEdit
//        addEventsButton.isHidden = !isEdit
//    }
    
    private func setupView(isEdit: Bool) {
        title = "Spends"
//        setupEditModeView(isEdit: isEdit)
        eventsCountLabel.text = spendsViewModel.eventsCount.description
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "+", style: .plain, target: self, action: #selector(addTapped))
        totalSpendLabel.text = spendsViewModel.totalSpend.description
    }
    
    private func setupData() {
        eventsCountLabel.text = spendsViewModel.eventsCount.description
        totalSpendLabel.text = spendsViewModel.totalSpend.description
    }
}

// MARK: - Setup TableView
extension SpendsViewController: UITableViewDataSource, UITableViewDelegate {
    
    private func setupTableView() {
        spendsTableView.register(UINib(nibName: "SpendsTableViewCell", bundle: nil), forCellReuseIdentifier: "SpendsTableViewCell")
        spendsTableView.delegate = self
        spendsTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        spendsViewModel.spendsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = spendsTableView.dequeueReusableCell(withIdentifier: "SpendsTableViewCell", for: indexPath) as! SpendsTableViewCell
            cell.configureCell(spend: spendsViewModel.spendForRow(indexPath: indexPath))
            return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

extension SpendsViewController: NewSpendViewControllerDelegate {
    func newSpendAdded() {
        spendsTableView.reloadData()
    }
}
