//
//  MainTabBarController.swift
//  AppStoreSearch
//
//  Created by 윤형찬 on 3/30/24.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let todayVC = DummyViewController()
        todayVC.tabBarItem = UITabBarItem(title: "투데이", image: UIImage(systemName: "doc.text.image"), tag: 0)

        let gameVC = DummyViewController()
        gameVC.tabBarItem = UITabBarItem(title: "게임", image: UIImage(systemName: "gamecontroller.fill"), tag: 1)
        
        let appVC = DummyViewController()
        appVC.tabBarItem = UITabBarItem(title: "앱", image: UIImage(systemName: "square.stack.3d.up.fill"), tag: 2)
        
        let arcadeVC = DummyViewController()
        arcadeVC.tabBarItem = UITabBarItem(title: "아케이드", image: UIImage(systemName: "arcade.stick"), tag: 3)
        
        let searchVM = SearchViewModel()
        let searchVC = SearchViewController()
        searchVC.viewModel = searchVM
        let mainNavigationController = UINavigationController(rootViewController: searchVC)
        mainNavigationController.tabBarItem = UITabBarItem(title: "검색", image: UIImage(systemName: "magnifyingglass"), tag: 4)

        
        setTabBarUI()
        self.viewControllers = [todayVC, gameVC, appVC, arcadeVC, mainNavigationController]
    }
    
    private func setTabBarUI() {
        let tabBarAppearance: UITabBarAppearance = UITabBarAppearance()
        tabBarAppearance.backgroundColor = UIColor(named: "BgGray")

        tabBarAppearance.stackedLayoutAppearance.normal.iconColor = .gray
        tabBarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray]
        
        tabBarAppearance.stackedLayoutAppearance.selected.iconColor = .systemBlue
        tabBarAppearance.stackedLayoutAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemBlue]
        
        if #available(iOS 15.0, *) {
            self.tabBar.scrollEdgeAppearance = tabBarAppearance
        }
        
        self.tabBar.standardAppearance = tabBarAppearance
    }
}
