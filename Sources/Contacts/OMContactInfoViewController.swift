//
//  ContactInfoViewController.swift
//  Contacts
//
//  Created by Olexandr Matviichuk on 7/25/17.
//  Copyright © 2017 Olexandr Matviichuk. All rights reserved.
//

import UIKit

private let kOMContactInfoEditSegueIdentifier = "ContactInfoEditSegueIdentifier"

class OMContactInfoViewController: UIViewController {
    

    @IBOutlet weak var contactNameLabel: UILabel!
    @IBOutlet weak var zipCodeLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var streetAddress2Label: UILabel!
    @IBOutlet weak var streetAddress1Label: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    
    var contact: OMLocalContact? = nil

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        contactNameLabel.text = "\(contact!.firstName) \(contact!.lastName)"
        phoneNumberLabel.text = contact?.phoneNumber != nil ? contact?.phoneNumber : " "
        streetAddress1Label.text = contact?.streetAddress1 != nil ? contact?.streetAddress1 : " "
        streetAddress2Label.text = contact?.streetAddress2 != nil ? contact?.streetAddress2 : " "
        cityLabel.text = contact?.city != nil ? contact?.city : " "
        stateLabel.text = contact?.state ?? " "
        zipCodeLabel.text = contact?.zipCode ?? " "
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == kOMContactInfoEditSegueIdentifier {
            let vc = segue.destination as! OMEditContactViewController
            vc.contact = contact
        }
    }


}
