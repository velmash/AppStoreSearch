//
//  Response.swift
//  AppStoreSearch
//
//  Created by 윤형찬 on 4/3/24.
//

import Foundation

struct Response<T> {
    let value: T
    let response: URLResponse
}
