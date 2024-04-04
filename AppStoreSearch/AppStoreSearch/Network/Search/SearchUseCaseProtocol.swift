//
//  SearchUseCaseProtocol.swift
//  AppStoreSearch
//
//  Created by 윤형찬 on 4/3/24.
//

import Foundation
import Alamofire
import RxSwift

protocol SearchSceneUseCaseProtocol {
    func getSearchInfo(_ param: Parameters) -> Observable<Response<AppSearchResponse>>
}
