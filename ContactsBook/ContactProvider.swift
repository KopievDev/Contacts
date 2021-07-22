//
//  ContactProvider.swift
//  ContactsBook
//
//  Created by Ivan Kopiev on 22.07.2021.
//

import Foundation
import Contacts


class ContactProvider: ContactProviderProtocol {
    let contactStore = CNContactStore()

    func getContacts(_ comletion: @escaping (([Contact]) -> Void)) {
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
            comletion( [Contact]())
        }
        comletion(contacts)
    }
}
