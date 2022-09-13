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
        
        setUpKeyboardNotification()
        
        viewModel?.setUpInput()
        setUpOutput()
        
        baseView.toDoItemTitleLabel.text = viewModel?.toDoItem.title
        baseView.descriptionTextView.text = viewModel?.toDoItem.stepDescription
        
        baseView.editButton.addTarget(self, action: #selector(editButtonDidTap(_:)), for: .touchUpInside)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        baseView.descriptionTextView.snp.updateConstraints { make in
            make.height.equalTo(baseView.descriptionTextView.contentSize.height)
        }
        
    }
    
}

// MARK: - SetUp Output

private extension ToDoStepDescriptionViewController {
    
    func setUpOutput() {
        viewModel?.output = .init(
            screenStateDidChange: { screenState in
                switch screenState {
                case .default:
                    self.baseView.editButton.setTitle("Edit", for: .normal)
                    self.baseView.descriptionTextView.isUserInteractionEnabled = false
                    self.baseView.editButton.backgroundColor = .systemBlue
                    self.baseView.editButton.removeTarget(self, action: #selector(self.saveButtonDidTap(_:)), for: .touchUpInside)
                    self.baseView.editButton.addTarget(self, action: #selector(self.editButtonDidTap(_:)), for: .touchUpInside)
                    
                    self.baseView.descriptionTextView.resignFirstResponder()
                case .editing:
                    self.baseView.editButton.setTitle("Save", for: .normal)
                    self.baseView.descriptionTextView.isUserInteractionEnabled = true
                    self.baseView.editButton.backgroundColor = .systemGreen
                    self.baseView.editButton.removeTarget(self, action: #selector(self.editButtonDidTap(_:)), for: .touchUpInside)
                    self.baseView.editButton.addTarget(self, action: #selector(self.saveButtonDidTap(_:)), for: .touchUpInside)
                    
                    self.baseView.descriptionTextView.becomeFirstResponder()
                }
            },
            errorDidAppear: { self.showError(message: $0) }
        )
    }
    
}

// MARK: - Edit Button Actions

private extension ToDoStepDescriptionViewController {
    
    @objc func saveButtonDidTap(_ sender: UIButton) {
        viewModel?.input?.saveButtonDidTap(
            (baseView.descriptionTextView.text, baseView.toDoItemTitleLabel.text)
        )
    }
    
    @objc func editButtonDidTap(_ sender: UIButton) {
        viewModel?.input?.editButtonDidTap()
    }
    
}

// MARK: - Keyboard

private extension ToDoStepDescriptionViewController {
    
    func setUpKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow(_:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidHide(_:)), name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    @objc func keyboardDidShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            baseView.descriptionTextView.snp.updateConstraints { make in
                make.height.equalTo(baseView.descriptionTextView.contentSize.height + keyboardHeight)
            }
        }
    }
    
    @objc func keyboardDidHide(_ notification: Notification) {
        baseView.descriptionTextView.snp.updateConstraints { make in
            make.height.equalTo(baseView.descriptionTextView.contentSize.height)
        }
    }
    
}
