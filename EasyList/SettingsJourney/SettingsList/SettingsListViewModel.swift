//
//  SettingsListViewModel.swift
//  EasyList
//
//  Created by Jackson  on 14/09/2022.
//

import Foundation
import Resolver

final class SettingsListViewModel {
    
    struct Output {
    }
    
    struct Input {
        var cellDidTap: Closure<IndexPath?>
        
        var pickerDidSelectRow: Closure<Int>
    }
    
    var output: Output?
    var input: Input?
    
    @OptionalInjected var generalSettings: SettingsJourney.GeneralSettings?
    
    private let configuration: SettingsJourney.SettingsList.Configuration
    
    var selectedSettingsSection: Int?
    
    private var selectedSettingsSectionsRow: Int? {
        didSet {
            switch selectedSettingsSection ?? 0 {
            case 0:
                generalSettings?.appStyle = SettingsJourney.GeneralSettings.Styles.AppStyle.allCases[selectedSettingsSectionsRow ?? 0]
            case 1:
                generalSettings?.colourStyle = SettingsJourney.GeneralSettings.Styles.ColourStyle.allCases[selectedSettingsSectionsRow ?? 0]
            default:
                break
            }
        }
    }
    
    init(configuration: SettingsJourney.SettingsList.Configuration) {
        self.configuration = configuration
    }
    
    func setUpInput() {
        input = .init(
            cellDidTap: { indexPath in
                self.selectedSettingsSection = indexPath?.item
            },
            pickerDidSelectRow: { row in
                self.selectedSettingsSectionsRow = row
            }
        )
    }
    
}
