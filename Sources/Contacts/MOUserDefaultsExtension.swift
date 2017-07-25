//
//  OMs.swift
//  Contacts
//
//  Created by Olexandr Matviichuk on 7/25/17.
//  Copyright © 2017 Olexandr Matviichuk. All rights reserved.
//

import UIKit

let kOMUserDefaultsRunFirstlyKey = "RunFirstly"

extension UserDefaults {
    var runFirstly: Bool {
        set {
            self.set(newValue, forKey: kOMUserDefaultsRunFirstlyKey)
            self.synchronize()
        }
        get {
            if let firstly = self.value(forKey: kOMUserDefaultsRunFirstlyKey){
                return firstly as! Bool
            } else {
                return true
            }
        }
    }
}
