//
//  ContacCell.swift
//  ContactsBook
//
//  Created by Ivan Kopiev on 21.07.2021.
//

import UIKit
class ContactCell: UITableViewCell {
    //MARK: - Properies
    static let id = "Cell"
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Name"
        label.layer.borderColor = UIColor.black.cgColor
        label.layer.borderWidth = 1
        return label
    }()
    let phoneLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "89999999"
        label.layer.borderColor = UIColor.black.cgColor
        label.layer.borderWidth = 1
        return label
    }()
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    func setUp() {
        addSubview(nameLabel)
        addSubview(phoneLabel)
        createConstraints()
    }
    
    func createConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            nameLabel.trailingAnchor.constraint(equalTo: phoneLabel.leadingAnchor, constant: -10),
            nameLabel.widthAnchor.constraint(lessThanOrEqualToConstant: frame.width/2.5),
            
            phoneLabel.heightAnchor.constraint(equalTo: nameLabel.heightAnchor),
            phoneLabel.topAnchor.constraint(equalTo: nameLabel.topAnchor),
            phoneLabel.bottomAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            phoneLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
            
        ])
        
    }
}

