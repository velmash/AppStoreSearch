//
//  HistoryTableview.swift
//  AppStoreSearch
//
//  Created by 윤형찬 on 4/1/24.
//

import UIKit

class HistoryTableView: UITableView {
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        self.register(HistoryTableViewCell.self, forCellReuseIdentifier: HistoryTableViewCell.reuseIdentifier)
        self.isScrollEnabled = true
        self.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
