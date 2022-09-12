//
//  ToDoItemListViewModel.swift
//  EasyList
//
//  Created by Basistyi, Yevhen on 06/09/2022.
//

import Foundation
import CoreData
import Combine
import UIKit
import Resolver

final class ToDoItemListViewModel {
    
    @OptionalInjected var managedContext: NSManagedObjectContext?
    let configuration: ToDoJourney.ToDoItemList.Configuration
    
    @Published var toDoItems: [ToDoItem] = []
    @Published var isFinished: Bool = false
    
    let dayItem: DayItem
    
    // MARK: - Init
    
    init(dayItem: DayItem, configuration: ToDoJourney.ToDoItemList.Configuration) {
        self.dayItem = dayItem
        self.configuration = configuration
    }
    
    // MARK: -
    
    func toDoCellDidTap(view: UIViewController, for indexPath: IndexPath) {
        configuration.router.toDoItemCellDidTap(view, toDoItems[indexPath.item])
    }
    
    func checkBoxDidToggle(for indexPath: IndexPath, toggleResult: Bool) {
        let toDoItem = toDoItems[indexPath.item]
        
        toDoItem.isFinished = toggleResult
        
        save { error in
            guard error == nil else {
                return
            }
            
            self.toDoItems[indexPath.item].isFinished = toggleResult
            self.updateProgressState()
        }
    }
    
    func removeItem(for indexPath: IndexPath) {
        let item = toDoItems[indexPath.item]
        item.prepareForDeletion()
        managedContext?.delete(item)
        
        save { error in
            guard error == nil else {
                return
            }
            
            self.toDoItems.remove(at: indexPath.item)
        }
    }
    
    func deleteDay() {
        dayItem.prepareForDeletion()
        managedContext?.delete(dayItem)
        
        toDoItems.forEach {
            $0.prepareForDeletion()
            managedContext?.delete($0)
        }
        
        save { error in
            guard error == nil else {
                return
            }
            
            self.fetchToDoItems()
        }
        
    }
    
    func saveImage(_ image: UIImage) {
        dayItem.imageData = image.jpegData(compressionQuality: 1.0)
        
        save()
    }
    
    func createToDoItem(with title: String) {
        guard let managedContext = managedContext else {
            return
        }
        
        let item = ToDoItem(context: managedContext)
        item.title = title
        item.date = dayItem.date
        item.creationDate = Date()
        item.isFinished = false
        
        save { error in
            guard error == nil else {
                return
            }
            
            self.fetchToDoItems()
        }
    }
    
    func fetchToDoItems() {
        do {
            toDoItems = (try managedContext?.fetch(ToDoItem.fetchRequest()) ?? []).filter { $0.date == dayItem.date }
            
            updateProgressState()
        } catch let error {
            print(error)
        }
    }
    
    func save(completion: ((Error?) -> ())? = nil) {
        do {
            try managedContext?.save()
            
            completion?(nil)
        } catch let error {
            completion?(error)
        }
    }
    
    func updateProgressState() {
        isFinished = toDoItems.filter { !$0.isFinished }.isEmpty
        
        if isFinished != dayItem.isFinished {
            dayItem.isFinished = isFinished
            save()
        }
        
    }
    
}
