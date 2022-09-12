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
            viewController.viewModel = viewModel
            return viewController
        }
        
        struct Configuration {
            var router = DaysList.Router()
        }
        
        struct Router {
            var dayCellDidTap: (UIViewController, DayItem) -> () = {
                let toDoItemListViewController = ToDoItemList.build(for: $1)
                $0.navigationController?.pushViewController(toDoItemListViewController, animated: true)
            }
        }
        
    }
    
}
