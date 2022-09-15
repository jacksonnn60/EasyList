//
//  SettingsListView.swift
//  EasyList
//
//  Created by Jackson  on 14/09/2022.
//

import UIKit
import Resolver

class SettingsListView: UIView {
    
    @OptionalInjected private var generalSettings: SettingsJourney.GeneralSettings?
    
    var pickerDidHide: VoidClosure?
    
    private var color: UIColor? {
        generalSettings?.colourStyle.options.shuffled().first
    }
    
    // MARK: - View components
    
    lazy var pickerToolbar: UIToolbar = {
        $0.backgroundColor = (color ?? .systemBlue).withAlphaComponent(0.3)
        $0.tintColor = color ?? .systemBlue
        $0.items =
        [
            .flexibleSpace(),
            .init(title: "Done", style: .done, target: nil, action: #selector(doneBarButtonDidTap(_:)))
        ]
        return $0
    }(UIToolbar())
    
    lazy var pickerView: UIPickerView = {
        $0.backgroundColor = (color ?? .systemBlue).withAlphaComponent(0.3)
        return $0
    }(UIPickerView())
    
    let tableView: UITableView = {
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
        addSubview(pickerToolbar)
        
        pickerView.snp.makeConstraints { make in
            make.bottom.left.right.equalToSuperview()
        }
        pickerToolbar.snp.makeConstraints { make in
            make.bottom.equalTo(pickerView.snp.top)
            make.left.right.equalToSuperview()
        }
    }
    
    func hidePicker() {
        pickerToolbar.removeFromSuperview()
        pickerView.removeFromSuperview()
    }
    
    
    @objc private func doneBarButtonDidTap(_ toolBarItem: UIBarButtonItem) {
        hidePicker()
        pickerDidHide?()
    }
    
}
