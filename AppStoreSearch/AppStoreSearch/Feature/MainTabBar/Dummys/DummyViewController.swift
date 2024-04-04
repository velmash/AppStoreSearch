//
//  DummyViewController.swift
//  AppStoreSearch
//
//  Created by 윤형찬 on 3/30/24.
//

import UIKit
import Then

class DummyViewController: UIViewController {
    lazy var descLb = UILabel().then {
        $0.text = "구현 미대상"
        $0.textColor = .black
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .systemFont(ofSize: 18)
    }
    
    override func viewDidLoad() {
        self.view.backgroundColor = .white
        
        self.view.addSubview(descLb)
        
        NSLayoutConstraint.activate([
            descLb.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descLb.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
