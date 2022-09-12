//
//  ToDoStepDescriptionView.swift
//  EasyList
//
//  Created by Basistyi, Yevhen on 01/09/2022.
//

import UIKit
import SnapKit

final class ToDoStepDescriptionView: UIView, IdentifiableView  {
    
    private let scrollView: UIScrollView = {
        $0.showsVerticalScrollIndicator = false
        return $0
    }(UIScrollView())
    
    private let contentView: UIView = {
        return $0
    }(UIView())
    
    private let clockImageView: UIImageView = {
        let configuration = UIImage.SymbolConfiguration.init(pointSize: 11, weight: .regular, scale: .default)
        $0.image = UIImage(systemName: "clock", withConfiguration: configuration)
        $0.tintColor = .secondaryLabel
        return $0
    }(UIImageView())
    
    let creationDateLabel: UILabel = {
        $0.text = "--"
        $0.font = .systemFont(ofSize: 11, weight: .regular)
        $0.textColor = .secondaryLabel
        return $0
    }(UILabel())
    
    let toDoItemTitleLabel: UILabel = {
        $0.text = "To Do Item Label"
        $0.font = .systemFont(ofSize: 18, weight: .regular)
        $0.textColor = .label
        return $0
    }(UILabel())
    
    private let titleLabel: UILabel = {
        $0.text = "Description"
        $0.font = .systemFont(ofSize: 13, weight: .semibold)
        $0.textColor = .secondaryLabel
        return $0
    }(UILabel())
    
    let descriptionLabel: UILabel = {
        $0.text = """
            Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.
            Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.
            Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.
            Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publ ishing software like Aldus PageMaker including versions of Lorem Ipsum.
            """
        $0.numberOfLines = 0
        $0.font = .systemFont(ofSize: 15, weight: .regular)
        $0.textAlignment = .justified
        return $0
    }(UILabel())
    
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
    
    func configureView() {
        backgroundColor = .systemBackground
    }
    
    // MARK: - View layouts
    
    private func addComponents() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(toDoItemTitleLabel)
        contentView.addSubview(creationDateLabel)
        contentView.addSubview(clockImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
    }
    
    private func anchorViews() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(snp.width)
        }
        toDoItemTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(32)
            make.left.equalToSuperview().inset(16)
            make.right.equalTo(clockImageView.snp.left).inset(8)
        }
        creationDateLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(16)
            make.centerY.equalTo(toDoItemTitleLabel)
        }
        clockImageView.snp.makeConstraints { make in
            make.right.equalTo(creationDateLabel.snp.left)
            make.centerY.equalTo(creationDateLabel)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(toDoItemTitleLabel.snp.bottom).offset(8)
            make.left.equalTo(toDoItemTitleLabel)
        }
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.right.left.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(32)
        }
    }
    
}
