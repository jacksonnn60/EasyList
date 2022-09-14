//
//  SceneDelegate.swift
//  EasyList
//
//  Created by Basistyi, Yevhen on 31/08/2022.
//

import UIKit
import Resolver

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let scene = (scene as? UIWindowScene) else { return }
        
        registerServices()
        
        let controller = TabBarController()
         
        controller.viewControllers =
        [
            UINavigationController(rootViewController: ToDoJourney.DaysList.build()),
            UINavigationController(rootViewController: SettingsJourney.SettingsList.build())
        ]
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.windowScene = scene
        window?.rootViewController = controller
        window?.makeKeyAndVisible()
    }
    
    func registerServices() {
        Resolver.register { ToDoJourney.DaysList.Configuration() }
        Resolver.register { ToDoJourney.ToDoItemList.Configuration() }
        Resolver.register { ToDoJourney.ToDoStepDescription.Configuration() }
        Resolver.register { SettingsJourney.SettingsList.Configuration() }
        
        Resolver.register { SettingsJourney.GeneralSettings() }.scope(.shared)
        
        Resolver.register { (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext }.scope(.shared)
    }

}

