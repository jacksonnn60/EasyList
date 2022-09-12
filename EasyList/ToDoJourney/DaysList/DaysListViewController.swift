//
//  ViewController.swift
//  EasyList
//
//  Created by Basistyi, Yevhen on 31/08/2022.
//

import UIKit
import Combine

final class DaysListViewController: BaseViewController<DaysListView> {
    
    var viewModel: DaysListViewModel?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBarItems()
        
        viewModel?.setUpInput()
        setUpTableView()
        setUpOutput()
        
        baseView.newDateDidChoose = viewModel?.input?.newDateDidChoose
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel?.input?.viewWillAppear()
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func configureNavigationBarItems() {
        title = "All Days List"
        let rightBarItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(rightBarButtonDidTap(_:)))
        navigationItem.setRightBarButton(rightBarItem, animated: false)
    }
    
}

// MARK: - SetUp Output

private extension DaysListViewController {
    
    func setUpOutput() {
        
        viewModel?.output = .init(
            
            dayItemsDidFetch: {
                UIView.transition(with: self.baseView.tableView, duration: 0.4, options: .transitionCrossDissolve) {
                    self.baseView.tableView.reloadData()
                }
            },
            
            errorDidAppear: { error in
                let errorAlert = UIAlertController(title: "Oops!", message: error.localizedDescription, preferredStyle: .alert)
                errorAlert.addAction(.init(title: "Ok", style: .default))
                self.present(errorAlert, animated: true)
            }
            
        )
        
    }
    
}

// MARK: - Setup Actions

private extension DaysListViewController {
    func setUpTableView() {
        baseView.tableView.dataSource = self
        baseView.tableView.delegate = self
        baseView.tableView.register(DayListCell.self, forCellReuseIdentifier: DayListCell.viewIdentifier)
    }
}


// MARK: - OBJC

private extension DaysListViewController {
    @objc func rightBarButtonDidTap(_ sender: UIBarButtonItem) {
        baseView.showDatePicker()
    }
}

// MARK: - UITableView Delegate

extension DaysListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.input?.cellDidTap((self, indexPath))
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        .init(
            actions:
                [
                    UIContextualAction(style: .normal, title: "Mark as done") { [unowned self] action, view, closure in
                        self.viewModel?.input?.dayDidMarkAsDone(indexPath)
                    }
                ]
        )
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        .init(
            actions:
                [
                    UIContextualAction(style: .destructive, title: "Remove") { action, view, closure in
                        action.backgroundColor = .secondarySystemFill
                        self.viewModel?.input?.removeCellDidHandle(indexPath)
                    }
                ]
        )
    }
    
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        .init(identifier: nil, previewProvider: nil) { _ in
            UIMenu(
                title: "Options",
                children:
                    [
                        UIAction(title: "Mark as done", image: .init(systemName: "checkmark.seal"), state: .off) { _ in
                            self.viewModel?.input?.dayDidMarkAsDone(indexPath)
                        },
                        UIAction(title: "Delete", image: .init(systemName: "trash"), attributes: .destructive, state: .off) { _ in
                            self.viewModel?.input?.removeCellDidHandle(indexPath)
                        }
                    ]
            )
        }
    }
    
}

// MARK: - UITableView DataSource

extension DaysListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        guard indexPath.item < viewModel?.dayItems?.count ?? 0,
              let cell = tableView.dequeueReusableCell(withIdentifier: DayListCell.viewIdentifier, for: indexPath) as? DayListCell,
              let dayItem = viewModel?.dayItems?[indexPath.item] else {
            
            return .init()
        }
        
        if let imageData = dayItem.imageData {
            cell.dayImageView.image = UIImage(data: imageData)
        } else {
            cell.dayImageView.backgroundColor =
            [
                .systemBlue,
                .systemCyan,
                .systemPink,
                .systemTeal
                
            ].shuffled().last
        }
        
        cell.dateLabel.text = dayItem.date?.getString(formated: .dayCell)
        cell.statusLabel.text = dayItem.isFinished ? "Done" : "You have something to do"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.dayItems?.count ?? 0
    }
}
