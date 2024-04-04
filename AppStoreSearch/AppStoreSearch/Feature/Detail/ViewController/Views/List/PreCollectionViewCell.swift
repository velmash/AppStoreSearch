//
//  PreCollectionViewCell.swift
//  AppStoreSearch
//
//  Created by 윤형찬 on 4/2/24.
//

import UIKit
import Then
import SnapKit
import Kingfisher

class PreCollectionViewCell: UICollectionViewCell {
    static var reuseIdentifier = "PreCollectionViewCell"
    
    lazy var screenshotImgView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor(named: "SeperatorGray")?.cgColor
    }
    
    func configure(url: String) {
        self.backgroundColor = .white
        
        screenshotImgView.kf.setImage(with: URL(string: url))
        
        setupView()
        setupConstraint()
    }
    
    private func setupView() {
        contentView.addSubview(screenshotImgView)
    }
    
    private func setupConstraint() {
        screenshotImgView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
