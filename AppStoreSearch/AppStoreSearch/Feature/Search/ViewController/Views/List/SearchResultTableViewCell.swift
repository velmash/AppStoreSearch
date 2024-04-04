//
//  SearchResultTableViewCell.swift
//  AppStoreSearch
//
//  Created by 윤형찬 on 4/2/24.
//

import UIKit
import Then
import SnapKit
import Kingfisher

class SearchResultTableViewCell: UITableViewCell {
    static var reuseIdentifier = "SearchResultTableView"
    
    lazy var appIconImgView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.tintColor = .lightGray
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor(named: "SeperatorGray")?.cgColor
    }
    
    lazy var titleLb = UILabel().then {
        $0.text = "앱 명칭"
        $0.font = .systemFont(ofSize: 18)
        $0.textColor = .black
    }
    
    lazy var subTitleLb = UILabel().then {
        $0.text = "앱 부제"
        $0.font = .systemFont(ofSize: 13)
        $0.textColor = .gray
    }
    
    lazy var starView = StarView()
    
    lazy var starRatingLb = UILabel().then {
        $0.font = .systemFont(ofSize: 13)
        $0.textColor = .lightGray
        $0.text = "0"
    }
    
    lazy var downloadBtn = UIButton().then {
        $0.setTitle("받기", for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 15
        $0.setTitleColor(.systemBlue, for: .normal)
        $0.backgroundColor = UIColor(named: "SeperatorGray")
    }
    
    lazy var preStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.alignment = .fill
        $0.spacing = 5
    }
    
    func configure(appInfo: AppResult) {
        self.backgroundColor = .white
        
        appIconImgView.kf.setImage(with: URL(string: appInfo.artworkUrl512))
        self.titleLb.text = appInfo.trackName
        self.subTitleLb.text = appInfo.artistName//trackCensoredName
        self.starRatingLb.text = appInfo.userRatingCountForCurrentVersion.formatNumber()//appInfo.averageUserRating
        
        preStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        let screenshotUrls = Array(appInfo.screenshotUrls.prefix(3))
        for url in screenshotUrls {
            let imageView = createPreviewImageView()
            imageView.kf.setImage(with: URL(string: url))
            preStackView.addArrangedSubview(imageView)
        }
        
        starView.setUI(starRate: appInfo.averageUserRating ?? 0)
        
        setupView()
        setupConstraint()
    }
    
    private func setupView() {
        self.selectionStyle = .none
        
        contentView.addSubview(appIconImgView)
        contentView.addSubview(titleLb)
        contentView.addSubview(subTitleLb)
        contentView.addSubview(starView)
        contentView.addSubview(starRatingLb)
        contentView.addSubview(downloadBtn)
        contentView.addSubview(preStackView)
    }
    
    private func setupConstraint() {
        appIconImgView.snp.makeConstraints {
            $0.size.equalTo(70)
            $0.leading.equalToSuperview()
            $0.top.equalToSuperview()
        }
        
        downloadBtn.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.centerY.equalTo(appIconImgView.snp.centerY)
            $0.height.equalTo(30)
            $0.width.equalTo(downloadBtn.snp.height).multipliedBy(2.5)
        }
        
        titleLb.snp.makeConstraints {
            $0.leading.equalTo(appIconImgView.snp.trailing).offset(10)
            $0.trailing.equalTo(downloadBtn.snp.leading).offset(-10)
            $0.top.equalTo(appIconImgView.snp.top)
        }
        
        subTitleLb.snp.makeConstraints {
            $0.leading.equalTo(titleLb.snp.leading)
            $0.trailing.equalTo(downloadBtn.snp.leading).offset(-10)
            $0.centerY.equalTo(appIconImgView)
        }
        
        let starViewHeight = 15
        starView.snp.makeConstraints {
            $0.leading.equalTo(titleLb.snp.leading)
            $0.bottom.equalTo(appIconImgView.snp.bottom)
            $0.width.equalTo(starViewHeight * 5)
            $0.height.equalTo(starViewHeight)
        }
        
        starRatingLb.snp.makeConstraints {
            $0.leading.equalTo(starView.snp.trailing).offset(5)
            $0.centerY.equalTo(starView.snp.centerY)
        }
        
        let stackWidth = UIScreen.main.bounds.width - 20
        preStackView.snp.makeConstraints {
            $0.top.equalTo(appIconImgView.snp.bottom).offset(20)
            $0.leading.equalTo(appIconImgView.snp.leading)
            $0.trailing.equalTo(downloadBtn.snp.trailing)
            $0.bottom.equalToSuperview().inset(40)
            $0.height.equalTo(stackWidth * 0.7)
        }
    }
    
    private func createPreviewImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor(named: "SeperatorGray")?.cgColor//UIColor.lightGray.cgColor
        
        return imageView
    }
}
