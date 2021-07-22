//
//  ContactsController.swift
//  ContactsBook
//
//  Created by Ivan Kopiev on 21.07.2021.
//

import UIKit

class ContactsController: UIViewController {
    // MARK: - Properties
    lazy var contactsTableView: UITableView = {
        let table = UITableView(frame: self.view.frame)
        table.register(ContactCell.self, forCellReuseIdentifier: ContactCell.id)
        table.backgroundColor = .white
        table.dataSource = self
        table.delegate = self
        table.separatorStyle = .none
        return table
    }()
    var contacts = [Contact]()
    let contactProvider: ContactProviderProtocol!
    
    // MARK: - Lifecycle
    
    init(contactProvider: ContactProviderProtocol) {
        self.contactProvider = contactProvider
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    // MARK: - Helpers
    func setUp() {
        title = "Контакты"
        view.addSubview(contactsTableView)
        contactProvider.getContacts { contacts in
            self.contacts = contacts
        }
    }
    
    func callTo(number: String) {
        guard let url = URL(string: "tel://\(number)") else {
            print(number)
            return
        }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
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
        colorFor(cell: cell, at: indexPath)
        return cell
        
    }
    func colorFor(cell: ContactCell, at indexPath: IndexPath) {
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = .lightGray
        }else {
            cell.backgroundColor = .white
        }
    }
}

// MARK: - Extension TableViewDelegate
extension ContactsController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        callTo(number: contacts[indexPath.row].phone ?? "69")
    }
}

