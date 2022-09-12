//
//  DayItem+CoreDataProperties.swift
//  
//
//  Created by Basistyi, Yevhen on 06/09/2022.
//
//

import Foundation
import CoreData


extension DayItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DayItem> {
        return NSFetchRequest<DayItem>(entityName: "DayItem")
    }

    @NSManaged public var date: Date?
    @NSManaged public var isFinished: Bool
    @NSManaged public var imageData: Data?

}
