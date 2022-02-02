//
//  UserDefaultsManager.swift
//  CoreDataApp
//
//  Created by Ibrohimjon on 02/02/2022.
//

import UIKit

class UserDefaultsManager {
    
    let defaults = UserDefaults.standard
    let quoteKey = "quoteKey"
    static let shared = UserDefaultsManager()
    func saveQuote(string: String? ) {
        defaults.set(string ?? "", forKey: quoteKey)
    }
    
    func getQuote() -> String{
    
        return defaults.string(forKey: quoteKey) ?? ""
    }
    
}
