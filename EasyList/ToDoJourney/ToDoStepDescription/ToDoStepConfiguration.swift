//
//  ToDoStepConfiguration.swift
//  EasyList
//
//  Created by Basistyi, Yevhen on 08/09/2022.
//

import Foundation
import UIKit
import Resolver

extension ToDoJourney {
    
    struct ToDoStepDescription {
        
        static func build(for toDoItem: ToDoItem) -> UIViewController {
            let configuration: ToDoJourney.ToDoStepDescription.Configuration? = Resolver.optional()
            let viewModel = ToDoStepDescriptionViewModel(toDoItem: toDoItem)
            let viewController = ToDoStepDescriptionViewController()
            viewController.viewModel = viewModel
            return viewController
        }
        
        struct Configuration {
            var router = Router()
        }
        
        struct Router {
        }
        
    }
    
}
