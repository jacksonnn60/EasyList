//
//  TableView.swift
//  EasyList
//
//  Created by Jackson  on 12/09/2022.
//

import UIKit

extension UITableView {
    func reloadDataWithTransition(duration: Double = 0.25) {
        UIView.transition(with: self, duration: duration, options: .transitionCrossDissolve) {
            self.reloadData()
        }
    }
}
