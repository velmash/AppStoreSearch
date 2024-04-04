//
//  SearchView.swift
//  AppStoreSearch
//
//  Created by 윤형찬 on 3/31/24.
//

import UIKit
import FlexLayout
import PinLayout

/*
 카카오뱅크에서 사용중인 FlexLayout 기술 스택을 적용하고 싶었으나
 시간 관계상 기존에 개발하던 방식으로 변경하여 작업하였습니다.
 감사합니다.
 */


class SearchView: BaseView {
    private var titleBarViewHeight = 43
    
    fileprivate let rootFlexContainer = UIView()
    fileprivate let titleAndImageViewContainer = UIView()
    fileprivate let searchingView = UIView().then {
        $0.backgroundColor = .white
    }
    lazy var searchResultView = UIView()
    
    lazy var searchbarBgView = SearchbarBgView().then {
        $0.backgroundColor = .clear
        $0.setUI(isHidden: true)
    }
    
    lazy var titleLb = UILabel().then {
        $0.text = "검색"
        $0.font = .boldSystemFont(ofSize: 36)
    }
    
    lazy var imgView = UIImageView().then {
        $0.image = UIImage(systemName: "person.crop.circle")
    }
    
    lazy var searchAppBar = UISearchBar().then {
        $0.backgroundImage = UIImage() //Seperator 삭제
        $0.placeholder = "게임, 앱, 스토리 등"
    }
    
    lazy var recentLb = UILabel().then {
        $0.text = "최근 검색어"
        $0.font = .boldSystemFont(ofSize: 28)
    }
    
    lazy var recentTableView = RecentTableView()
    lazy var historyTableView = HistoryTableView()
    lazy var searchResultTableView = SearchResultTableView()
    
    override func configureUI() {
        super.configureUI()
        self.setSearchBarBackground()
        
        searchingView.isHidden = true
        searchResultView.isHidden = true
        
        self.addSubview(rootFlexContainer)
        self.addSubview(searchingView)
        self.addSubview(searchResultView)
        
        searchingView.addSubview(historyTableView)
        searchResultView.addSubview(searchResultTableView)
        
        titleAndImageViewContainer.flex.direction(.row).justifyContent(.spaceBetween).define { flex in
            flex.addItem(titleLb).grow(1).marginLeft(self.defaultMargin)
            flex.addItem(imgView).aspectRatio(1).marginRight(self.defaultMargin)
        }

        rootFlexContainer.flex.direction(.column).padding(self.defaultMargin).define { flex in
            flex.addItem(titleAndImageViewContainer).height(CGFloat(titleBarViewHeight))
            
            flex.addItem().define {
                $0.addItem(searchAppBar).grow(1)
            }
            
            flex.addItem().marginTop(40).define { flex in
                flex.addItem(recentLb).marginLeft(self.defaultMargin)
            }
            
            flex.addItem(recentTableView).marginTop(self.defaultMargin).marginLeft(self.defaultMargin).height(UIScreen.main.bounds.height).shrink(1)
        }
        
        searchingView.snp.makeConstraints {
            $0.top.equalTo(searchbarBgView.snp.bottom).offset(self.defaultMargin)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(rootFlexContainer.snp.bottom)
        }
        
        searchResultView.snp.makeConstraints {
            $0.edges.equalTo(searchingView)
        }
        
        historyTableView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalToSuperview().offset(self.defaultMargin)
            $0.trailing.equalToSuperview().inset(self.defaultMargin)
        }
        
        searchResultTableView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalToSuperview().offset(self.defaultMargin)
            $0.trailing.equalToSuperview().inset(self.defaultMargin)
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        rootFlexContainer.pin.all(pin.safeArea)
        rootFlexContainer.flex.layout()
    }
    
    func toggleTitleAndImageView(show: Bool) {
        self.titleAndImageViewContainer.flex.height(show ? 43 : 0).markDirty()
        self.searchingView.isHidden = show
        
        if show {
            searchResultView.isHidden = show
        }
        
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let self = self else { return }
            
            self.searchbarBgView.setUI(isHidden: show)
            self.rootFlexContainer.flex.layout()
            self.layoutIfNeeded()
        }
    }
    
    private func setSearchBarBackground() {
        self.addSubview(searchbarBgView)
        searchbarBgView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(66 + topSafetyAreaInset)
        }
    }
}
