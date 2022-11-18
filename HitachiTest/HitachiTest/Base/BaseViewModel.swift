//
//  BaseViewModel.swift
//  HitachiTest
//
//  Created by Superman on 18/11/2022.
//

import Foundation
import Combine

class BaseViewModel {
    @Published var loading: Bool = false
    @Published var headLoading: Bool = false
    @Published var footLoading: Bool = false

    var cancellables: [AnyCancellable] = []
    
    init() {
        self.$loading
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] isLoading in
                guard self != nil else { return }
                if isLoading {
                    //Show Loading
                }else {
                    //Hide Loading
                }
            })
            .store(in: &self.cancellables)
        
    }
    
    func checkResponse<T>(data:T? ,stat: Bool = true, code: String = "-1", msg: String = "", success: @escaping () -> Void) {
        if data != nil{
            success()
        }else{
            print("Error Msg")
        }

    }
        
}


// MARK: Bindings
extension BaseViewModel {
    
    func bindApiService<T: APIRequestType>(request: T, apiService: APIService, trigger: PassthroughSubject<Void, Never>, success: @escaping (T.Response) -> Void) {
        trigger.flatMap { [apiService] _ in
    
            apiService.response(from: request)

        }
//        #if DEV
        .print()
//        #endif
        .sink(receiveValue: { [weak self] data in
            guard let _ = self else { return }
        
            if let data = data.value {
                success(data)
            }
        })
        .store(in: &self.cancellables)
    }
    
    
}
