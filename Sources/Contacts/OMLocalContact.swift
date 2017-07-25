//
//  OMLocalContact.swift
//  Contacts
//
//  Created by Olexandr Matviichuk on 7/25/17.
//  Copyright © 2017 Olexandr Matviichuk. All rights reserved.
//

import UIKit

class OMLocalContact: NSObject {
    var contactID = ""
    var firstName = ""
    var lastName = ""
    var phoneNumber = ""
    var streetAddress1 = ""
    var streetAddress2 = ""
    var city = ""
    var state = ""
    var zipCode = ""
    
    convenience init(dictionary: Dictionary<String, String>) {
        self.init()
        if let contactID = dictionary["contactID"] {
            self.contactID = contactID
        }
        if let firstName = dictionary["firstName"] {
            self.firstName = firstName
        }
        if let lastName = dictionary["lastName"] {
            self.lastName = lastName
        }
        if let phoneNumber = dictionary["phoneNumber"] {
            self.phoneNumber = phoneNumber
        }
        if let streetAddress = dictionary["streetAddress1"] {
            self.streetAddress1 = streetAddress
        }
        if let streetAddress = dictionary["streetAddress2"] {
            self.streetAddress2 = streetAddress
        }
        if let city = dictionary["city"] {
            self.city = city
        }
        if let state = dictionary["state"] {
            self.state = state
        }
        if let zipCode = dictionary["zipCode"] {
            self.zipCode = zipCode
        }
        
    }

}
