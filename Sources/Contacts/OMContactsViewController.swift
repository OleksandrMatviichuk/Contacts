//
//  ViewController.swift
//  Contacts
//
//  Created by Olexandr Matviichuk on 7/25/17.
//  Copyright © 2017 Olexandr Matviichuk. All rights reserved.
//

import UIKit

private let kOMContactCellReuseIdentifier = "ContactCellReuseIdentifier"
private let kOMContactsScreenAddSegueIdentifier = "contactsScreenAddSegueIdentifier"
private let kOMContactsScreenOpenContactIdentifier = "ContactsScreenOpenContactIdentifier"

class OMContactsViewController: UIViewController {
    
    @IBOutlet weak var contactsTableView: UITableView!
    
    var allContacts = [OMLocalContact]()
    var visibleContacts = [OMLocalContact]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        allContacts = OMContactsStorage.sharedStorage.contacts()
        visibleContacts = allContacts
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier  == kOMContactsScreenOpenContactIdentifier {
            let vc = segue.destination as! OMContactInfoViewController
            let selectedRowIndexPath = contactsTableView.indexPathForSelectedRow
            contactsTableView.deselectRow(at: selectedRowIndexPath!, animated: false)
            vc.contact = visibleContacts[selectedRowIndexPath!.row]
        }
    }
}

extension OMContactsViewController: UITableViewDataSource {
    
    func makeContactName(contact: OMLocalContact) -> String {
        return "\(contact.firstName) \(contact.lastName)"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: kOMContactCellReuseIdentifier)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: kOMContactCellReuseIdentifier)
        }
        let contact = visibleContacts[indexPath.row]
        cell?.textLabel?.text = makeContactName(contact: contact)
        return cell!
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return visibleContacts.count
    }

}

extension OMContactsViewController: UITableViewDelegate {
    
}

extension OMContactsViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            visibleContacts = allContacts
        } else {
            visibleContacts = []
            for contact in allContacts {
                if makeContactName(contact: contact).lowercased().contains(searchText.lowercased()) {
                    visibleContacts.append(contact)
                }
            }
        }
        contactsTableView.reloadData()       
    }
}
