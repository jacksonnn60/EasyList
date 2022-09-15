//
//  EasyListItemDetailsView.swift
//  EasyList
//
//  Created by Basistyi, Yevhen on 31/08/2022.
//

import UIKit
import SnapKit
import SwiftUI
import Resolver

final class ToDoItemListView: UIView {
    
    @OptionalInjected private var generalSettings: SettingsJourney.GeneralSettings?
    
    // MARK: - View components
    
    private lazy var geometryView: UIView = {
       return $0
    }(UIHostingController(rootView: AppStyleAnimatedView(generalSettings: generalSettings ?? .init())).view)
    
    private lazy var statusEffectView: UIVisualEffectView = {
        $0.effect = UIBlurEffect(style: .systemUltraThinMaterial)
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 4
        $0.contentView.addSubview(statusLabel)
        statusLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(16)
            make.top.bottom.equalToSuperview().inset(4)
        }
        return $0
    }(UIVisualEffectView())
    
    private lazy var dateEffectView: UIVisualEffectView = {
        $0.effect = UIBlurEffect(style: .systemUltraThinMaterial)
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 4
        $0.contentView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.right.left.equalToSuperview().inset(16)
            make.top.bottom.equalToSuperview().inset(4)
        }
        return $0
    }(UIVisualEffectView())
    
    let statusLabel: UILabel = {
        $0.font = .systemFont(ofSize: 15, weight: .semibold)
        $0.textColor = .systemBackground
        return $0
    }(UILabel())
    
    let dateLabel: UILabel = {
        $0.font = .systemFont(ofSize: 15, weight: .semibold)
        $0.textColor = .systemBackground
        return $0
    }(UILabel())
    
    private let scrollView: UIScrollView = {
        $0.showsVerticalScrollIndicator = false
        return $0
    }(UIScrollView())
    
    private let contentView: UIView = {
        return $0
    }(UIView())
    
    let imageView: UIImageView = {
        $0.isUserInteractionEnabled = true
        $0.clipsToBounds = true
        return $0
    }(UIImageView())
    
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
        contentView.addSubview(tableView)
        imageView.addSubview(dateEffectView)
        imageView.addSubview(statusEffectView)
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
        dateEffectView.snp.makeConstraints { make in
            make.right.top.equalToSuperview().inset(8)
        }
        statusEffectView.snp.makeConstraints { make in
            make.right.bottom.equalToSuperview().inset(8)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom)
            make.height.equalTo(1)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    func setImage(_ imageData: Data?) {
        
        if let imageData = imageData {
            refreshImageViewSubviews()
            
            imageView.image = UIImage(data: imageData)
        } else {
            imageView.addSubview(geometryView)
            
            geometryView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            
            colorImageViewSubviews()
        }
        
        imageView.bringSubviewToFront(dateEffectView)
        imageView.bringSubviewToFront(statusEffectView)
    }
    
    private func colorImageViewSubviews() {
        statusLabel.textColor = generalSettings?.colourStyle.options.shuffled().first
        dateLabel.textColor = generalSettings?.colourStyle.options.shuffled().first
        statusEffectView.layer.borderColor = generalSettings?.colourStyle.options.shuffled().first?.cgColor
        dateEffectView.layer.borderColor = generalSettings?.colourStyle.options.shuffled().first?.cgColor
        statusEffectView.layer.borderWidth = 1
        dateEffectView.layer.borderWidth = 1
    }
    
    private func refreshImageViewSubviews() {
        geometryView.removeFromSuperview()
        statusLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        statusLabel.textColor = .systemBackground
        dateLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        dateLabel.textColor = .systemBackground
        statusEffectView.layer.borderWidth = 0
        dateEffectView.layer.borderWidth = 0
    }
    
}
