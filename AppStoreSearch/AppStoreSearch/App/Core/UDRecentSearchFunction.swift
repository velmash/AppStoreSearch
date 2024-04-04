//
//  UserDefaultsKeys.swift
//  AppStoreSearch
//
//  Created by 윤형찬 on 3/31/24.
//

import Foundation

class UDRecentSearchFunction: UDRecentSearchFunctionProtocol {
    static let shared = UDRecentSearchFunction()
    
    private init() {}
    private let UDRecent = "RECENTSEARCH"
    
    func getStringArrayFromUserDefaults() -> [String] {
        return UserDefaults.standard.stringArray(forKey: UDRecent) ?? []
    }
    
    func saveArrayToUserDefaults(array: [String]) {
        UserDefaults.standard.set(array, forKey: UDRecent)
    }
    
    func addStringToArrayInUserDefaults(newString: String) {
        var array = getStringArrayFromUserDefaults()
        if let existingIndex = array.firstIndex(of: newString) {
            array.remove(at: existingIndex)
        }
        
        array.insert(newString, at: 0)
        
        saveArrayToUserDefaults(array: array)
    }
    
    func searchStringsContaining(searchString: String) -> [String] {
        let array = getStringArrayFromUserDefaults()
        
        let filteredArray = array.filter { $0.contains(searchString) }
        return filteredArray
    }
}
