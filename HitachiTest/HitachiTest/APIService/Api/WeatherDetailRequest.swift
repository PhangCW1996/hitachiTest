//
//  WeatherDetailRequest.swift
//  HitachiTest
//
//  Created by Superman on 18/11/2022.
//

import Foundation
import Alamofire

class WeatherDetailRequest: APIRequestType {
   
    typealias Response = WeatherDetailResponse
    
    var path: String { return "/v1/current.json" }
    
    var params: [String: Any] = [:]
    
    var body: [String: Any] = [:]
    
    var method : HTTPMethod = .get
}

class WeatherDetailResponse: BaseResponse {
    
    let current: Current?
    
    private enum CodingKeys: String, CodingKey {
        case current = "current"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        current = try? values.decode(Current.self, forKey: .current)
        try super.init(from: decoder)
    }
    
    override public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try? container.encode(current, forKey: .current)
    }
}

// MARK: - Current
struct Current: Codable {
    let tempC: Double?
    let tempF: Double?

    enum CodingKeys: String, CodingKey {
        case tempC
        case tempF
    }
}

