//
//  Agent.swift
//  AppStoreSearch
//
//  Created by 윤형찬 on 3/31/24.
//

import Foundation
import Alamofire
import RxSwift

let REQUEST_TIMEOUT = 15

enum APIError: Error {
    case http(ErrorData)
    case noData
    case dataParsingFail
    case requestTimeOut
    case unknown
}
struct ErrorData: Codable {
    var status: Int
    var message: String
    var error: String?
}

struct Agent {
    init() {
        AF.sessionConfiguration.timeoutIntervalForRequest = TimeInterval(REQUEST_TIMEOUT)
    }
    
    func run<T: Decodable>(_ request: DataRequest, _ decoder: JSONDecoder = JSONDecoder(), pathForIndicator: AppleAPIPath) -> Observable<Response<T>> {
        
        return Observable.create { observer in
            request.responseDecodable(of: T.self) { result in
                switch result.result {
                case .success:
                    if let data = result.data, let response = result.response {
                        let value = try? decoder.decode(T.self, from: data)
                        if let value = value {
                            observer.on(.next(Response(value: value, response: response)))
                            observer.on(.completed)
                        } else {
                            
                            if let errorData = try? decoder.decode(ErrorData.self, from: data) {
                                observer.on(.error(APIError.http(errorData)))
                            } else {
                                observer.on(.error(APIError.dataParsingFail))
                            }
                        }
                    } else {
                        observer.on(.error(APIError.requestTimeOut))
                    }
                case let .failure(error):
                    print("Error", error)
                    observer.on(.error(error as Error))
                }
            }
            return Disposables.create {
                request.cancel()
            }
        }
    }
}
