//
//  ViewController.swift
//  Contacts
//
//  Created by Olexandr Matviichuk on 7/25/17.
//  Copyright © 2017 Olexandr Matviichuk. All rights reserved.
//

import UIKit

let kOMContactCellReuseIdentifier = "ContactCellReuseIdentifier"

class OMContactsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension OMContactsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: kOMContactCellReuseIdentifier)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: kOMContactCellReuseIdentifier)
        }
        return cell!
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5;
    }

}

extension OMContactsViewController: UITableViewDelegate {
    
}

extension OMContactsViewController: UISearchBarDelegate {
    
}
