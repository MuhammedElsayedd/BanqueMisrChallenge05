//
//  MainTabBarController.swift
//  BanqueMisrChallenge05
//
//  Created by Muhammed Elsayed on 27/07/2024.
//

import UIKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.tabBar.tintColor = UIColor.black
    }

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if let navController = viewController as? UINavigationController,
           let listVC = navController.viewControllers.first as? ListMoviesViewController {
            if let selectedIndex = tabBarController.viewControllers?.firstIndex(of: viewController) {
                switch selectedIndex {
                case 0:
                    listVC.category = .nowPlaying
                case 1:
                    listVC.category = .popular
                case 2:
                    listVC.category = .upcoming
                default:
                    listVC.category = .nowPlaying
                }
            }
            listVC.fetchMovies()
        }
    }
}
