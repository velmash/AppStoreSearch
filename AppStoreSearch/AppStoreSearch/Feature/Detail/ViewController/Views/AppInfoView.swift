//
//  AppInfoView.swift
//  AppStoreSearch
//
//  Created by 윤형찬 on 4/2/24.
//

import UIKit
import Then
import SnapKit
import Kingfisher

class AppInfoView: BaseView, AppInfoConfigurable {
    lazy var appIconImgView = UIImageView().then {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = self.defaultMargin
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor(named: "SeperatorGray")?.cgColor
    }
    
    lazy var appTitleLb = UILabel().then {
        $0.text = "앱 타이틀"
        $0.font = .boldSystemFont(ofSize: 22)
        $0.textColor = .black
    }
    
    lazy var appSubTitleLb = UILabel().then {
        $0.text = "앱 부제"
        $0.font = .systemFont(ofSize: 15)
        $0.textColor = .gray
    }
    
    lazy var downloadBtn = UIButton().then {
        $0.setTitle("받기", for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 15
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .systemBlue
    }
    
    lazy var moreBtn = UIButton().then {
        $0.setImage(UIImage(systemName: "ellipsis.circle.fill"), for: .normal)
        $0.tintColor = .systemBlue
        $0.contentHorizontalAlignment = .fill
        $0.contentVerticalAlignment = .fill
        $0.imageView?.contentMode = .scaleAspectFit
    }
    
    func setUI(appInfo: AppResult) {
        appIconImgView.kf.setImage(with: URL(string: appInfo.artworkUrl512))
        self.appTitleLb.text = appInfo.trackName
        self.appSubTitleLb.text = appInfo.artistName
    }
    
    override func addSubviews() {
        self.addSubview(appIconImgView)
        self.addSubview(appTitleLb)
        self.addSubview(appSubTitleLb)
        self.addSubview(downloadBtn)
        self.addSubview(moreBtn)
    }
    
    override func addConstraints() {
        appIconImgView.snp.makeConstraints {
            $0.size.equalTo(100)
            $0.leading.bottom.equalToSuperview()
        }
        
        appTitleLb.snp.makeConstraints {
            $0.leading.equalTo(appIconImgView.snp.trailing).offset(self.defaultMargin)
            $0.trailing.equalToSuperview().inset(self.defaultMargin)
            $0.top.equalTo(appIconImgView.snp.top)
        }
        
        appSubTitleLb.snp.makeConstraints {
            $0.leading.equalTo(appTitleLb)
            $0.top.equalTo(appTitleLb.snp.bottom)
            $0.trailing.equalTo(appTitleLb.snp.trailing)
        }
        
        let btnHeight: CGFloat = self.defaultMargin * 3
        downloadBtn.snp.makeConstraints {
            $0.leading.equalTo(appTitleLb)
            $0.bottom.equalToSuperview()
            $0.height.equalTo(btnHeight)
            $0.width.equalTo(btnHeight * 2.3)
        }
        
        moreBtn.snp.makeConstraints {
            $0.size.equalTo(btnHeight)
            $0.bottom.equalToSuperview()
            $0.trailing.equalTo(appTitleLb.snp.trailing)
        }
    }
}
