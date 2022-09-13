//
//  Color.swift
//  EasyList
//
//  Created by Jackson  on 13/09/2022.
//

import UIKit

extension UIColor {
    static var randomColor: UIColor {
        [UIColor.systemBlue, UIColor.red, UIColor.systemIndigo].shuffled().first!
    }
}
