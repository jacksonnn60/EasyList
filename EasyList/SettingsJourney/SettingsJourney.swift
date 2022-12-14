//
//  SettingsJourney.swift
//  EasyList
//
//  Created by Jackson  on 14/09/2022.
//

import Foundation
import SwiftUI
import UIKit

class SettingsJourney {
    
    class GeneralSettings {
        
        var appStyle: Styles.AppStyle = .geometry
        var colourStyle: Styles.ColourStyle = .happy
        
        enum Styles {
            enum ColourStyle: Int, CaseIterable {
                case sad = 0
                case happy = 1
                
                static var sectionTitle: String {
                    return "Colour Style"
                }
                
                var title: String {
                    switch self {
                    case .sad: return "Sad Colours"
                    case .happy: return "Happy Colours"
                    }
                }
                
                var options: [UIColor] {
                    switch self {
                    case .happy:
                        return [
                            .systemTeal,
                            .systemGreen,
                            .systemCyan,
                            .systemYellow,
                            .systemRed,
                            .systemBlue,
                            .systemPink,
                            .systemIndigo
                        ]
                    case .sad:
                        return [
                            .black
                        ]
                    }
                }
                
            }
            
            enum AppStyle: Int, CaseIterable {
                case geometry = 0
                case animals = 1
                case flora = 2
                
                static var sectionTitle: String {
                    return "App Style"
                }
                
                var title: String {
                    switch self {
                    case .geometry: return "Geometry"
                    case .animals: return "Animals"
                    case .flora: return "Flora"
                    }
                }
                
                var options: [String] {
                    switch self {
                    case .animals: return ["lizard", "fish", "ladybug"]
                    case .geometry: return ["square", "circle", "triangle"]
                    case .flora: return ["leaf", "laurel.leading", "carrot"]
                    }
                }
            }
        }
        
                
    }
    
}
