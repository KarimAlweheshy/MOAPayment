//
//  PaymentsBuilder.swift
//  Payment
//
//  Created by Karim Alweheshy on 2/8/19.
//  Copyright © 2019 Karim Alweheshy. All rights reserved.
//

import UIKit
import Networking

final class PaymentsBuilder: NSObject {
    static func make(networking: NetworkingType, resultCallback: @escaping (Result<PaymentResponse>) -> Void) -> PaymentsViewController {
        let storyboard = UIStoryboard(name: "Payments", bundle: Bundle(for: self))
        let viewController = storyboard.instantiateInitialViewController() as! PaymentsViewController
        let interactor = PaymentsDefaultInteractor(networking: networking, viewController: viewController)
        let presenter = PaymentsDefaultPresenter(resultCallback: resultCallback,
                                                 interactor: interactor,
                                                 view: viewController,
                                                 amount: nil)
        viewController.presenter = presenter
        return viewController
    }
}
