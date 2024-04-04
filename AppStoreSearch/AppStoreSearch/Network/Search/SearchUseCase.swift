//
//  SearchUseCase.swift
//  AppStoreSearch
//
//  Created by 윤형찬 on 3/31/24.
//

import Foundation
import RxSwift
import Alamofire

enum SearchSceneURL: AppleAPIPath {
    case search = "/search"
}

class SearchSceneUseCase: SearchSceneUseCaseProtocol {
    func getSearchInfo(_ param: Parameters) -> Observable<Response<AppSearchResponse>> {
        return NetworkService().appleAPIFetchable(path: SearchSceneURL.search.rawValue, method: .get, param: param)
    }
}

