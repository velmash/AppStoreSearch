//
//  SearbarBgView.swift
//  AppStoreSearch
//
//  Created by 윤형찬 on 4/1/24.
//

import UIKit
import SnapKit
import Then

class SearchbarBgView: UIView {
    lazy var seperator = UIView().then {
        $0.backgroundColor = UIColor(named: "SeperatorGray")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setView()
    }
    
    func setUI(isHidden: Bool) {
        self.backgroundColor = isHidden ? .clear : UIColor(named: "BgGray")
        self.seperator.isHidden = isHidden
    }
    
    private func setView() {
        self.addSubview(seperator)
        
        seperator.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
}
