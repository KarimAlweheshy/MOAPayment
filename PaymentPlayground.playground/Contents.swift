//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport
import Payment
import Networking

class Networking: NetworkingType {
    let modules: [ModuleType.Type] = [Module.self]
    
    func execute<T: Codable>(request: RemoteRequest,
                             completionHandler: @escaping (_ result: Result<T>) -> Void) {
    }
}

let request = PaymentPayRequest(data: PaymentPayRequestBody(amount: nil))

Networking().execute(request: request, presentationBlock: { (viewController) in
    PlaygroundPage.current.liveView = playgroundControllers(device: .phone4inch,
                                                            orientation: .portrait,
                                                            child: viewController)
}, dismissBlock: { (viewController) in
    PlaygroundPage.current.liveView = nil
}, completionHandler: { (result: Result<PaymentResponse>) in
    PlaygroundPage.current.liveView = nil
})
