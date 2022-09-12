//
//  ToDoDescriptionViewController.swift
//  EasyList
//
//  Created by Basistyi, Yevhen on 01/09/2022.
//

import UIKit

final class ToDoStepDescriptionViewController: BaseViewController<ToDoStepDescriptionView> {
    
    var viewModel: ToDoStepDescriptionViewModel?
    
    override var title: String? {
        didSet {
            baseView.toDoItemTitleLabel.text = title
        }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        baseView.creationDateLabel.text = viewModel?.toDoItem.creationDate?.getString(formated: .toDoStepDescription)
    }
    
}
