//
//  RecentTableViewCell.swift
//  AppStoreSearch
//
//  Created by 윤형찬 on 4/1/24.
//

import UIKit
import Then
import SnapKit

class RecentTableViewCell: UITableViewCell {
    static var reuseIdentifier = "RecentTableViewCell"
    
    lazy var seperator = UIView().then {
        $0.backgroundColor = UIColor(named: "SeperatorGray")
    }
    
    lazy var titleLb = UILabel().then {
        $0.font = .systemFont(ofSize: 22)
        $0.textColor = .systemBlue
    }
    
    func configure(title: String) {
        self.backgroundColor = .white
        self.titleLb.text = title
        
        setupView()
        setupConstraint()
    }
    
    private func setupView() {
        self.selectionStyle = .none
        
        contentView.addSubview(seperator)
        contentView.addSubview(titleLb)
    }
    
    private func setupConstraint() {
        seperator.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        titleLb.snp.makeConstraints {
            $0.leading.centerY.equalToSuperview()
        }
    }
}
