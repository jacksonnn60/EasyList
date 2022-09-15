//
//  SettingsListViewModel.swift
//  EasyList
//
//  Created by Jackson  on 14/09/2022.
//

import Foundation
import Resolver
import CoreData

final class SettingsListViewModel {
    
    struct Output {
        var appColorDidChange: Closure<SettingsJourney.GeneralSettings.Styles.ColourStyle?>
    }
    
    struct Input {
        var cellDidTap: Closure<IndexPath?>
        
        var pickerDidSelectRow: Closure<Int>
    }
    
    var output: Output?
    var input: Input?
    
    @OptionalInjected var managedContext: NSManagedObjectContext?
    @OptionalInjected var generalSettings: SettingsJourney.GeneralSettings?
    
    private var generalSettingsOptions: GeneralSettingsOptions? {
        try? managedContext?.fetch(GeneralSettingsOptions.fetchRequest()).first
    }
    
    private let configuration: SettingsJourney.SettingsList.Configuration
    
    var selectedSection: Int?
    
    private var selectedRow: Int? {
        didSet {
            switch selectedSection ?? 0 {
            case 0:
                generalSettings?.appStyle = SettingsJourney.GeneralSettings.Styles.AppStyle(rawValue: selectedRow ?? 0) ?? .geometry
                
                generalSettingsOptions?.appStyle = Int16(selectedRow ?? 0)
                save()
            case 1:
                generalSettings?.colourStyle = SettingsJourney.GeneralSettings.Styles.ColourStyle(rawValue: selectedRow ?? 0) ?? .happy
                
                generalSettingsOptions?.colourStyle = Int16(selectedRow ?? 0)
        
                save {
                    self.output?.appColorDidChange(self.generalSettings?.colourStyle)
                }
            default:
                break
            }
        }
    }
    
    // MARK: - Init
    
    init(configuration: SettingsJourney.SettingsList.Configuration) {
        self.configuration = configuration
    }
    
     // MARK: -
    
    func setUpInput() {
        input = .init(
            cellDidTap: { indexPath in
                self.selectedSection = indexPath?.item
            },
            pickerDidSelectRow: { row in
                self.selectedRow = row
            }
        )
    }
    
    private func save(successBlock: VoidClosure? = nil) {
        do {
            try managedContext?.save()

            successBlock?()
        } catch let error {
//            output?.errorDidAppear(error.localizedDescription)
        }
    }
    
}
