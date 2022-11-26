//
//  NewEventViewController.swift
//  SharingExpenses
//
//  Created by Alireza on 8/24/1401 AP.
//

import Foundation
import UIKit

protocol NewEventViewControllerDelegate {
    func newEventAdded()
}

class NewEventViewController: ViewController {
    
    var coordinator: EventsCoordinator?
    var delegate: NewEventViewControllerDelegate?

    @IBOutlet weak var editingParentView: UIView!
    @IBOutlet weak var importButton: UIButton!
    @IBOutlet weak var titleTextxField: UITextField!
    @IBOutlet weak var addEventButton: UIButton!

    @IBAction func importEventButtonAction(_ sender: Any) {
        eventsViewModel.setNew(title: titleTextxField.text ?? "Error")
        delegate?.newEventAdded()
        navigationController?.popViewController(animated: true)

    }

    var eventsViewModel =  EventsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
