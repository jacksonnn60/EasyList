//
//  SettingsListCell.swift
//  EasyList
//
//  Created by Jackson  on 14/09/2022.
//

import UIKit
import Resolver

final class SettingsListCell: UITableViewCell, IdentifiableView {
    
    @OptionalInjected private var generalSettings: SettingsJourney.GeneralSettings?
    
    private var color: UIColor? {
        generalSettings?.colourStyle.options.shuffled().first
    }
    
    // MARK: - View Components
    
    lazy var titleLabel: UILabel = {
        return $0
    }(UILabel())
    
    lazy var currentOptionLabel: UILabel = {
        $0.textColor = color ?? .black
        $0.font = .systemFont(ofSize: 14, weight: .bold)
        return $0
    }(UILabel())

//    private lazy var stackView: UIStackView = { stackView in
//        stackView.distribution = .fillEqually
//        stackView.axis = .horizontal
//
//        generalSettings?.appStyle.options.forEach { systemImageName in
//            let imageView = UIImageView(frame: .init(origin: .zero, size: .init(width: 18, height: 18)))
//            imageView.image = .init(systemName: systemImageName)
//            stackView.addArrangedSubview(imageView)
//        }
//
//        return stackView
//    }(UIStackView())
    
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
//        if titleLabel.text == SettingsJourney.GeneralSettings.Styles.AppStyle.sectionTitle {
//            stackView.snp.makeConstraints { make in
//                make.left.equalTo(titleLabel.snp.right).offset(16)
//                make.centerY.equalToSuperview()
//            }
//        }
    }

    func representAsSelected() {
        currentOptionLabel.textColor = .systemGray
    }
    
    func representAsDefault() {
        currentOptionLabel.textColor = color ?? .black
    }
    
}
