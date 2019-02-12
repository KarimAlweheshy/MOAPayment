//
//  PaymentModule.swift
//  Payment
//
//  Created by Karim Alweheshy on 2/8/19.
//  Copyright © 2019 Karim Alweheshy. All rights reserved.
//

import UIKit
import Networking

open class PaymentModule: Module {
    public static var Facade: ModuleFacade.Type = PaymentFacade.self
    public static var Consumer: ModuleConsumer.Type = PaymentConsumer.self
}

open class PaymentFacade: ModuleFacade {
    public static var requestType: [InternalRequest.Type] = [PaymentPayRequest.self]
}

open class PaymentConsumer: ModuleConsumer {
    fileprivate let presentationBlock: ((UIViewController, (() -> Void)?) -> Void)?
    fileprivate let dismissBlock: ((UIViewController, (() -> Void)?) -> Void)?
    
    fileprivate weak var paymentsController: PaymentsViewController?
    
    public required init(presentationBlock: ((UIViewController, (() -> Void)?) -> Void)?, dismissBlock: ((UIViewController, (() -> Void)?) -> Void)?) {
        self.presentationBlock = presentationBlock
        self.dismissBlock = dismissBlock
    }
    
    public func execute<T: Codable>(networking: NetworkingType, request: InternalRequest, completionHandler: @escaping (Result<T>) -> Void) {
        if request is PaymentPayRequest {
            let paymentsController = PaymentsBuilder.make(networking: networking) { result in
                func reportResult() {
                    guard let result = result as? Result<T> else {
                        completionHandler(.error(ResponseError.other)) //Internal error//
                        return
                    }
                    
                    completionHandler(result)
                }
                
                if let paymentsController = self.paymentsController {
                    self.dismissBlock?(paymentsController) { reportResult() }
                } else {
                    reportResult()
                }
                
            }
            self.paymentsController = paymentsController
            presentationBlock?(paymentsController) {}
        } else {
            completionHandler(.error(ResponseError.other))
        }
    }
}
