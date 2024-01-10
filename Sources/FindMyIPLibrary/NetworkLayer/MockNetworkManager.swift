//
//  MockNetworkManager.swift
//  FindMyIP
//
//  Created by Murugesh on 10/01/24.
//

import Foundation
import Combine
import Alamofire

struct MockNetworkManager: NetworkProtocol {
    
    var shouldReturnError = false

    func getIP() -> AnyPublisher<GetIPAPIResponse, AFError> {
        let mockResponse = GetIPAPIResponse(ip: "192.168.1.1", network: "2405:201:e000", version: "1.0.2", city: "Chennai", region: "Tamil Nadu", regionCode: "TN", country: "IN", countryName: "India", countryCode: "IN", countryCodeIso3: "04", countryCapital: "New Delhi", countryTLD: ".in", continentCode: "1020", inEu: true, postal: "600001", latitude: 10.50, longitude: 20.19, timezone: "+5.30", utcOffset: "10", countryCallingCode: "+91", currency: "IN", currencyName: "Rupee", languages: "Hindi", countryArea: 10, countryPopulation: 11, asn: "100", org: "Photon")

        if shouldReturnError{
            return Fail(error: AFError.invalidURL(url: "https://ipapi./json/"))
                 .eraseToAnyPublisher()
        }else{
            return Just(mockResponse)
                .setFailureType(to: AFError.self)
                .eraseToAnyPublisher()
        }
    
    }
}
