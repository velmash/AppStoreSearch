//
//  BaseView.swift
//  AppStoreSearch
//
//  Created by 윤형찬 on 3/31/24.
//

import UIKit

class BaseView: UIView {
    let deviceHeight = UIScreen.main.bounds.height
    let deviceWidth = UIScreen.main.bounds.width
    let topSafetyAreaInset = (UIApplication.shared.connectedScenes.first as! UIWindowScene).windows.first!.safeAreaInsets.top
    let bottomSafetyAreaInset = (UIApplication.shared.connectedScenes.first as! UIWindowScene).windows.first!.safeAreaInsets.bottom
    let tabBarHeight: CGFloat = 48
    let defaultMargin: CGFloat = 10
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
    }
    
    func configureUI() {
        self.backgroundColor = .white
        
        addSubviews()
        addConstraints()
    }
    
    func addSubviews() { }
    func addConstraints() { }
}

