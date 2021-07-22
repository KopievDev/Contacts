//
//  Protocol.swift
//  ContactsBook
//
//  Created by Ivan Kopiev on 22.07.2021.
//

import Foundation

protocol ContactProviderProtocol {
    func getContacts(_ comletion: @escaping (([Contact])->Void))
}
