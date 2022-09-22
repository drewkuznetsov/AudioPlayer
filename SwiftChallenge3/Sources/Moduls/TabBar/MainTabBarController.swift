//
//  MainTabBarController.swift
//  SwiftChallenge3
//
//  Created by Андрей Кузнецов on 21.09.2022.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        self.tabBar.tintColor = .purple
        
        viewControllers = [
            generateViewController(rootViewController: MainViewController(), imageVC: "music.note.list", titelVC: "Main"),
            generateViewController(rootViewController: ListViewController(), imageVC: "list.star", titelVC: "List"),
            generateViewController(rootViewController: PlayerViewController(), imageVC: "play.circle", titelVC: "Player"),
            generateViewController(rootViewController: SearchViewController(), imageVC: "magnifyingglass.circle", titelVC: "Search")
        ]
    }
    
    private func generateViewController(rootViewController: UIViewController, imageVC: String, titelVC: String) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.image = UIImage(systemName: imageVC)
        navigationVC.tabBarItem.title = titelVC
        navigationVC.navigationBar.prefersLargeTitles = true
        
        return navigationVC
    }
    
}

