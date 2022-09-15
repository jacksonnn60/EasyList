//
//  GeneralSettingsOptions+CoreDataProperties.swift
//  
//
//  Created by Jackson  on 15/09/2022.
//
//

import Foundation
import CoreData


extension GeneralSettingsOptions {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GeneralSettingsOptions> {
        return NSFetchRequest<GeneralSettingsOptions>(entityName: "GeneralSettingsOptions")
    }

    @NSManaged public var appStyle: Int16
    @NSManaged public var colourStyle: Int16

}
