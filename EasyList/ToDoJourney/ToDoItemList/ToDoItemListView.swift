//
//  EasyListItemDetailsView.swift
//  EasyList
//
//  Created by Basistyi, Yevhen on 31/08/2022.
//

import UIKit
import SnapKit

final class ToDoItemListView: UIView {
    
    // MARK: - View components
    
    private let scrollView: UIScrollView = {
        $0.showsVerticalScrollIndicator = false
        return $0
    }(UIScrollView())
    
    private let contentView: UIView = {
        return $0
    }(UIView())
    
    let imageView: UIImageView = {
        $0.isUserInteractionEnabled = true
        return $0
    }(UIImageView())
    
    let statusLabel: UILabel = {
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 12, weight: .regular)
        return $0
    }(UILabel())
    
    let tableView: UITableView = {
        $0.allowsSelection = true
        $0.isScrollEnabled = false
        $0.separatorStyle = .none
        $0.showsVerticalScrollIndicator = false
        return $0
    }(UITableView(frame: .zero))
    
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
        contentView.addSubview(imageView)
        contentView.addSubview(statusLabel)
        contentView.addSubview(tableView)
    }
    
    private func anchorViews() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(snp.width)
        }
        imageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(snp.height).multipliedBy(0.3)
        }
        statusLabel.snp.makeConstraints { make in
            make.centerX.equalTo(imageView)
            make.top.equalTo(imageView.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(16)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(statusLabel.snp.bottom)
            make.height.equalTo(1)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
}
