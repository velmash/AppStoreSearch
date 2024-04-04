//
//  Service.swift
//  AppStoreSearch
//
//  Created by 윤형찬 on 3/31/24.
//

import Foundation
import RxSwift
import Alamofire

typealias AppleAPIPath = String

struct NetworkService {
    static let agent = Agent()
    
    private let schemeHTTPS = "https"
    private let appleUrl = "itunes.apple.com"
    
    func appleAPIFetchable<T>(path: String, method: HTTPMethod = .post, param: [String:Any]? = nil) -> Observable<Response<T>> where T: Decodable {
        
        let url = self.makeAppleAPIURL(path)
        
        var defaultParam = Parameters()
        defaultParam["country"] = "KR"
        defaultParam["entity"] = "software"
        
        if let param = param {
            for (key, value) in param {
                defaultParam[key] = value
            }
        }
        
        let dataRequest = AF.request(url, method: method, parameters: defaultParam, encoding: method == .get ? URLEncoding.default : JSONEncoding.default)
        print("서버 요청", url)
        
        return NetworkService.agent.run(dataRequest, pathForIndicator: path)
    }
}


extension NetworkService {
    
    func makeAppleAPIURL(_ functionPath: AppleAPIPath) -> URLComponents {
        var components = URLComponents()
        components.scheme = schemeHTTPS
        components.host = appleUrl
        components.path = functionPath
        
        return components
    }
}
