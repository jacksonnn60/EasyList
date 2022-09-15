//
//  App.swift
//  EasyList
//
//  Created by Jackson  on 15/09/2022.
//

import UIKit
import Resolver

final class App {
    
    static func buildTabBar() -> UITabBarController {
        let generalSettings: SettingsJourney.GeneralSettings? = Resolver.optional()
        let tabBarController = TabBarController()
        tabBarController.viewControllers =
        [
            UINavigationController(rootViewController: ToDoJourney.DaysList.build()),
            UINavigationController(rootViewController: SettingsJourney.SettingsList.build())
        ]
        tabBarController.tabBar.tintColor = generalSettings?.colourStyle.options.shuffled().first
        return tabBarController
    }
    
    static func start(from window: UIWindow) {
        let controller = App.buildTabBar()
        window.rootViewController = controller
        window.makeKeyAndVisible()
    }
    
}
