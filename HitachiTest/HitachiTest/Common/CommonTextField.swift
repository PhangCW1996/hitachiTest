//
//  CommonTextField.swift
//  HitachiTest
//
//  Created by Superman on 18/11/2022.
//

import UIKit
import Combine

@IBDesignable
class CommonTextField: UIView {
    
    @IBOutlet var view: UIView!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    var nibName: String {
         return String(describing: type(of: self))
    }
    
    var title: String? {
        didSet {
            guard let title = title else { return }
            lblTitle.text = title
        }
    }

    var cancellables: [AnyCancellable] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override func prepareForInterfaceBuilder() {
        commonInit()
    }
    
    func commonInit() {
        let bundle = Bundle(for: CommonTextField.self)
        guard let customView = UINib(nibName: nibName, bundle: bundle).instantiate(withOwner: self).first as? UIView else { return }
        customView.frame = bounds
        customView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(customView)
        view = customView
        self.view.backgroundColor = .clear
        backgroundColor = .clear
        bind()
        setupUI()
    }
    
    private func setupUI(){
  
    }
    
    private func bind() {

    }
}
