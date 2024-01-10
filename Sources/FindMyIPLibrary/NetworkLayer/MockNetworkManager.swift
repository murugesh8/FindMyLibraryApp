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
        // Provide a mock implementation for testing
        let mockResponse = GetIPAPIResponse(ip: "192.168.1.1", network: "2405:201:e000", version: "", city: "Chennai", region: "Tamil Nadu", regionCode: "TN", country: "IN", countryName: "India", countryCode: "IN", countryCodeIso3: "04", countryCapital: "New Delhi", countryTLD: ".in", continentCode: "1020", inEu: true, postal: "600001", latitude: 10.500, longitude: 102, timezone: "", utcOffset: "", countryCallingCode: "", currency: "", currencyName: "", languages: "", countryArea: 10, countryPopulation: 11, asn: "", org: "")
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
