//
//  PaymentsViewController.swift
//  ModuleArchitectureDemo
//
//  Created by Mladen Despotovic on 22/05/2018.
//  Copyright © 2018 Mladen Despotovic. All rights reserved.
//

import UIKit

protocol PaymentsView {
    func show(message: String)
}

final class PaymentsViewController: UIViewController {
    
    var presenter: PaymentsPresenter!
    
    @IBOutlet fileprivate var amountTextField: UITextField!
    @IBOutlet fileprivate var payButton: UIButton!
}

// MARK: - Actions
extension PaymentsViewController {
    @IBAction fileprivate func textDidChange(_ textField: UITextField) {
        if textField == amountTextField {
            presenter.didChange(amount: amountTextField.text)
        }
    }
    @IBAction fileprivate func payButtonAction(_ sender: UIButton) {
        presenter.pay()
    }
}

// MARK: - PaymentsView
extension PaymentsViewController: PaymentsView {
    func show(message: String) {
        let alertViewController = UIAlertController(title: "Messsage",
                                                    message: message, preferredStyle: .alert)
        alertViewController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertViewController, animated: true, completion: nil)
    }
}
