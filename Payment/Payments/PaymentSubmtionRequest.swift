//
//  PaymentSubmtionRequest.swift
//  Payment
//
//  Created by Karim Alweheshy on 2/11/19.
//  Copyright © 2019 Karim Alweheshy. All rights reserved.
//

import Foundation
import Networking

struct PaymentSubmitonResponse: Codable {
}

struct PaymentSubmtionRequest: RemoteRequest {
    static let method: HTTPMethod = .get
    static let regexPath: String = "/pay"
    static let responseType = PaymentSubmitonResponse.self as Codable.Type
    
    var bodyData: Data?
}
