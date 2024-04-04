//
//  DetailView.swift
//  AppStoreSearch
//
//  Created by 윤형찬 on 4/2/24.
//

import UIKit
import Then
import SnapKit

class DetailView: BaseView {
    lazy var backBtn = UIButton().then {
        $0.setImage(UIImage(systemName: "chevron.backward"), for: .normal) // 버튼 이미지 설정
        $0.setTitle("검색", for: .normal) // 버튼 타이틀 설정
        $0.setTitleColor(.systemBlue, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 18)

        $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 5)
        $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: -5)
    }
    
    lazy var scrollView = UIScrollView()
    lazy var contentStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = self.defaultMargin * 2
    }
    
    lazy var appInfoView = AppInfoView()
    lazy var appSubInfoView = AppSubInfoView()
    lazy var newFeatureView = NewFeatureView()
    lazy var preCollectionView = PreCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then { $0.scrollDirection = .horizontal} ).then {
        $0.showsHorizontalScrollIndicator = false
    }
    lazy var appDescView = AppDescView()
    fileprivate let spacer = UIView()
    
    func configure(appInfo: AppResult) {
        let configurableViews: [AppInfoConfigurable] = [appInfoView, appSubInfoView, newFeatureView, appDescView]
        configurableViews.forEach { $0.setUI(appInfo: appInfo) }
    }
    
    override func addSubviews() {
        super.addSubviews()
        
        self.addSubview(backBtn)
        self.addSubview(scrollView)
        scrollView.addSubview(contentStackView)
        
        contentStackView.addArrangedSubview(appInfoView)
        contentStackView.addArrangedSubview(appSubInfoView)
        contentStackView.addArrangedSubview(newFeatureView)
        contentStackView.addArrangedSubview(preCollectionView)
        contentStackView.addArrangedSubview(appDescView)
        contentStackView.addArrangedSubview(spacer)
    }
    
    override func addConstraints() {
        self.backBtn.snp.makeConstraints {
            $0.top.equalToSuperview().offset(topSafetyAreaInset)
            $0.leading.equalToSuperview().offset(5)
            $0.width.equalTo(50)
            $0.height.equalTo(30)
        }
        
        self.appInfoView.snp.makeConstraints {
            $0.height.equalTo(110)
        }
        
        self.appSubInfoView.snp.makeConstraints {
            $0.height.equalTo(50)
        }
        
        self.newFeatureView.snp.makeConstraints {
            $0.height.greaterThanOrEqualTo(80)
        }
        
        self.preCollectionView.snp.makeConstraints {
            $0.height.equalTo(deviceWidth)
        }
        
        self.appDescView.snp.makeConstraints {
            $0.height.greaterThanOrEqualTo(80)
        }
        
        self.spacer.snp.makeConstraints {
            $0.height.equalTo(20)
        }
        
        self.scrollView.snp.makeConstraints {
            $0.top.equalTo(self.backBtn.snp.bottom)
            $0.leading.equalToSuperview().offset(self.defaultMargin)
            $0.trailing.equalToSuperview().offset(-self.defaultMargin)
            $0.bottom.equalToSuperview().offset(-(self.bottomSafetyAreaInset + self.tabBarHeight))
        }
        
        self.contentStackView.snp.makeConstraints {
            $0.edges.equalTo(self.scrollView)
            $0.width.equalTo(scrollView)
        }
    }
}
