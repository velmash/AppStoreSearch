//
//  StarView.swift
//  AppStoreSearch
//
//  Created by 윤형찬 on 4/2/24.
//

import UIKit
import SnapKit
import Then

class StarView: UIView {
    lazy var stackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.alignment = .fill
        $0.spacing = 0
    }
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
    
    func setUI(starRate: Double) {
        let fullStarImage = UIImage(named: "FullStar")!
        let halfStarImage = UIImage(named: "HalfStar")!
        let lessStarImage = UIImage(named: "LessStar")!
        let overStarImage = UIImage(named: "OverStar")!
        let emptyStarImage = UIImage(named: "EmptyStar")!
        
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        let fullStars = Int(starRate)
        for _ in 0..<fullStars {
            let imageView = UIImageView(image: fullStarImage)
            stackView.addArrangedSubview(imageView)
        }
        
        let fractionalPart = starRate - Double(fullStars)
        if fractionalPart > 0 {
            let imageView: UIImageView
            if fractionalPart <= 0.4 {
                imageView = UIImageView(image: lessStarImage)
            } else if fractionalPart <= 0.5 {
                imageView = UIImageView(image: halfStarImage)
            } else {
                imageView = UIImageView(image: overStarImage)
            }
            stackView.addArrangedSubview(imageView)
        }
        
        for _ in stackView.arrangedSubviews.count..<5 {
            let imageView = UIImageView(image: emptyStarImage)
            stackView.addArrangedSubview(imageView)
        }
    }
    
    private func setView() {
        self.addSubview(stackView)
        
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
