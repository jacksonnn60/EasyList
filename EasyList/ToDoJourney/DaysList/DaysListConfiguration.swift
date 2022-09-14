//
//  DaysListConfiguration.swift
//  EasyList
//
//  Created by Basistyi, Yevhen on 08/09/2022.
//

import UIKit
import Resolver

extension ToDoJourney {
    
    struct DaysList {
        
        static func build() -> UIViewController {
            let configuration: ToDoJourney.DaysList.Configuration? = Resolver.optional()
            let viewModel = DaysListViewModel(configuration: configuration ?? .init())
            let viewController = DaysListViewController()
            viewController.tabBarItem = configuration?.tabBarItem
            viewController.viewModel = viewModel
            return viewController
        }
        
        struct Configuration {
            var router = DaysList.Router()
            
            var tabBarItem: UITabBarItem {
                .init(title: "All Days List", image: .init(systemName: "list.clipboard"), selectedImage: .init(systemName: "list.clipboard.fill"))
            }
        }
        
        struct Router {
            var dayCellDidTap: (UIViewController, DayItem) -> () = {
                let toDoItemListViewController = ToDoItemList.build(for: $1)
                $0.navigationController?.pushViewController(toDoItemListViewController, animated: true)
            }
        }
        
    }
    
}
