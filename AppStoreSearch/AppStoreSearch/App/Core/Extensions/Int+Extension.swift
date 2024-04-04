//
//  Int+Extension.swift
//  AppStoreSearch
//
//  Created by 윤형찬 on 4/2/24.
//

import Foundation

extension Int {
    func formatNumber() -> String {
        if self >= 10000 {
            // 만 단위 이상인 경우 소수점 한 자리까지 "만" 단위로 표현
            let formattedNumber = Double(self) / 10000.0
            return String(format: "%.1f만", formattedNumber)
        } else if self >= 1000 {
            // 천 단위인 경우 반올림하여 "-천"으로 표현
            let thousands = round(Double(self) / 1000)
            return "\(Int(thousands))천"
        } else {
            // 백 단위인 경우 숫자 그대로 표현
            return "\(self)"
        }
    }
    
}
