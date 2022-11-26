//
//  NewUSer.swift
//  SharingExpenses
//
//  Created by Alireza on 8/24/1401 AP.
//

import Foundation
import UIKit

protocol NewUserViewControlerDelegate {
    func userAdded()
}

class NewUserViewControler: ViewController {
    
    var coordinator: UsersCoordinator?
    
    @IBOutlet weak var importButton: UIButton!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var editParentView: UIView!
// MARK: - Button Actions
        @IBAction func importUserButtonAction(_ sender: Any) {
            importData()
            delegate?.userAdded()
            navigationController?.popViewController(animated: true)
        }
        
    let userViewModel = UsersViewModel()
    var delegate: NewUserViewControlerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    func importData() {
        userViewModel.setNew(name: nameTextField.text, phone: phoneNumber.text)
    }
}
