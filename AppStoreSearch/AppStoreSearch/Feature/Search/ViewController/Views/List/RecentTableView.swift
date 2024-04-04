//
//  RecentTableView.swift
//  AppStoreSearch
//
//  Created by 윤형찬 on 4/1/24.
//

import UIKit

class RecentTableView: UITableView {
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        self.register(RecentTableViewCell.self, forCellReuseIdentifier: RecentTableViewCell.reuseIdentifier)
        self.isScrollEnabled = true
        self.separatorStyle = .none
        self.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
