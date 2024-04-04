//
//  HistoryTableViewCell.swift
//  AppStoreSearch
//
//  Created by 윤형찬 on 4/1/24.
//

import UIKit
import Then
import SnapKit

class HistoryTableViewCell: UITableViewCell {
    static var reuseIdentifier = "HistoryTableViewCell"
    
    lazy var imgView = UIImageView().then {
        $0.image = UIImage(systemName: "magnifyingglass")
        $0.contentMode = .scaleAspectFit
        $0.tintColor = .lightGray
    }
    
    lazy var titleLb = UILabel().then {
        $0.font = .systemFont(ofSize: 16)
        $0.textColor = .black
    }
    
    func configure(title: String) {
        self.backgroundColor = .white
        self.titleLb.text = title
        
        setupView()
        setupConstraint()
    }
    
    private func setupView() {
        self.selectionStyle = .none
        
        contentView.addSubview(imgView)
        contentView.addSubview(titleLb)
    }
    
    private func setupConstraint() {
        imgView.snp.makeConstraints {
            $0.size.equalTo(20)
            $0.leading.equalToSuperview().offset(15)
            $0.centerY.equalToSuperview()
        }
        
        titleLb.snp.makeConstraints {
            $0.leading.equalTo(imgView.snp.trailing).offset(10)
            $0.centerY.equalToSuperview()
        }
    }
}
