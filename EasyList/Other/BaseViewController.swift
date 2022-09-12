//
//  BaseViewController.swift
//  EasyList
//
//  Created by Basistyi, Yevhen on 31/08/2022.
//

import UIKit

class BaseViewController<BaseView : UIView>: UIViewController {
    
    var baseView: BaseView
    
    // MARK: - Init
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        baseView = BaseView()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifycycle
    
    override func loadView() {
        self.view = baseView
    }
    
}
