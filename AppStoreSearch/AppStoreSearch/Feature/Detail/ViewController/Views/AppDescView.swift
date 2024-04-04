//
//  AppDescView.swift
//  AppStoreSearch
//
//  Created by 윤형찬 on 4/2/24.
//

import UIKit
import Then
import SnapKit
import RxSwift

class AppDescView: BaseView, AppInfoConfigurable {
    private let bag = DisposeBag()
    
    lazy var seperator = UIView().then {
        $0.backgroundColor = UIColor(named: "SeperatorGray")
    }
    
    lazy var showMoreBtn = UIButton().then {
        $0.setTitle("더 보기", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 14)
        $0.setTitleColor(.systemBlue, for: .normal)
        $0.backgroundColor = .clear
        $0.isHidden = true
    }
    
    lazy var descLb = UILabel().then {
        $0.font = .systemFont(ofSize: 14)
        $0.textColor = .black
        $0.numberOfLines = 4
        $0.lineBreakMode = .byCharWrapping
    }
    
    func setUI(appInfo: AppResult) {
        self.descLb.text = appInfo.description
        
        if descLb.isTextTruncated() {
            self.showMoreBtn.isHidden = false
        }
        
        self.updateLbConstraint()
    }
    
    override func configureUI() {
        super.configureUI()
        
        showMoreBtn.rx.tap
            .subscribeNext { [weak self] _ in
                self?.descLb.numberOfLines = 0
                self?.showMoreBtn.isHidden = true
            }
            .disposed(by: bag)
    }
    
    override func addSubviews() {
        self.addSubview(seperator)
        self.addSubview(showMoreBtn)
        self.addSubview(descLb)
    }
    
    override func addConstraints() {
        seperator.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        showMoreBtn.snp.makeConstraints {
            $0.trailing.bottom.equalToSuperview()
            $0.height.equalTo(17)
        }
    }
    
    private func updateLbConstraint() {
        descLb.snp.remakeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalTo(seperator.snp.bottom).offset(20)
            $0.bottom.equalToSuperview()
            if showMoreBtn.isHidden {
                $0.trailing.equalToSuperview().offset(-20)
            } else {
                $0.trailing.equalTo(showMoreBtn.snp.leading).offset(-5)
            }
        }
    }
}
