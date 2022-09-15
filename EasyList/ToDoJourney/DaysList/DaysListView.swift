//
//  MainListView.swift
//  EasyList
//
//  Created by Basistyi, Yevhen on 31/08/2022.
//

import UIKit
import SnapKit

final class DaysListView: UIView {
    
    var newDateDidChoose: ((Date) -> ())? = nil
    
    // MARK: - View components
    
    private lazy var datePickerToolbar: UIToolbar = {
        let cancelItem = UIBarButtonItem.init(systemItem: .cancel)
        cancelItem.action = #selector(cancelToolbarItemDidTap(_:))
        
        let plusItem = UIBarButtonItem.init(systemItem: .add)
        plusItem.action = #selector(plusToolbarItemDidTap(_:))
        
        $0.items = [cancelItem, .flexibleSpace(), plusItem]
        
        return $0
    }(UIToolbar())
    
    private lazy var datePicker: UIDatePicker = {
        $0.datePickerMode = .date
        $0.preferredDatePickerStyle = .wheels
        $0.backgroundColor = .systemTeal.withAlphaComponent(0.2)
        $0.minimumDate = Date()
        
        return $0
    }(UIDatePicker())
    
    let tableView: UITableView = {
        $0.allowsSelection = true
        $0.separatorStyle = .none
        $0.showsVerticalScrollIndicator = false
        return $0
    }(UITableView())
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addComponents()
        anchorViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
}

// MARK: - Additional DatePicker Actions
extension DaysListView {
    
    func showDatePicker() {
        addSubview(datePicker)
        addSubview(datePickerToolbar)
        
        datePicker.snp.makeConstraints { make in
            make.right.left.bottom.equalToSuperview()
        }
        datePickerToolbar.snp.makeConstraints { make in
            make.bottom.equalTo(datePicker.snp.top)
            make.right.left.equalToSuperview()
        }
    }
    
    @objc func plusToolbarItemDidTap(_ item: UIBarButtonItem) {
        newDateDidChoose?(datePicker.date)
        cancelToolbarItemDidTap(item)
    }
    
    @objc func cancelToolbarItemDidTap(_ item: UIBarButtonItem) {
        datePicker.removeFromSuperview()
        datePickerToolbar.removeFromSuperview()
    }
    
}
