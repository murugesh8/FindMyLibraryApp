//
//  Network.swift
//  FindMyIP
//
//  Created by Murugesh on 09/01/24.
//


import Foundation
import Combine
import Alamofire

protocol NetworkProtocol {
    func getIP() -> AnyPublisher<GetIPAPIResponse, AFError>
}

struct NetworkManager: NetworkProtocol {
    func getIP() -> AnyPublisher<GetIPAPIResponse, AFError> {

        let url = URL(string: "https://ipapi.co/json/")!
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]

        return AF.request(url,
                          method: .get,
                          parameters: [:],
                          headers: headers
                          )
            .validate()
            .publishDecodable(type: GetIPAPIResponse.self)
            .value()
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
