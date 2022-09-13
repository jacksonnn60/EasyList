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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        baseView.descriptionTextView.delegate = self
        baseView.toDoItemTitleTextView.delegate = self
        baseView.editButton.addTarget(self, action: #selector(editButtonDidTap(_:)), for: .touchUpInside)
        
        setUpKeyboardNotification()
        viewModel?.setUpInput()
        setUpOutput()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        baseView.toDoItemTitleTextView.text = viewModel?.toDoItem.title
        baseView.descriptionTextView.text = viewModel?.toDoItem.stepDescription
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        baseView.descriptionTextView.snp.updateConstraints { make in
            make.height.equalTo(baseView.descriptionTextView.contentSize.height)
        }
        baseView.toDoItemTitleTextView.snp.updateConstraints { make in
            make.height.equalTo(baseView.toDoItemTitleTextView.contentSize.height)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presentingViewController?.viewWillAppear(animated)
    }
    
}

// MARK: - SetUp Output

private extension ToDoStepDescriptionViewController {
    
    func setUpOutput() {
        viewModel?.output = .init(
            screenStateDidChange: { screenState in
                switch screenState {
                case .default:
                    self.baseView.descriptionTextView.textColor = .label
                    self.baseView.toDoItemTitleTextView.textColor = .label
                    self.baseView.editButton.setTitle("Edit", for: .normal)
                    self.baseView.descriptionTextView.isUserInteractionEnabled = false
                    self.baseView.toDoItemTitleTextView.isUserInteractionEnabled = false
                    self.baseView.editButton.backgroundColor = .systemBlue
                    self.baseView.editButton.removeTarget(self, action: #selector(self.saveButtonDidTap(_:)), for: .touchUpInside)
                    self.baseView.editButton.addTarget(self, action: #selector(self.editButtonDidTap(_:)), for: .touchUpInside)
                    
                    self.baseView.toDoItemTitleTextView.resignFirstResponder()
                    self.baseView.descriptionTextView.resignFirstResponder()
                case .editing:
                    self.baseView.descriptionTextView.textColor = .gray
                    self.baseView.toDoItemTitleTextView.textColor = .gray
                    self.baseView.editButton.setTitle("Save", for: .normal)
                    self.baseView.descriptionTextView.isUserInteractionEnabled = true
                    self.baseView.toDoItemTitleTextView.isUserInteractionEnabled = true
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

extension ToDoStepDescriptionViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        textView.snp.updateConstraints { make in
            make.height.equalTo(textView.contentSize.height)
        }
    }
}

// MARK: - Edit Button Actions

private extension ToDoStepDescriptionViewController {
    
    @objc func saveButtonDidTap(_ sender: UIButton) {
        viewModel?.input?.saveButtonDidTap(
            (baseView.descriptionTextView.text, baseView.toDoItemTitleTextView.text)
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
