//
//  MainTabBarController.swift
//  DDLite
//
//  Created by Jason wang on 6/20/19.
//  Copyright © 2019 Jason wang. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.red], for: .selected)
        viewControllers = setupViewControllers()
        
    }
    
    func setupViewControllers() -> [UIViewController] {
        let exploreVC = ExploreListController()
        exploreVC.dataServices = ExploreDataServices()
        let explorebutton = UITabBarItem(title: "Explore", image: UIImage(named: "tab-explore")?.withRenderingMode(.alwaysTemplate), selectedImage: UIImage(named: "tab-explore")?.withRenderingMode(.alwaysOriginal))
        exploreVC.tabBarItem = explorebutton
        
        let favoriteVC = FavoriteViewController()
        favoriteVC.tabBarItem = UITabBarItem(title: "Favorite", image: UIImage(named: "tab-star")?.withRenderingMode(.alwaysTemplate), selectedImage: UIImage(named: "tab-star")?.withRenderingMode(.alwaysOriginal))
        
        let vcs = [exploreVC, favoriteVC].map({ UINavigationController(rootViewController: $0)})
        return vcs
    }
}
