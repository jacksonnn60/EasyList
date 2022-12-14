//
//  SettingsListViewController.swift
//  EasyList
//
//  Created by Jackson  on 14/09/2022.
//

//import Foundation
import UIKit

final class SettingsListViewController: BaseViewController<SettingsListView> {
    
    var viewModel: SettingsListViewModel?
    
    // MARK: - Ligecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
        
        setUpOutput()
        
        baseView.pickerView.dataSource = self
        baseView.pickerView.delegate = self
        
        baseView.tableView.dataSource = self
        baseView.tableView.delegate = self
        baseView.tableView.register(SettingsListCell.self, forCellReuseIdentifier: SettingsListCell.viewIdentifier)
        
        viewModel?.setUpInput()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel?.input?.cellDidTap(nil)
        baseView.tableView.reloadData()
        baseView.hidePicker()
    }
    
}

// MARK: - SetUp Outputs

private extension SettingsListViewController {
    
    func setUpOutput() {
        viewModel?.output = .init(
            appColorDidChange: { colorStyle in
                let color = colorStyle?.options.shuffled().first
                self.tabBarController?.tabBar.tintColor = color
                self.baseView.pickerView.backgroundColor = color?.withAlphaComponent(0.3)
                self.baseView.pickerToolbar.backgroundColor = color?.withAlphaComponent(0.5)
                self.baseView.pickerToolbar.tintColor = color
                self.baseView.tableView.reloadData()
            }
        )
        
        baseView.pickerDidHide = {
            self.viewModel?.input?.cellDidTap(nil)
            self.baseView.tableView.reloadData()
        }
    }
    
}

// MARK: - UITableView DataSource

extension SettingsListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let viewModel = viewModel,
              let cell = tableView.dequeueReusableCell(withIdentifier: SettingsListCell.viewIdentifier, for: indexPath) as? SettingsListCell else {
            return .init()
        }
        
        switch indexPath.item {
        case 0:
            cell.titleLabel.text = SettingsJourney.GeneralSettings.Styles.AppStyle.sectionTitle
            cell.currentOptionLabel.text = viewModel.generalSettings?.appStyle.title
        case 1:
            cell.titleLabel.text = SettingsJourney.GeneralSettings.Styles.ColourStyle.sectionTitle
            cell.currentOptionLabel.text = viewModel.generalSettings?.colourStyle.title
        default:
            break
            
        }
        
        if let selectedIndex = viewModel.selectedSection, selectedIndex == indexPath.item {
            cell.representAsSelected()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

// MARK: - UITableView Delegate

extension SettingsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "Style"
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.input?.cellDidTap(indexPath)
        
        tableView.reloadData()
        
        baseView.showPicker()
        baseView.pickerView.reloadComponent(0)
        
    }
}

// MARK: - UIPickerViewDataSource

extension SettingsListViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch viewModel?.selectedSection ?? 0 {
        case 0: return SettingsJourney.GeneralSettings.Styles.AppStyle.allCases.count
        case 1: return SettingsJourney.GeneralSettings.Styles.ColourStyle.allCases.count
        default: return 0
        }
    }
}

// MARK: - UIPickerViewDelegate

extension SettingsListViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch viewModel?.selectedSection ?? 0 {
        case 0: return SettingsJourney.GeneralSettings.Styles.AppStyle(rawValue: row)?.title
        case 1: return SettingsJourney.GeneralSettings.Styles.ColourStyle(rawValue: row)?.title
        default: return "--"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        viewModel?.input?.pickerDidSelectRow(row)
    }

}
