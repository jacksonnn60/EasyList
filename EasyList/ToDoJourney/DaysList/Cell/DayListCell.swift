//
//  MainListCell.swift
//  EasyList
//
//  Created by Basistyi, Yevhen on 31/08/2022.
//

import UIKit
import SnapKit
import SwiftUI

final class DayListCell: UITableViewCell, IdentifiableView {
    
    // MARK: - View components
    
    private lazy var geometryView: UIView = {
       return $0
    }(UIHostingController(rootView: AppStyleAnimatedView()).view)
    
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
        $0.font = .systemFont(ofSize: 12, weight: .semibold)
        $0.textColor = .systemBackground
        return $0
    }(UILabel())
    
    let dateLabel: UILabel = {
        $0.font = .systemFont(ofSize: 13)
        $0.textColor = .systemBackground
        return $0
    }(UILabel())
    
    private let dayImageView: UIImageView = {
        $0.isUserInteractionEnabled = true
        return $0
    }(UIImageView())
    
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
        refreshImageViewSubviews()
        
        dayImageView.image = nil
        dayImageView.subviews.forEach { $0.removeFromSuperview() }
    }
    
    private func configureView() {
        contentView.clipsToBounds = true
        backgroundColor = .systemBackground
    }
    
    // MARK: - View layouts
    
    private func addComponents() {
        contentView.addSubview(dayImageView)
        contentView.addSubview(dateEffectView)
        contentView.addSubview(statusEffectView)
    }
    
    private func anchorViews() {
        dayImageView.snp.makeConstraints { make in
            make.height.equalTo(104)
            make.edges.equalToSuperview()
        }
        dateEffectView.snp.makeConstraints { make in
            make.right.bottom.equalToSuperview().inset(8)
        }
        statusEffectView.snp.makeConstraints { make in
            make.top.right.equalToSuperview().inset(8)
        }
    }
    
    func setImage(_ imageData: Data?) {
        if let imageData = imageData {
            dayImageView.image = UIImage(data: imageData)
        } else {
            dayImageView.addSubview(geometryView)
            
            geometryView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            
            colorImageViewSubviews()
            
            bringSubviewToFront(statusEffectView)
            bringSubviewToFront(dateEffectView)
        }
    }
    
    private func refreshImageViewSubviews() {
        statusLabel.font = .systemFont(ofSize: 12, weight: .semibold)
        statusLabel.textColor = .systemBackground
        dateLabel.font = .systemFont(ofSize: 13)
        dateLabel.textColor = .systemBackground
        statusEffectView.layer.borderWidth = 0
        dateEffectView.layer.borderWidth = 0
    }
    
    private func colorImageViewSubviews() {
        statusLabel.textColor = .randomColor
        dateLabel.textColor = .randomColor
        statusEffectView.layer.borderColor = UIColor.randomColor.cgColor
        dateEffectView.layer.borderColor = UIColor.randomColor.cgColor
        statusEffectView.layer.borderWidth = 1
        dateEffectView.layer.borderWidth = 1
    }
    
}
