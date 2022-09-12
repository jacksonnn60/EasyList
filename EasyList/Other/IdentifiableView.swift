//
//  XIBIdentifiable.swift
//  EasyList
//
//  Created by Basistyi, Yevhen on 31/08/2022.
//

import UIKit

protocol IdentifiableView: UIView {
    static var viewIdentifier: String { get }
}

extension IdentifiableView {
    static var viewIdentifier: String {
        String(describing: Self.self)
    }
}
