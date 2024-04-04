//
//  Double+Extension.swift
//  AppStoreSearch
//
//  Created by 윤형찬 on 4/2/24.
//

import Foundation

extension Double {
    func roundedToTenth() -> Double {
        return (self * 10).rounded() / 10
    }
}
