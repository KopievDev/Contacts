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
        return table
    }()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    // MARK: - Helpers
    func setUp() {
        title = "Контакты"
        view.addSubview(contactsTableView)
        
    }
    // MARK: - Selectors
}
// MARK: - Extension TableViewDataSource
extension ContactsController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ContactCell.id, for: indexPath) as? ContactCell else {
            return UITableViewCell()
        }
        
        return cell
        
    }
}
