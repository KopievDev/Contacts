//
//  ContactsController.swift
//  ContactsBook
//
//  Created by Ivan Kopiev on 21.07.2021.
//

import UIKit
import Contacts

class ContactsController: UIViewController {
    // MARK: - Properties
    lazy var contactsTableView: UITableView = {
        let table = UITableView(frame: self.view.frame)
        table.register(ContactCell.self, forCellReuseIdentifier: ContactCell.id)
        table.backgroundColor = .white
        table.dataSource = self
        return table
    }()
    var contacts = [Contact]()
    let contactStore = CNContactStore()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        contacts = getContacts()

    }
    // MARK: - Helpers
    func setUp() {
        title = "Контакты"
        view.addSubview(contactsTableView)
        
    }
    
    func getContacts() -> [Contact] {
        CNContactStore().requestAccess(for: .contacts) { succsess, error in
            guard succsess else {
                print("Not authorized error: \(String(describing: error))")
                return
            }
        }
        
        let keys = [CNContactFormatter.descriptorForRequiredKeys(for: .fullName),CNContactPhoneNumbersKey] as Any
        let request = CNContactFetchRequest(keysToFetch: keys as! [CNKeyDescriptor])
        var contacts = [Contact]()
        do {
            try self.contactStore.enumerateContacts(with: request) {
                (contact, stop) in
                contacts.append(Contact(name: contact.familyName, phone: contact.phoneNumbers.first?.value.stringValue))
            }
        }
        
        catch {
            print("unable to fetch contacts")
            return [Contact]()
        }
        return contacts
    }
    // MARK: - Selectors
}
// MARK: - Extension TableViewDataSource
extension ContactsController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ContactCell.id, for: indexPath) as? ContactCell else {
            return UITableViewCell()
        }
        let contact = contacts[indexPath.row]
        cell.configureCell(with: contact)
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = .lightGray
        }
        return cell
        
    }
}


