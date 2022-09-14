//
//  TabBarController.swift
//  EasyList
//
//  Created by Jackson  on 14/09/2022.
//

import UIKit

final class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.isTranslucent = false
        tabBar.backgroundColor = .systemBackground
    }
    
}
