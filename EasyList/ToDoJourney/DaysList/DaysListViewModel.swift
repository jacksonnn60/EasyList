//
//  DaysListViewModel.swift
//  EasyList
//
//  Created by Basistyi, Yevhen on 05/09/2022.
//

import CoreData
import UIKit
import Resolver

final class DaysListViewModel {
    
    struct Output {
        var dayItemsDidFetch: VoidClosure
        var errorDidAppear: ErrorClosure
    }
    
    struct Input {
        var viewWillAppear: VoidClosure
        var newDateDidChoose: Closure<Date>
        var cellDidTap: Closure<(UIViewController, IndexPath)>
        var removeCellDidHandle: Closure<IndexPath>
        var dayDidMarkAsDone: Closure<IndexPath>
    }
    
    // MARK: -
    
    var output: Output?
    var input: Input?
    
    @OptionalInjected var managedContext: NSManagedObjectContext?
    private let configuration: ToDoJourney.DaysList.Configuration
            
    var dayItems: [DayItem]? {
        didSet {
            output?.dayItemsDidFetch()
        }
    }
    
    // MARK: - Init
    
    init(configuration: ToDoJourney.DaysList.Configuration) {
        self.configuration = configuration
    }
    
    func setUpInput() {
        input = .init(
            viewWillAppear: { self.fetchDayItems() },
            newDateDidChoose: { self.createDay(for: $0) },
            cellDidTap: { self.cellDidTap(view: $0, for: $1) },
            removeCellDidHandle: { self.removeItem(for: $0) },
            dayDidMarkAsDone: { self.markAsDone(for: $0) }
        )
    }
    
    // MARK: -
    
    private func cellDidTap(view: UIViewController, for indexPath: IndexPath) {
        guard indexPath.item < dayItems?.count ?? 0,
              let item = dayItems?[indexPath.item] else {
            return
        }
        
        configuration.router.dayCellDidTap(view, item)
    }
    
    private func removeItem(for indexPath: IndexPath) {
        guard indexPath.item < dayItems?.count ?? 0,
              let dayItem = dayItems?[indexPath.item] else {
            return
        }
        
        dayItem.prepareForDeletion()
        managedContext?.delete(dayItem)
        
        save {
            self.fetchDayItems()
        }
    }
    
    private func markAsDone(for indexPath: IndexPath) {
        guard indexPath.item < dayItems?.count ?? 0,
              let dayItem = dayItems?[indexPath.item] else {
            return
        }
        
        do {
            (try managedContext?.fetch(ToDoItem.fetchRequest()) ?? [])
                .filter { $0.date == dayItem.date }
                .forEach { $0.isFinished = true }
            
            dayItem.isFinished = true
            
            save {
                self.fetchDayItems()
            }
        } catch let error {
            print(error)
        }
    }
    
    private func createDay(for date: Date) {
        guard let managedContext = managedContext else {
            return
        }
        
        let item = DayItem(context: managedContext)
        item.date = date
        item.isFinished = true
        
        save {
            self.fetchDayItems()
        }
    }
    
    private func fetchDayItems() {
        do {
            dayItems = try managedContext?.fetch(DayItem.fetchRequest())
        } catch let error {
            print(error)
        }
    }
    
    private func save(successBlock: VoidClosure? = nil) {
        do {
            try managedContext?.save()

            successBlock?()
        } catch let error {
            output?.errorDidAppear(error)
        }
    }
}
