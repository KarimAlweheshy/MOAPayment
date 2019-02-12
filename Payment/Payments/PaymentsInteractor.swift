//
//  PaymentsInteractor.swift
//  ModuleArchitectureDemo
//
//  Created by Mladen Despotovic on 26.06.18.
//  Copyright © 2018 Mladen Despotovic. All rights reserved.
//

import UIKit
import Networking

protocol PaymentsInteractor {
    func pay(amount: Double, completionHandler: @escaping (Result<PaymentResponse>) -> Void)
}

final class PaymentsDefaultInteractor {
    fileprivate let networking: NetworkingType
    fileprivate let viewController: UIViewController
    
    init(networking: NetworkingType, viewController: UIViewController) {
        self.networking = networking
        self.viewController = viewController
    }
}

// MARK: - PaymentsInteractor
extension PaymentsDefaultInteractor: PaymentsInteractor {
    func pay(amount: Double, completionHandler: @escaping (Result<PaymentResponse>) -> Void) {
        let request = PaymentSubmtionRequest()
        self.networking.execute(request: request, completionHandler: completionHandler)
    }
}
