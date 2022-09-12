//
//  CheckBox.swift
//  EasyList
//
//  Created by Basistyi, Yevhen on 31/08/2022.
//

import UIKit
import SnapKit

final class CheckBox: UIView {
    
    typealias IsCheckedCheckbox = Bool
    
    var checkBoxDidToggle: ((IsCheckedCheckbox) -> ())?
    
    var checkBoxIsChecked: IsCheckedCheckbox = false {
        didSet {
            UIView.animate(withDuration: 0.375) {
                self.innerView.layer.opacity = self.checkBoxIsChecked ? 1.0 : 0.0
            }
        }
    }
    
    var mainColor: UIColor = .black {
        didSet {
            innerView.backgroundColor = mainColor
            layer.borderColor = mainColor.cgColor
        }
    }
    
    // MARK: - Views
    
    private let innerView: UIView = {
        $0.backgroundColor = .black
        return $0
    }(UIView())
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(innerView)
        innerView.layer.opacity = 0
        innerView.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
            make.size.equalToSuperview().multipliedBy(0.7)
        }
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(checkBoxDidToggle(_:))))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.borderWidth = 2
        layer.cornerRadius = bounds.height / 2
        backgroundColor = .clear
        innerView.layer.cornerRadius = innerView.bounds.height / 2
    }
    
    @objc func checkBoxDidToggle(_ gesture: UITapGestureRecognizer) {
        checkBoxIsChecked.toggle()
        checkBoxDidToggle?(checkBoxIsChecked)
    }
        
}
