//
//  EasyListItemDetailsScreen.swift
//  EasyList
//
//  Created by Basistyi, Yevhen on 31/08/2022.
//

import UIKit
import SnapKit

final class ToDoItemListViewController: BaseViewController<ToDoItemListView> {
    
    private lazy var imagePicker: ImagePicker = {
        $0.delegate = self
        return $0
    }(ImagePicker())
    
    private lazy var localMenu: UIMenu = {
        let menu = UIMenu(
            title: "Options",
            identifier: nil,
            options: UIMenu.Options.destructive,
            children:
                [
                    UIAction(title: "Add Challenge", image: .init(systemName: "plus"), state: .off) { _ in
                        self.addNewToDoItem()
                    },
                    UIMenu(
                        title: "Change image",
                        image: .init(systemName: "photo"),
                        identifier: nil,
                        options: UIMenu.Options.singleSelection,
                        children: [
                            UIAction(title: "Take photo", image: .init(systemName: "camera"), state: .off) { _ in
                                self.takeImage()
                            },
                            UIAction(title: "Open library", image: .init(systemName: "photo.on.rectangle.angled"), state: .off) { _ in
                                self.pickImage()
                            },
                        ]
                    ),
                    UIAction(title: "Delete day", image: .init(systemName: "trash"), attributes: .destructive, state: .off) { _ in
                        self.deleteDidChoose()
                    }
                ]
        )
        return menu
    }()
        
    var viewModel: ToDoItemListViewModel?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBarItems()
        
        viewModel?.setUpInput()
        setUpOutput()
        setUpTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.input?.viewWillAppear()
        
        setUpImage()
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func configureNavigationBarItems() {
        title = viewModel?.dayItem.date?.getString(formated: .toDoListTitle)
        navigationItem.setRightBarButton(.init(title: nil, image: UIImage(systemName: "list.bullet"), primaryAction: nil, menu: localMenu), animated: true)
    }
}

// MARK: - SetUp Output

private extension ToDoItemListViewController {
    func setUpOutput() {
        viewModel?.output = .init(
            
            toDoItemsDidFetch: {
                DispatchQueue.main.async {
                    self.baseView.tableView.reloadDataWithTransition(duration: 0.4)
                }
            },
            
            toDoStatusDidChange: { isFinished in
                self.baseView.statusLabel.text = isFinished ? "Done" : "You have something to do"
            },
            
            errorDidAppear: { self.showError(message: $0) }
        )
    }
}

// MARK: - Menu Actions

private extension ToDoItemListViewController {
    func addNewToDoItem() {
        let alert = UIAlertController(title: "New challenge", message: nil, preferredStyle: .alert)
        alert.addTextField()
        alert.textFields?.first?.placeholder = "Challenge title..."
        alert.addAction(.init(title: "Add", style: .default) { [unowned self] _ in
            guard let title = alert.textFields?.first?.text else {
                return
            }
            
            self.viewModel?.input?.didAddNewToDoItem(title)
        })
        alert.addAction(.init(title: "Cancel", style: .destructive))
        present(alert, animated: true)
    }
    
    
    func pickImage() {
        imagePicker.pickImage(from: self)
    }
    
    func takeImage() {
        imagePicker.takePhoto()
    }
    
    func deleteDidChoose() {
        viewModel?.input?.deleteDayMenuOptionDidChoose()
        
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - ImagePicker Delegate

extension ToDoItemListViewController: ImagePickerDelegate {
    func imagePicker(didCancelPickingImage picker: UIImagePickerController) {
        
    }
    
    func imagePicker(didPickImage image: UIImage) {
        viewModel?.saveImage(image)
        baseView.imageView.image = image
    }
    
    func imagePicker(didTakeImage image: UIImage) {
        viewModel?.saveImage(image)
        baseView.imageView.image = image
    }
}

// MARK: - SetUp Actions

private extension ToDoItemListViewController {
    func setUpTableView() {
        baseView.tableView.register(ToDoCell.self, forCellReuseIdentifier: ToDoCell.viewIdentifier)
        baseView.tableView.dataSource = self
        baseView.tableView.delegate = self
    }
    
    func setUpImage() {
        if let imageData = viewModel?.dayItem.imageData {
            self.baseView.imageView.image = UIImage(data: imageData)
        } else {
            baseView.imageView.backgroundColor = .systemGray6
        }
    }
}

// MARK: - UITableView DelegateToDoCell

extension ToDoItemListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.input?.cellDidTap((self, indexPath))
    }
}

// MARK: - UITableView DataSource

extension ToDoItemListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.toDoItems.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        configureToDoCell(for: tableView, with: indexPath)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        .init(
            actions:
                [
                    UIContextualAction(style: .destructive, title: "Remove") { [unowned self] _, view, _ in
                        view.backgroundColor = .systemRed
                        
                        self.viewModel?.input?.removeCellDidHandle(indexPath)
                    }
                ]
        )
    }
    
    // Cell configuration:
    
    private func configureToDoCell(for tableView: UITableView, with indexPath: IndexPath) -> UITableViewCell {
        guard indexPath.item < viewModel?.toDoItems.count ?? 0,
              let cell = tableView.dequeueReusableCell(withIdentifier: ToDoCell.viewIdentifier, for: indexPath) as? ToDoCell,
              let toDoItem = viewModel?.toDoItems[indexPath.item] else {
            return .init()
        }
        
        cell.toDoTitleLabel.text = "\(indexPath.item + 1). \(toDoItem.title ?? "")"
        cell.checkBox.checkBoxIsChecked = toDoItem.isFinished
        cell.toDoTitleLabel.layer.opacity = toDoItem.isFinished ? 0.5 : 1.0
        
        tableView.snp.updateConstraints { make in
            make.height.equalTo(tableView.contentSize.height)
        }
        cell.checkBox.checkBoxDidToggle = { [weak self] isChecked in
            self?.viewModel?.input?.checkBoxDidToggle((indexPath, isChecked))
            
            UIView.animate(withDuration: 0.4) {
                cell.toDoTitleLabel.layer.opacity = isChecked ? 0.5 : 1.0
            }
        }
        
        return cell
    }
}
