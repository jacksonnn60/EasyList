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
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.windowScene = scene
        window?.rootViewController = UINavigationController(rootViewController: ToDoJourney.DaysList.build())
        window?.makeKeyAndVisible()
    }
    
    func registerServices() {
        Resolver.register { ToDoJourney.DaysList.Configuration() }
        Resolver.register { ToDoJourney.ToDoItemList.Configuration() }
        Resolver.register { ToDoJourney.ToDoStepDescription.Configuration() }
        
        Resolver.register { (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext }.scope(.shared)
    }

}

