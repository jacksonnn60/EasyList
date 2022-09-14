//
//  SettingsListConfiguration.swift
//  EasyList
//
//  Created by Jackson  on 14/09/2022.
//

import UIKit
import Resolver

extension SettingsJourney {
    
    struct SettingsList {
        
        static func build() -> UIViewController {
            let configuration: SettingsJourney.SettingsList.Configuration? = Resolver.optional()
            let controller = SettingsListViewController()
            let viewModel = SettingsListViewModel(configuration: configuration ?? .init())
            controller.viewModel = viewModel
            controller.tabBarItem = configuration?.tabBarItem
            return controller
        }
        
        struct Configuration {
            var tabBarItem: UITabBarItem {
                .init(title: "Settings", image: .init(systemName: "gearshape"), selectedImage: .init(systemName: "gearshape.fill"))
            }
        }
        
    }
    
}
