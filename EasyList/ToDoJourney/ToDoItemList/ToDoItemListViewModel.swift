//
//  ToDoItemListViewModel.swift
//  EasyList
//
//  Created by Basistyi, Yevhen on 06/09/2022.
//

import CoreData
import UIKit
import Resolver

final class ToDoItemListViewModel {
    
    struct Output {
        var toDoItemsDidFetch: VoidClosure
        var toDoStatusDidChange: Closure<Bool>
        var imageDidDelete: VoidClosure
        var errorDidAppear: Closure<String>
    }
    
    struct Input {
        var viewWillAppear: VoidClosure
        var deleteImageMenuOptionDidChoose: VoidClosure
        var checkBoxDidToggle: Closure<(IndexPath, Bool)>
        var cellDidTap: Closure<(UIViewController, IndexPath)>
        var removeCellDidHandle: Closure<IndexPath>
        var deleteDayMenuOptionDidChoose: VoidClosure
        var imageDidPick: Closure<UIImage>
        var didAddNewToDoItem: Closure<String>
    }
    
    // MARK: -
    
    @OptionalInjected var managedContext: NSManagedObjectContext?
    let configuration: ToDoJourney.ToDoItemList.Configuration
    
    var output: Output?
    var input: Input?
    
    var toDoItems: [ToDoItem] = [] {
        didSet {
            output?.toDoItemsDidFetch()
        }
    }
    
    var isFinished: Bool = false {
        didSet {
            output?.toDoStatusDidChange(isFinished)
        }
    }
    
    let dayItem: DayItem
    
    // MARK: - Init
    
    init(dayItem: DayItem, configuration: ToDoJourney.ToDoItemList.Configuration) {
        self.dayItem = dayItem
        self.configuration = configuration
    }
    
    func setUpInput() {
        input = .init(
            viewWillAppear: { self.fetchToDoItems() },
            deleteImageMenuOptionDidChoose: {
                self.dayItem.imageData = nil
                self.save(successBlock: self.output?.imageDidDelete)
            },
            checkBoxDidToggle: { self.checkBoxDidToggle(for: $0, toggleResult: $1) },
            cellDidTap: {
                self.configuration.router.toDoItemCellDidTap($0, self.toDoItems[$1.item])
            },
            removeCellDidHandle: { self.removeItem(for: $0) },
            deleteDayMenuOptionDidChoose: { self.deleteDay() },
            imageDidPick: { self.saveImage($0) },
            didAddNewToDoItem: { self.createToDoItem(with: $0) }
        )
    }
    
    // MARK: -
    
    private func checkBoxDidToggle(for indexPath: IndexPath, toggleResult: Bool) {
        let toDoItem = toDoItems[indexPath.item]
        
        toDoItem.isFinished = toggleResult
        
        save {
            self.toDoItems[indexPath.item].isFinished = toggleResult
            self.updateProgressState()
        }
    }
    
    private func removeItem(for indexPath: IndexPath) {
        let item = toDoItems[indexPath.item]
        item.prepareForDeletion()
        managedContext?.delete(item)
        
        save { self.fetchToDoItems() }
    }
    
    private func deleteDay() {
        dayItem.prepareForDeletion()
        managedContext?.delete(dayItem)
        
        toDoItems.forEach {
            $0.prepareForDeletion()
            managedContext?.delete($0)
        }
        
        save { self.fetchToDoItems() }
    }
    
    func saveImage(_ image: UIImage, imageDidSaveBlock: VoidClosure? = nil) {
        dayItem.imageData = image.jpegData(compressionQuality: 1.0)
        
        save(successBlock: imageDidSaveBlock)
    }
    
    private func createToDoItem(with title: String) {
        guard let managedContext = managedContext else {
            return
        }
        
        let item = ToDoItem(context: managedContext)
        item.title = title
        item.date = dayItem.date
        item.stepDescription = ""
        item.creationDate = Date()
        item.isFinished = false
        
        save { self.fetchToDoItems() }
    }
    
    private func fetchToDoItems() {
        do {
            toDoItems = (try managedContext?.fetch(ToDoItem.fetchRequest()) ?? []).filter { $0.date == dayItem.date }
            
            updateProgressState()
        } catch let error {
            print(error)
        }
    }
    
    private func updateProgressState() {
        isFinished = toDoItems.filter { !$0.isFinished }.isEmpty
        
        if isFinished != dayItem.isFinished {
            dayItem.isFinished = isFinished
            save()
        }
        
    }
    
    private func save(successBlock: VoidClosure? = nil) {
        do {
            try managedContext?.save()

            successBlock?()
        } catch let error {
            output?.errorDidAppear(error.localizedDescription)
        }
    }
    
    // MARK: - Deinit
    
    deinit {
        input = nil
        output = nil
    }
    
}
