//
//  MainViewModel.swift
//  HitachiTest
//
//  Created by Superman on 18/11/2022.
//

import UIKit
import Combine


final class MainViewModel: BaseViewModel, ObservableObject {
    
    
    private lazy var request: WeatherDetailRequest = {
        return WeatherDetailRequest()
    }()

    private lazy var apiService: APIService = {
        return APIService()
    }()
    
    var apiKey = "ff9f895b2e884d6680530135202710"
    var selectedCity = ""
    private let sendSubject = PassthroughSubject<Void, Never>()
    
    // MARK: Input
    enum Input {
        case getWeatherDetail
    }
    //
    func apply(_ input: Input) {
        switch input {
        case .getWeatherDetail:
            self.request.params = ["key" : apiKey,"q" : selectedCity]
            
            self.sendSubject.send(())
        }
    }
    
    //    // MARK: Output
    @Published var weatherDetailResponse : WeatherDetailResponse?
    @Published var cityList: [String] = ["Kuala Lumpur", "Singapore"]
    
    override init() {
        super.init()
        
        self.bindInputs()
        self.bindOutputs()
    }
    
    private func bindInputs() {
        self.bindApiService(request: self.request, apiService: self.apiService, trigger: self.sendSubject) { [weak self] data in
            guard let `self` = self else { return }
           
            self.checkResponse(data: data, success: {
                self.weatherDetailResponse = data
            })
        }
    }

    
    private func bindOutputs() {
        
    }
    
    deinit{
        print("Deinit mainViewModel")
    }
    
}
