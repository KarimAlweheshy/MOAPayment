//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport
import Payment
import Networking

let consumer = PaymentConsumer(presentationBlock: { (viewController, _) in
    PlaygroundPage.current.liveView = playgroundControllers(device: .phone4inch,
                                                            orientation: .portrait,
                                                            child: viewController)
}, dismissBlock: { (viewController, _) in
    PlaygroundPage.current.liveView = nil
})

let request = PaymentPayRequest(data: PaymentPayRequestBody(amount: nil))

final class Networking: NetworkingType {
    func register(module: Module.Type) {}
    
    func execute<T: Codable>(request: InternalRequest,
                             presentationBlock: ((UIViewController, (() -> Void)?) -> Void)?,
                             dismissBlock: ((UIViewController, (() -> Void)?) -> Void)?,
                             completionHandler: @escaping (Result<T>) -> Void) {
        print("ask for auth token")
    }
    
    func execute<T: Codable>(request: InternalRequest,
                             completionHandler: @escaping (Result<T>) -> Void) {
        print("ask for auth token")
    }
    
    func execute<T: Codable>(request: RemoteRequest,
                             completionHandler: @escaping (Result<T>) -> Void) {}
}

consumer.execute(networking: Networking(), request: request) { (result: Result<PaymentResponse>) in
    PlaygroundPage.current.liveView = nil
}

