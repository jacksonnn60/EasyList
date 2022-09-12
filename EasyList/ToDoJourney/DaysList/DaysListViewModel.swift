//
//  DaysListViewModel.swift
//  EasyList
//
//  Created by Basistyi, Yevhen on 05/09/2022.
//

import Foundation
import Combine
import CoreData
import UIKit
import Resolver

final class DaysListViewModel {
    
    @OptionalInjected var managedContext: NSManagedObjectContext?
    private let configuration: ToDoJourney.DaysList.Configuration
    
    @Published var dayItems: [DayItem]?
    
    // MARK: - Init
    
    init(configuration: ToDoJourney.DaysList.Configuration) {
        self.configuration = configuration
    }
    
    // MARK: -
    
    func dayCellDidTap(view: UIViewController, for indexPath: IndexPath) {
        guard indexPath.item < dayItems?.count ?? 0,
              let item = dayItems?[indexPath.item] else {
            return
        }
        
        configuration.router.dayCellDidTap(view, item)
    }
    
    func removeItem(for indexPath: IndexPath) {
        guard indexPath.item < dayItems?.count ?? 0,
              let dayItem = dayItems?[indexPath.item] else {
            return
        }
        
        dayItem.prepareForDeletion()
        managedContext?.delete(dayItem)
        
        save { error in
            guard error == nil else {
                return
            }
            
            self.fetchDayItems()
        }
    }
    
    func markAsDone(for indexPath: IndexPath) {
        guard indexPath.item < dayItems?.count ?? 0,
              let dayItem = dayItems?[indexPath.item] else {
            return
        }
        
        do {
            let toDoItems = (try self.managedContext?.fetch(ToDoItem.fetchRequest()) ?? [])
                .filter { $0.date == dayItem.date }
            
            toDoItems.forEach {
                $0.isFinished = true
            }
            
            dayItem.isFinished = true
            
            save { error in
                guard error == nil else {
                    return
                }
                
                self.fetchDayItems()
            }
        } catch let error {
            print(error)
        }
    }
    
    func createDay(for date: Date) {
        guard let managedContext = managedContext else {
            return
        }
        
        let item = DayItem(context: managedContext)
        item.date = date
        item.isFinished = true
        
        save { error in
            guard error == nil else {
                return
            }
            
            self.fetchDayItems()
        }
    }
    
    func fetchDayItems() {
        do {
            dayItems = try managedContext?.fetch(DayItem.fetchRequest())
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
    
}
