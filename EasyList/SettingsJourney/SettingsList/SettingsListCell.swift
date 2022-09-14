//
//  SettingsListCell.swift
//  EasyList
//
//  Created by Jackson  on 14/09/2022.
//

import UIKit

final class SettingsListCell: UITableViewCell, IdentifiableView {
    
    let titleLabel: UILabel = {
        return $0
    }(UILabel())
    
    let currentOptionLabel: UILabel = {
        $0.font = .systemFont(ofSize: 12, weight: .semibold)
        return $0
    }(UILabel())
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        addComponents()
        anchorViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        representAsDefault()
    }
    
    private func configure() {
        selectionStyle = .none
    }
    
    // MARK: - View Layouts
    
    private func addComponents() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(currentOptionLabel)
    }
    
    private func anchorViews() {
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(16)
        }
        currentOptionLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(16)
        }
    }

    func representAsSelected() {
        currentOptionLabel.textColor = .systemGray
    }
    
    func representAsDefault() {
        currentOptionLabel.textColor = .black
    }
    
}
