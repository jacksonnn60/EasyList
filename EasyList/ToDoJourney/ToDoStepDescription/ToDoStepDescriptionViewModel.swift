//
//  ToDoStepDescriptionViewModel.swift
//  EasyList
//
//  Created by Basistyi, Yevhen on 07/09/2022.
//

import Foundation
import Resolver
import CoreData

enum ToDoStepDescriptionScreenState {
    case `default`
    case editing
}

final class ToDoStepDescriptionViewModel {
    
    struct Output {
        var screenStateDidChange: Closure<ToDoStepDescriptionScreenState>
        var errorDidAppear: Closure<String>
    }
    
    struct Input {
        var saveButtonDidTap: Closure<(description: String?, title: String?)>
        var editButtonDidTap: VoidClosure
    }
    
    var input: Input?
    var output: Output?
    
    @OptionalInjected var managedContext: NSManagedObjectContext?
    
    private var screenState: ToDoStepDescriptionScreenState = .default {
        didSet {
            output?.screenStateDidChange(screenState)
        }
    }
    
    let toDoItem: ToDoItem
    
    // MARK: - Init
    
    init(toDoItem: ToDoItem) {
        self.toDoItem = toDoItem
    }
    
    func setUpInput() {
        input = .init(
            saveButtonDidTap: {
                self.edit(description: $0, title: $1)
                self.screenState = .default
            },
            editButtonDidTap: {
                self.screenState = .editing
            }
        )
    }
    
    func edit(description: String?, title: String?) {
        toDoItem.title = title
        toDoItem.stepDescription = description
        save()
    }
    
    private func save(successBlock: VoidClosure? = nil) {
        do {
            try managedContext?.save()

            successBlock?()
        } catch let error {
            output?.errorDidAppear(error.localizedDescription)
        }
    }
    
}
