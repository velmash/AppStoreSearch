//
//  NewFeatureView.swift
//  AppStoreSearch
//
//  Created by 윤형찬 on 4/2/24.
//

import UIKit
import Then
import SnapKit
import RxSwift

class NewFeatureView: BaseView, AppInfoConfigurable {
    private let bag = DisposeBag()
    
    lazy var titleLb = UILabel().then {
        $0.text = "새로운 소식"
        $0.font = .boldSystemFont(ofSize: 22)
        $0.textColor = .black
    }
    
    lazy var versionLb = UILabel().then {
        $0.font = .systemFont(ofSize: 14)
        $0.textColor = .lightGray
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
        self.versionLb.text = "버전 \(appInfo.version)"
        self.descLb.text = appInfo.releaseNotes
        
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
        self.addSubview(titleLb)
        self.addSubview(versionLb)
        self.addSubview(showMoreBtn)
        self.addSubview(descLb)
    }
    
    override func addConstraints() {
        titleLb.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }
        
        versionLb.snp.makeConstraints {
            $0.leading.equalTo(titleLb)
            $0.top.equalTo(titleLb.snp.bottom).offset(3)
        }
        
        showMoreBtn.snp.makeConstraints {
            $0.trailing.bottom.equalToSuperview()
            $0.height.equalTo(17)
        }
    }
    
    private func updateLbConstraint() {
        descLb.snp.remakeConstraints {
            $0.leading.equalTo(titleLb)
            $0.top.equalTo(versionLb.snp.bottom).offset(self.defaultMargin * 2)
            $0.bottom.equalToSuperview()
            if showMoreBtn.isHidden {
                $0.trailing.equalToSuperview().offset(-(self.defaultMargin * 2))
            } else {
                $0.trailing.equalTo(showMoreBtn.snp.leading).offset(-5)
            }
        }
    }
}
