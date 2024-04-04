//
//  UDRecentSearchFunctionProtocol.swift
//  AppStoreSearch
//
//  Created by 윤형찬 on 3/31/24.
//

import Foundation

protocol UDRecentSearchFunctionProtocol {
    func getStringArrayFromUserDefaults() -> [String]
    func addStringToArrayInUserDefaults(newString: String)
    func searchStringsContaining(searchString: String) -> [String]
}
