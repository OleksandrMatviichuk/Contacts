//
//  EditContactViewController.swift
//  Contacts
//
//  Created by Olexandr Matviichuk on 7/25/17.
//  Copyright © 2017 Olexandr Matviichuk. All rights reserved.
//

import UIKit

class OMEditContactViewController: UIViewController {
    
    var contact: OMLocalContact? = nil

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var streetAddress1TextField: UITextField!
    @IBOutlet weak var streetAddress2TextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var stateTextField: UITextField!
    @IBOutlet weak var zipCodeTextField: UITextField!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if contact == nil {
            navigationItem.title = "New Contact"
        } else {
            firstNameTextField.text = contact!.firstName
            lastNameTextField.text = contact!.lastName
            phoneNumberTextField.text = contact!.phoneNumber
            streetAddress1TextField.text = contact!.streetAddress1
            streetAddress2TextField.text = contact!.streetAddress2
            cityTextField.text = contact!.city
            stateTextField.text = contact!.state
            zipCodeTextField.text = contact!.zipCode
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        let firstName = firstNameTextField.text ?? ""
        let lastName = lastNameTextField.text ?? ""
        let phoneNumber = phoneNumberTextField.text ?? ""
        let streetAddress1 = streetAddress1TextField.text ?? ""
        let streetAddress2 = streetAddress2TextField.text ?? ""
        let city = cityTextField.text ?? ""
        let state = stateTextField.text ?? ""
        let zipCode = zipCodeTextField.text ?? ""
        if contact != nil {
            OMContactsStorage.sharedStorage.updateContact(contact: contact!, firstName: firstName, lastName: lastName, phoneNumber: phoneNumber, StreetAddress1: streetAddress1, StreetAddress2: streetAddress2, city: city, state: state, zipCode: zipCode)
        } else {
            OMContactsStorage.sharedStorage.saveContactWith(firstName: firstName, lastName: lastName, phoneNumber: phoneNumber, StreetAddress1: streetAddress1, StreetAddress2: streetAddress2, city: city, state: state, zipCode: zipCode)
        }
    }

    @IBAction func cancelButtonBpressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

}

extension OMEditContactViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    }
