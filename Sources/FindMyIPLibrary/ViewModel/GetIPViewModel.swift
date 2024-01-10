//
//  GetIPViewModel.swift
//  FindMyIP
//
//  Created by Murugesh on 09/01/24.
//

import Foundation
import Combine


// MARK: - Enum
enum AppState:Equatable {
    static func == (lhs: AppState, rhs: AppState) -> Bool {
          switch (lhs, rhs) {
          case (.initial, .initial),
               (.loading, .loading),
               (.success, .success):
              return true
          case (.failed(_), .failed(_)):
              return false
          default:
              return false
          }
      }
    
    case initial
    case loading
    case success
    case failed(ErrorType)
}


// MARK: - GetIPViewModel
class GetIPViewModel:ObservableObject{
    
    @Published var state = AppState.initial
    @Published var getIPAPIResponse: GetIPAPIResponse?
    var subscriptions: Set<AnyCancellable> = []
    var networking: NetworkProtocol?

    // MARK: - Initializers
    init(networking: NetworkProtocol) {
        self.networking = networking
    }

    
    func getIpAPI() {
        self.state = .loading
        
        networking?.getIP()
            .sink {[weak self] completion in
                guard let self = self else { return }
                switch completion {
                case .failure(let error):
                    print(error)
                    if let code = error.responseCode {
                        self.state = .failed(.backend(code))
                    }
                    if error.isSessionTaskError {
                        self.state = .failed(.noInternet)
                    }
                    if error.isResponseSerializationError {
                        self.state = .failed(.decoding)
                    }
                case .finished:
                    break
                }
            } receiveValue: {[weak self] value in
                guard let self = self else { return }
                
                DispatchQueue.main.async {
                    self.getIPAPIResponse = value
                    self.state = .success
                }

            }
            .store(in: &subscriptions)
        
    }
}
