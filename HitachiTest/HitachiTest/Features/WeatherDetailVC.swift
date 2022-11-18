//
//  WeatherDetailVC.swift
//  HitachiTest
//
//  Created by Superman on 18/11/2022.
//

import UIKit

class WeatherDetailVC: BaseViewController {

    @IBOutlet weak var celciusTextField: CommonTextField!
    @IBOutlet weak var fahrenheitTextField: CommonTextField!
    
    @Published var current : Current?
    
    convenience init(current: Current) {
        self.init()
        self.current = current
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bind()
        // Do any additional setup after loading the view.
    }
    
    override func localized() {
        super.localized()
        celciusTextField.title = "celcius".localized()
        fahrenheitTextField.title = "fahrenheit".localized()
    }

    private func setupUI(){
        celciusTextField.textField.isEnabled = false
        fahrenheitTextField.textField.isEnabled = false
    }
    
    private func bind(){
        self.$current
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] data in
                guard let `self` = self else { return }
                self.celciusTextField.textField.text = "\(data?.tempC ?? 0)"
                self.fahrenheitTextField.textField.text = "\(data?.tempF ?? 0)"
            })
            .store(in: &self.cancellables)
    }


}
