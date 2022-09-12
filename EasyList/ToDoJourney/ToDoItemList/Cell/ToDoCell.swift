//
//  ToDoCell.swift
//  EasyList
//
//  Created by Basistyi, Yevhen on 31/08/2022.
//

import UIKit
import SnapKit

final class ToDoCell: UITableViewCell, IdentifiableView {
    
    lazy var checkBox: CheckBox = {
        $0.mainColor = .systemGreen
        return $0
    }(CheckBox())
    
    let toDoTitleLabel: UILabel = {
        $0.font = .systemFont(ofSize: 18, weight: .regular)
        return $0
    }(UILabel())
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
        addComponents()
        anchorViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        checkBox.checkBoxIsChecked = false
    }
    
    private func configureView() {
        selectionStyle = .none
        backgroundColor = .systemBackground
    }
    
    // MARK: - View layouts
    
    private func addComponents() {
        contentView.addSubview(toDoTitleLabel)
        contentView.addSubview(checkBox)
    }
    
    private func anchorViews() {
        toDoTitleLabel.snp.makeConstraints { make in
            make.height.equalTo(52)
            make.left.equalToSuperview().inset(18)
            make.top.bottom.equalToSuperview()
        }
        checkBox.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(22)
            make.centerY.equalTo(toDoTitleLabel)
            make.size.equalTo(28)
        }
    }
    
}
