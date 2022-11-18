//
//  APIServiceError.swift
//  HitachiTest
//
//  Created by Superman on 18/11/2022.
//

import Foundation
import Alamofire

struct NetworkError: Error {
  let initialError: AFError
  let backendError: BackendError?
}

struct BackendError: Codable, Error {
    var status: String
    var message: String
}
