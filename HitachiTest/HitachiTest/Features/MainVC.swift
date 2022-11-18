//
//  MainVC.swift
//  HitachiTest
//
//  Created by Superman on 18/11/2022.
//

import UIKit

class MainVC: BaseViewController {
    
    @IBOutlet weak var apiTextField: CommonTextField!
    @IBOutlet weak var cityTextField: CommonTextField!
    
    @IBOutlet weak var btnSubmit: UIButton!

    private lazy var vm: MainViewModel = {
        return MainViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
        bind()
    }
    
    override func localized() {
        super.localized()
        apiTextField.title = "your_api_key".localized()
        cityTextField.title = "city_name".localized()
        
        btnSubmit.setTitle("submit".localized(), for: .normal)
    }
    
    private func setupUI(){
        apiTextField.textField.text = vm.apiKey
        setupPicker()
    }
    
    private func bind(){
        vm.$weatherDetailResponse
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] data in
                guard let `self` = self else { return }
                if let data = data, let current = data.current{
                    self.navigationController?.pushViewController(WeatherDetailVC.init(current: current), animated: true)
                }
            })
            .store(in: &self.cancellables)
    }
    
    @IBAction func btnSubmit(_ sender: Any) {
        if vm.selectedCity != ""{
            vm.apiKey = apiTextField.textField.text ?? ""
            vm.apply(.getWeatherDetail)
        }
       
    }
    
    @IBAction func btnChangeLanguage(_ sender: Any) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        _ = kLanguageType.allValues.map{
            let language = $0
            alertController.addAction(UIAlertAction.init(title: language.languageStr(), style: .default, handler: {_ in
                LanguageManager.shared.setCurrentLanguage(language)
                self.localized()
            }))
        }
        
        alertController.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
        self.present(alertController, animated: true)
    }
    
}


extension MainVC: UIPickerViewDataSource, UIPickerViewDelegate{
    
    private func setupPicker(){
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        
        cityTextField.textField.inputView = picker
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.vm.cityList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.vm.cityList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        cityTextField.textField.text = self.vm.cityList[row]
        vm.selectedCity = self.vm.cityList[row]
    }
}
