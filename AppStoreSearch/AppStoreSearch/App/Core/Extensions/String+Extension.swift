//
//  String+Extension.swift
//  AppStoreSearch
//
//  Created by 윤형찬 on 4/2/24.
//

import Foundation

extension String {
    func removingPlusSigns() -> String {
        return self.replacingOccurrences(of: "+", with: "")
    }
}
