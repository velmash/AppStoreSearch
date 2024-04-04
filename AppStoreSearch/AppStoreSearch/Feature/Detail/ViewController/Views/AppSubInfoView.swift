//
//  AppSubInfoView.swift
//  AppStoreSearch
//
//  Created by 윤형찬 on 4/2/24.
//

import UIKit
import Then
import SnapKit
import Kingfisher

class AppSubInfoView: BaseView, AppInfoConfigurable {
    lazy var ratingLb = UILabel().then {
        $0.textColor = .gray
        $0.font = .boldSystemFont(ofSize: 24)
    }
    
    lazy var starView = StarView()
    lazy var starRatingLb = UILabel().then {
        $0.font = .systemFont(ofSize: 12)
        $0.textColor = .lightGray
        $0.text = "0"
    }
    
    lazy var chartLb = UILabel().then {
        $0.textColor = .gray
        $0.font = .boldSystemFont(ofSize: 24)
    }
    
    lazy var genreLb = UILabel().then {
        $0.font = .systemFont(ofSize: 12)
        $0.textColor = .lightGray
    }
    
    lazy var ageLb = UILabel().then {
        $0.textColor = .gray
        $0.font = .boldSystemFont(ofSize: 24)
    }
    
    lazy var ageDescLb = UILabel().then {
        $0.font = .systemFont(ofSize: 12)
        $0.textColor = .lightGray
        $0.text = "연령"
    }
    
    func setUI(appInfo: AppResult) {
        if let rating = appInfo.averageUserRating {
            ratingLb.text = String(rating.roundedToTenth())
        }
        starView.setUI(starRate: appInfo.averageUserRating ?? 0)
        starRatingLb.text = "\(appInfo.userRatingCountForCurrentVersion.formatNumber())개의 평가"
        
        self.chartLb.attributedText = createAttributedString(with: appInfo.trackContentRating, hashtagFont: .boldSystemFont(ofSize: 20), baseFont: .boldSystemFont(ofSize: 24))
        
        genreLb.text = appInfo.genres.first
        ageLb.text = appInfo.contentAdvisoryRating
    }
    
    override func addSubviews() {
        self.addSubview(ratingLb)
        self.addSubview(starView)
        self.addSubview(starRatingLb)
        self.addSubview(chartLb)
        self.addSubview(genreLb)
        self.addSubview(ageLb)
        self.addSubview(ageDescLb)
    }
    
    override func addConstraints() {
        ratingLb.snp.makeConstraints {
            $0.leading.top.equalToSuperview()
        }
        
        let starViewHeight = self.defaultMargin * 2
        starView.snp.makeConstraints {
            $0.leading.equalTo(ratingLb.snp.trailing).offset(5)
            $0.centerY.equalTo(ratingLb.snp.centerY)
            $0.height.equalTo(starViewHeight)
            $0.width.equalTo(starViewHeight * 5)
        }
        
        starRatingLb.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalTo(ratingLb.snp.bottom).offset(3)
        }
        
        chartLb.snp.makeConstraints {
            $0.leading.equalTo(self.snp.centerX).offset(self.defaultMargin * 2)
            $0.centerY.equalTo(ratingLb)
        }
        
        genreLb.snp.makeConstraints {
            $0.top.equalTo(chartLb.snp.bottom).offset(3)
            $0.centerX.equalTo(chartLb)
        }
        
        ageLb.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(self.defaultMargin)
            $0.centerY.equalTo(ratingLb)
        }
        
        ageDescLb.snp.makeConstraints {
            $0.top.equalTo(ageLb.snp.bottom).offset(3)
            $0.centerX.equalTo(ageLb)
        }
    }
    
    private func createAttributedString(with contentRating: String, hashtagFont: UIFont, baseFont: UIFont) -> NSAttributedString {
        let cleanContentRating = contentRating.removingPlusSigns()
        let fullString = "#\(cleanContentRating)"
        
        let attributedString = NSMutableAttributedString(string: fullString, attributes: [.font: baseFont])
        if let hashRange = fullString.range(of: "#") {
            let nsRange = NSRange(hashRange, in: fullString)
            attributedString.addAttribute(.font, value: hashtagFont, range: nsRange)
        }
        
        return attributedString
    }
}
