//
//  ViewModelType.swift
//  AppStoreSearch
//
//  Created by 윤형찬 on 3/31/24.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
