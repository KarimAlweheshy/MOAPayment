//
//  PaymentsPresenter.swift
//  ModuleArchitectureDemo
//
//  Created by Mladen Despotovic on 28.06.18.
//  Copyright © 2018 Mladen Despotovic. All rights reserved.
//

import Foundation
import Networking

protocol PaymentsPresenter {
    func didChange(amount: String?)
    func pay()
}

final class PaymentsDefaultPresenter {
    fileprivate let resultCallback: ((Result<PaymentResponse>) -> Void)?
    fileprivate let interactor: PaymentsInteractor
    fileprivate let view: PaymentsView
    fileprivate var amount: String?
    
    init(resultCallback: ((Result<PaymentResponse>) -> Void)?,
         interactor: PaymentsInteractor,
         view: PaymentsView,
         amount: String?) {
        
        self.resultCallback = resultCallback
        self.interactor = interactor
        self.view = view
        self.amount = amount
    }
    
}

// MARK: - PaymentsPresenter
extension PaymentsDefaultPresenter: PaymentsPresenter {
    func didChange(amount: String?) {
        self.amount = amount
    }
    
    func pay() {
        guard let amountString = amount, let amount = Double(amountString) else {
            self.view.show(message: "Input a number")
            return
        }
        interactor.pay(amount: amount) { (result) in
            switch result {
            case .success:
                self.resultCallback?(result)
                self.view.show(message: "Payed Successfully")
            case .error(let error):
                self.view.show(message: error.localizedDescription)
            }
        }
    }
}
