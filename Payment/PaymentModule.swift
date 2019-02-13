//
//  PaymentModule.swift
//  Payment
//
//  Created by Karim Alweheshy on 2/8/19.
//  Copyright © 2019 Karim Alweheshy. All rights reserved.
//

import UIKit
import Networking

open class Module: ModuleType {
    public static var capabilities: [InternalRequest.Type] = [PaymentPayRequest.self]
    
    fileprivate let presentationBlock: (UIViewController) -> Void
    fileprivate let dismissBlock: (UIViewController) -> Void
    
    public required init(presentationBlock: @escaping (UIViewController) -> Void,
                         dismissBlock: @escaping (UIViewController) -> Void) {
        self.presentationBlock = presentationBlock
        self.dismissBlock = dismissBlock
    }
    
    public func execute<T: Codable>(networking: NetworkingType,
                                    request: InternalRequest,
                                    completionHandler: @escaping (Result<T>) -> Void) {
        guard let completionBlock = completionHandler as? ((Result<PaymentResponse>) -> Void) else {
            completionHandler(.error(ResponseError.badRequest400(error: nil)))
            return
        }
        
        if request is PaymentPayRequest {
            var paymentsController: PaymentsViewController!
            paymentsController = PaymentsBuilder.make(networking: networking) { result in
                self.dismissBlock(paymentsController)
                completionBlock(result)
            }
            presentationBlock(paymentsController)
        } else {
            completionHandler(.error(ResponseError.badRequest400(error: nil)))
        }
    }
}
