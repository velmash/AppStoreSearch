//
//  DetailViewModel.swift
//  AppStoreSearch
//
//  Created by 윤형찬 on 4/2/24.
//

import Foundation
import RxSwift
import RxCocoa

class DetailViewModel: ViewModelType {
    private let bag = DisposeBag()
    
    private let appInfoSubejct = BehaviorSubject<AppResult?>(value: nil)
    
    var appInfoData: AppResult
    
    init(appInfoData: AppResult) {
        self.appInfoData = appInfoData
        appInfoSubejct.onNext(self.appInfoData)
    }
    
    func transform(input: Input) -> Output {
        let appInfoSub = appInfoSubejct.compactMap { $0 }
        
        let appInfoPost = appInfoSub.asDriverOnErrorJustComplete()
        let preCollectionPost = appInfoSub
            .map { $0.screenshotUrls }.asDriverOnErrorJustComplete()
        
        return Output(
            appInfoPost: appInfoPost,
            preCollectionPost: preCollectionPost
        )
    }
}
extension DetailViewModel {
    struct Input {
    }
    
    struct Output {
        let appInfoPost: Driver<AppResult>
        let preCollectionPost: Driver<[String]>
    }
}
