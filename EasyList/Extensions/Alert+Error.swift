//
//  Alerts+Error.swift
//  EasyList
//
//  Created by Jackson  on 12/09/2022.
//

import UIKit

extension UIViewController {
    func showError(title: String = "⚠️⚠️⚠️", message: String = "Unknown error...") {
        let errorAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        errorAlert.addAction(.init(title: "Ok", style: .default))
        self.present(errorAlert, animated: true)
    }
}
