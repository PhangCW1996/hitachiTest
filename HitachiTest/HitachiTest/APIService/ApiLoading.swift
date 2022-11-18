//
//  ApiLoading.swift
//  HitachiTest
//
//  Created by Superman on 18/11/2022.
//

import Foundation

final class ApiLoading {
    @Published
    var loading: Bool = false
    
    init(loading: Bool) {
        self.loading = loading
    }
}
