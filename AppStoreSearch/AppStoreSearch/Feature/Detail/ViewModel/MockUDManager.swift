//
//  MockUDManager.swift
//  AppStoreSearchTests
//
//  Created by 윤형찬 on 4/3/24.
//

import Foundation

class MockUDManager: UDRecentSearchFunctionProtocol {
    var recentSearches: [String] = ["1258016944", "38213462", "카카오뱅크"]
    
    func getStringArrayFromUserDefaults() -> [String] {
        return recentSearches
    }
    
    func addStringToArrayInUserDefaults(newString: String) {
        recentSearches.append(newString)
    }
    
    func searchStringsContaining(searchString: String) -> [String] {
        return recentSearches.filter { $0.contains(searchString) }
    }
}
