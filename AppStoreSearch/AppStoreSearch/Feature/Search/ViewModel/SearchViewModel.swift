//
//  SearchViewModel.swift
//  AppStoreSearch
//
//  Created by 윤형찬 on 3/31/24.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire

class SearchViewModel: ViewModelType {
    private let bag = DisposeBag()
    private let useCase = SearchSceneUseCase()
    private let udManager = UDRecentSearchFunction.shared
    
    private let recentSearchSubject = BehaviorRelay<[String]>(value: [])
    private let appResultSubject = PublishSubject<[AppResult]>()
    
    func transform(input: Input) -> Output {
        let recentSearchPost = recentSearchSubject.asDriverOnErrorJustComplete()
        let appResultPost = appResultSubject.asDriverOnErrorJustComplete()
        
        let historySearchPost =  input.searchTextInput
            .filter { $0 != "" }
            .observe(on: MainScheduler.instance)
            .map { [weak self] text -> [String] in
                guard let inputText = text else { return [] }
                let result = self?.udManager.searchStringsContaining(searchString: inputText)
                return result ?? []
            }
            .asDriverOnErrorJustComplete()
        
        return Output(
            recentSearchPost: recentSearchPost,
            historySearchPost: historySearchPost,
            appResultPost: appResultPost
        )
    }
    
    func loadInitialRecentSearches() {
        let recentSearches = udManager.getStringArrayFromUserDefaults()
        self.recentSearchSubject.accept(recentSearches)
    }
    
    func getAppInfo(_ input: String) {
        self.appResultSubject.onNext([]) // 검색 시 다시 흰배경 표출 (앱스토어와 동일)
        
        udManager.addStringToArrayInUserDefaults(newString: input)
        self.recentSearchSubject.accept(udManager.getStringArrayFromUserDefaults())
        
        let param: Parameters = ["term" : input]
        useCase.getSearchInfo(param)
            .compactMap { $0.value.results }
            .withUnretained(self)
            .subscribeNext { owner, value in
                owner.appResultSubject.onNext(value)
            }
            .disposed(by: bag)
    }
}

extension SearchViewModel {
    struct Input {
        let searchTextInput: Observable<String?>
    }
    
    struct Output {
        let recentSearchPost: Driver<[String]>
        let historySearchPost: Driver<[String]>
        let appResultPost: Driver<[AppResult]>
    }
}
