//
//  ToDoItem+CoreDataProperties.swift
//  
//
//  Created by Basistyi, Yevhen on 07/09/2022.
//
//

import Foundation
import CoreData


extension ToDoItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoItem> {
        return NSFetchRequest<ToDoItem>(entityName: "ToDoItem")
    }

    @NSManaged public var date: Date?
    @NSManaged public var isFinished: Bool
    @NSManaged public var title: String?
    @NSManaged public var creationDate: Date?

}
