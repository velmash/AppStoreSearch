//
//  MockSearchUseCase.swift
//  AppStoreSearchTests
//
//  Created by 윤형찬 on 4/3/24.
//

import Foundation
import Alamofire
import RxSwift

class MockSearchUseCase: SearchSceneUseCaseProtocol {
    func getSearchInfo(_ param: Parameters) -> Observable<Response<AppSearchResponse>> {
        return NetworkService().appleAPIFetchable(path: "/search", method: .get, param: param)
    }
}
