//
//  BaseResponse.swift
//  HitachiTest
//
//  Created by Superman on 18/11/2022.
//

import Foundation

class BaseResponse: Codable {

    var code: String?
    var msg: String?
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        code = try? container.decode(String.self, forKey: .code)
        msg = try? container.decode(String.self, forKey: .msg)
    }
    
}
