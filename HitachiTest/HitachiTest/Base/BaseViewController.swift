//
//  BaseViewController.swift
//  HitachiTest
//
//  Created by Superman on 18/11/2022.
//

import UIKit
import Combine

class BaseViewController: UIViewController {
    var cancellables: [AnyCancellable] = []
    func localized() {}
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.localized()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.view.endEditing(true)
    }
        
}
