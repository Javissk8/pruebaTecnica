//
//  TabBarViewController.swift
//  PruebaTecnicaApp
//
//  Created by Javier Vazquez on 16/04/21.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.tintColor = .customCyan
        loadControllersInTabBar()
    }
    
    func loadControllersInTabBar() {
        let waitingVC = WaitingOrdersViewController()
        waitingVC.tabBarItem = UITabBarItem(title: "WAITING".localized, image: Icons.TabBarItems.waiting, selectedImage: Icons.TabBarItems.waiting.withTintColor(.customCyan, renderingMode: .alwaysOriginal))
        let waitingNavC = UINavigationController(rootViewController: waitingVC)
        
        let acceptedVC = AcceptedOrdersViewController()
        acceptedVC.tabBarItem = UITabBarItem(title: "ORDERS".localized, image: Icons.TabBarItems.accepted, selectedImage: Icons.TabBarItems.accepted.withTintColor(.customCyan))
        let acceptedNavC = UINavigationController(rootViewController: acceptedVC)
        
        self.viewControllers = [waitingNavC, acceptedNavC]
    }
}
