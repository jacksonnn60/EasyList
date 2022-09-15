//
//  SceneDelegate.swift
//  EasyList
//
//  Created by Basistyi, Yevhen on 31/08/2022.
//

import UIKit
import Resolver
import CoreData

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let scene = (scene as? UIWindowScene) else { return }
        
        registerServices()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.windowScene = scene
        
        App.start(from: window ?? .init())
        
    }
    
}

private extension SceneDelegate {
    func registerServices() {
        Resolver.register { ToDoJourney.DaysList.Configuration() }
        Resolver.register { ToDoJourney.ToDoItemList.Configuration() }
        Resolver.register { ToDoJourney.ToDoStepDescription.Configuration() }
        Resolver.register { SettingsJourney.SettingsList.Configuration() }
        
        guard let managedContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else {
            return
        }
        
        Resolver.register { managedContext }.scope(.shared)

        registerSettings(managedContext)
    }
    
    func registerSettings(_ managedContext: NSManagedObjectContext) {
        do {
            if let settings = try managedContext.fetch(GeneralSettingsOptions.fetchRequest()).first {
                
                let generalSettings = SettingsJourney.GeneralSettings()
                generalSettings.appStyle = SettingsJourney.GeneralSettings.Styles.AppStyle(rawValue: Int(settings.appStyle)) ?? .geometry
                generalSettings.colourStyle = SettingsJourney.GeneralSettings.Styles.ColourStyle(rawValue: Int(settings.colourStyle)) ?? .happy
                
                Resolver.register { generalSettings }.scope(.shared)
                
            } else {
                throw "No settings in Container."
            }
                            
        } catch let error {
            let newSettings = SettingsJourney.GeneralSettings()
            
            Resolver.register { newSettings }.scope(.shared)
            
            let generalSettingsOptions = GeneralSettingsOptions(context: managedContext)
            generalSettingsOptions.appStyle = Int16(newSettings.appStyle.rawValue)
            generalSettingsOptions.colourStyle = Int16(newSettings.colourStyle.rawValue)
            do {
                try managedContext.save()
            } catch let error {
                print(error)
            }
            
            print("Error: \(error.localizedDescription)")
        }
    }
}
