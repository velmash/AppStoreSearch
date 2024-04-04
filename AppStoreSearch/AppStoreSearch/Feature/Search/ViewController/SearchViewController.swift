//
//  ViewController.swift
//  AppStoreSearch
//
//  Created by 윤형찬 on 3/30/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Toast

class SearchViewController: BaseViewController<SearchView> {
    var viewModel: SearchViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func bindViewModel() {
        guard let viewModel = viewModel else { return }
        
        let input = SearchViewModel.Input(
            searchTextInput: contentView.searchAppBar.rx.text.asObservable()
        )
        
        let output = viewModel.transform(input: input)
        
        viewModel.loadInitialRecentSearches()
        
        bindTableViews(output)
        bindSearchBar()
    }
    
    //MARK: TableView 관련 로직
    private func bindTableViews(_ output: SearchViewModel.Output) {
        contentView.recentTableView.rowHeight = 50
        contentView.historyTableView.rowHeight = 40
        
        output.recentSearchPost
            .asObservable()
            .bind(to: contentView.recentTableView.rx.items(cellIdentifier: RecentTableViewCell.reuseIdentifier, cellType: RecentTableViewCell.self)) { row, recentItem, cell in
                cell.configure(title: recentItem)
            }
            .disposed(by: bag)
        
        contentView.recentTableView.rx.itemSelected
            .withLatestFrom(contentView.recentTableView.rx.modelSelected(String.self)) { ($0, $1) }
            .subscribeNext { [weak self] indexPath, recentItem in
                guard let self = self else { return }
                self.executeIfConnected {
                    self.contentView.searchAppBar.text = ""
                    self.contentView.searchAppBar.showsCancelButton = true
                    self.contentView.toggleTitleAndImageView(show: false)
                    if let cancelBtn = self.contentView.searchAppBar.value(forKey: "cancelButton") as? UIButton {
                        cancelBtn.setTitle("취소", for: .normal)
                        cancelBtn.isEnabled = true
                    }
                    
                    self.contentView.searchAppBar.text = recentItem
                    self.contentView.searchResultView.isHidden = false
                    if let inputText = self.contentView.searchAppBar.text {
                        self.viewModel?.getAppInfo(inputText)
                    }
                }
            }
            .disposed(by: bag)
        
        output.historySearchPost
            .asObservable()
            .bind(to: contentView.historyTableView.rx.items(cellIdentifier: HistoryTableViewCell.reuseIdentifier, cellType: HistoryTableViewCell.self)) { row, historyItem, cell in
                cell.configure(title: historyItem)
            }
            .disposed(by: bag)
        
        contentView.historyTableView.rx.itemSelected
            .withLatestFrom(contentView.historyTableView.rx.modelSelected(String.self)) { ($0, $1) }
            .subscribeNext { [weak self] indexPath, historyItem in
                guard let self = self else { return }
                self.contentView.searchAppBar.resignFirstResponder()
                if let cancelBtn = self.contentView.searchAppBar.value(forKey: "cancelButton") as? UIButton {
                    cancelBtn.isEnabled = true
                }
                
                self.executeIfConnected {
                    self.contentView.searchAppBar.text = historyItem
                    self.contentView.searchResultView.isHidden = false
                    if let inputText = self.contentView.searchAppBar.text {
                        self.viewModel?.getAppInfo(inputText)
                    }
                }
            }
            .disposed(by: bag)
        
        output.appResultPost
            .asObservable()
            .bind(to: contentView.searchResultTableView.rx.items(cellIdentifier: SearchResultTableViewCell.reuseIdentifier, cellType: SearchResultTableViewCell.self)) { row, appInfo, cell in
                cell.configure(appInfo: appInfo)
            }
            .disposed(by: bag)
        
        contentView.searchResultTableView.rx.itemSelected
            .withLatestFrom(contentView.searchResultTableView.rx.modelSelected(AppResult.self)) { ($0, $1) }
            .subscribeNext { [weak self] indexPath, appInfo in
                let viewModel = DetailViewModel(appInfoData: appInfo)
                let detailVC = DetailViewController()
                detailVC.viewModel = viewModel
                self?.navigationController?.pushViewController(detailVC, animated: true)
            }
            .disposed(by: bag)
    }
    
    //MARK: UISearchBar Delegate / Keyboard 관련 로직
    private func bindSearchBar() {
        contentView.searchAppBar.rx.textDidBeginEditing
            .asDriverOnErrorJustComplete()
            .driveNext { [weak self] _ in
                self?.contentView.searchAppBar.showsCancelButton = true // 취소 버튼 표시
                if let cancelBtn = self?.contentView.searchAppBar.value(forKey: "cancelButton") as? UIButton {
                    cancelBtn.setTitle("취소", for: .normal)
                    self?.contentView.toggleTitleAndImageView(show: false)
                }
            }
            .disposed(by: bag)
        
        contentView.searchAppBar.rx.cancelButtonClicked
            .asDriverOnErrorJustComplete()
            .driveNext { [weak self] _ in
                self?.contentView.searchAppBar.setShowsCancelButton(false, animated: true)
                self?.contentView.toggleTitleAndImageView(show: true)
                  
                self?.contentView.searchAppBar.text = ""
                self?.contentView.searchAppBar.resignFirstResponder()
            }
            .disposed(by: bag)
        
        contentView.searchAppBar.rx.searchButtonClicked
            .asDriverOnErrorJustComplete()
            .driveNext { [weak self] _ in
                guard let self = self else { return }
                self.contentView.searchAppBar.resignFirstResponder()
                if let cancelButton = self.contentView.searchAppBar.value(forKey: "cancelButton") as? UIButton {
                    cancelButton.isEnabled = true
                }
                
                self.executeIfConnected {
                    self.contentView.searchResultView.isHidden = false
                    if let text = self.contentView.searchAppBar.text, !text.isEmpty {
                        self.viewModel?.getAppInfo(text)
                    }
                }
            }
            .disposed(by: bag)
        
        contentView.searchAppBar.rx.text.orEmpty
            .subscribeNext { [weak self] _ in
                self?.contentView.searchResultView.isHidden = true
            }
            .disposed(by: bag)
        
        NotificationCenter.default.rx.notification(UIResponder.keyboardWillShowNotification)
            .map { notification -> CGFloat in
                // 키보드 높이 추출
                if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                    let keyboardHeight = keyboardFrame.cgRectValue.height
                    return keyboardHeight
                }
                return 0
            }
            .subscribeNext { [weak self] keyboardHeight in
                self?.contentView.historyTableView.snp.updateConstraints {
                    $0.bottom.equalToSuperview().offset(-(keyboardHeight - (self?.contentView.bottomSafetyAreaInset ?? 0) - (self?.contentView.tabBarHeight ?? 0)))
                }
            }
            .disposed(by: bag)
        
        NotificationCenter.default.rx.notification(UIResponder.keyboardWillHideNotification)
            .subscribeNext { [weak self] keyboardHeight in
                self?.contentView.historyTableView.snp.updateConstraints {
                    $0.bottom.equalToSuperview()
                }
            }
            .disposed(by: bag)
    }
    
    
    //네트워크 미연결 확인 로직
    private func executeIfConnected(_ action: @escaping () -> Void) {
        isConnectedNetwork { [weak self] isConnected in
            guard let self = self, isConnected else {
                self?.contentView.makeToast("네트워크 연결 불량")
                return
            }
            action()
        }
    }
}
