//
//  ToDoDescriptionViewController.swift
//  EasyList
//
//  Created by Basistyi, Yevhen on 01/09/2022.
//

import UIKit

final class ToDoStepDescriptionViewController: BaseViewController<ToDoStepDescriptionView> {
    
    var viewModel: ToDoStepDescriptionViewModel?
    
    // MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        baseView.toDoItemTitleLabel.text = viewModel?.toDoItem.title
        baseView.creationDateLabel.text = viewModel?.toDoItem.creationDate?.getString(formated: .toDoStepDescription)
    }
    
}
