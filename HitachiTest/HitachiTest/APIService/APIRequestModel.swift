//
//  APIRequestModel.swift
//  HitachiTest
//
//  Created by Superman on 18/11/2022.
//

import Foundation
import Alamofire

enum APIMethod: String {
    case get = "GET"
    case post = "POST"
    case patch = "PATCH"
    case delete = "DELETE"
}

enum APIEncoding {
    case url
    case json
//    case multipart
}

protocol APIRequestType {
    associatedtype Response: Decodable
    
    var path: String { get }
    var params: [String: Any] { get set}
    var body: [String: Any] { get set}
    var method: HTTPMethod { get }
    
}

extension APIRequestType {

   var body: [String: Any] {
       get {return [:]} set {}
   }
}

extension APIRequestType {
    
    func getQueryItems() -> [URLQueryItem]? {
        return self.params.map {
            URLQueryItem(name: $0.0, value: "\($0.1)")
        }
    }
}
