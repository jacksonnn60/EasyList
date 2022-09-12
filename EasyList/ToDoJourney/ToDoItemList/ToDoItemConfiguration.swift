//
//  ToDoItemConfiguratino.swift
//  EasyList
//
//  Created by Basistyi, Yevhen on 08/09/2022.
//

import UIKit
import Resolver

extension ToDoJourney {
    
    struct ToDoItemList {
        
        static func build(for day: DayItem) -> UIViewController {
            let configuration: ToDoJourney.ToDoItemList.Configuration? = Resolver.optional()
            let viewModel = ToDoItemListViewModel(dayItem: day, configuration: configuration ?? .init())
            let viewController = ToDoItemListViewController()
            viewController.viewModel = viewModel
            return viewController
        }
        
        struct Configuration {
            var router = Router()
        }
        
        struct Router {
            var toDoItemCellDidTap: (UIViewController, ToDoItem) -> () = {
                let toDoStepDescriptionController = ToDoJourney.ToDoStepDescription.build(for: $1)
                $0.present(toDoStepDescriptionController, animated: true)
            }
        }
        
    }
    
}
