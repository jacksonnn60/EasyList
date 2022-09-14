//
//  SettingsListView.swift
//  EasyList
//
//  Created by Jackson  on 14/09/2022.
//

import UIKit

class SettingsListView: UIView {
    
    lazy var pickerView: UIPickerView = {
        $0.backgroundColor = .lightGray
        return $0
    }(UIPickerView())
    
    let tableView: UITableView = {
//        $0.allowsSelection = false
        return $0
    }(UITableView(frame: .zero, style: .insetGrouped))
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        addComponents()
        anchorViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        backgroundColor = .white
    }
    
    // MARK: - View layouts
    
    private func addComponents() {
        addSubview(tableView)
    }
    
    private func anchorViews() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func showPicker() {
        addSubview(pickerView)
        pickerView.snp.makeConstraints { make in
            make.bottom.left.right.equalToSuperview()
        }
    }
    
    func hidePicker() {
        pickerView.removeFromSuperview()
    }
    
}
