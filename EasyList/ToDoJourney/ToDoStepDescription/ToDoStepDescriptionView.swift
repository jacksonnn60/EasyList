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
    
//    private let clockImageView: UIImageView = {
//        let configuration = UIImage.SymbolConfiguration.init(pointSize: 11, weight: .regular, scale: .default)
//        $0.image = UIImage(systemName: "clock", withConfiguration: configuration)
//        $0.tintColor = .secondaryLabel
//        return $0
//    }(UIImageView())
    
//    let creationDateLabel: UILabel = {
//        $0.text = "--"
//        $0.font = .systemFont(ofSize: 11, weight: .regular)
//        $0.textColor = .secondaryLabel
//        return $0
//    }(UILabel())
    
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
    
    let descriptionTextView: UITextView = {
        $0.isUserInteractionEnabled = false
        $0.font = .systemFont(ofSize: 15, weight: .regular)
        $0.textAlignment = .justified
        return $0
    }(UITextView())
    
    let editButton: UIButton = {
        $0.setTitle("Edit", for: .normal)
        $0.backgroundColor = .systemBlue
        $0.layer.cornerRadius = 12
        return $0
    }(UIButton())
    
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
//        contentView.addSubview(creationDateLabel)
        contentView.addSubview(editButton)
//        contentView.addSubview(clockImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionTextView)
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
            make.right.equalTo(editButton.snp.left).inset(8)
        }
        editButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(16)
            make.centerY.equalTo(toDoItemTitleLabel)
            make.width.equalTo(80)
            make.height.equalTo(34)
        }
        //        clockImageView.snp.makeConstraints { make in
        //            make.right.equalTo(saveButton.snp.left)
        //            make.centerY.equalTo(saveButton)
        //        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(toDoItemTitleLabel.snp.bottom).offset(8)
            make.left.equalTo(toDoItemTitleLabel)
        }
        descriptionTextView.snp.makeConstraints { make in
            make.height.equalTo(0)
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.right.equalToSuperview().inset(16)
            make.left.equalTo(toDoItemTitleLabel)
            make.bottom.equalToSuperview().inset(32)
        }
    }
}
