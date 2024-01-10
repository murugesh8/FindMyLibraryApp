//
//  FindMyIPTests.swift
//  FindMyIPTests
//
//  Created by Murugesh on 09/01/24.
//

import XCTest
import Combine
import Alamofire

@testable import FindMyIPLibrary
open class FindMyIPLibraryTests: XCTestCase {

    var cancellables: Set<AnyCancellable> = []

    var getIpViewModel: GetIPViewModel?
    
    var mockNetwork:MockNetworkManager?
    
    public override init() {
        super.init()
    }
   
    public override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        
        let mockNetworkManager = MockNetworkManager()
        self.getIpViewModel = GetIPViewModel(networking: mockNetworkManager)
        self.mockNetwork = getIpViewModel?.networking as? MockNetworkManager

    }

    public override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.getIpViewModel = nil
        self.mockNetwork = nil
        super.tearDown()
    }
    
    // MARK: - Success Test Case
    public func testGetIPAPISuccess(){

        let expectation = XCTestExpectation(description: "Get IP API call expectation")

        let expected = GetIPAPIResponse(ip: "192.168.1.1", network: "2405:201:e000", version: "1.0.2", city: "Chennai", region: "Tamil Nadu", regionCode: "TN", country: "IN", countryName: "India", countryCode: "IN", countryCodeIso3: "04", countryCapital: "New Delhi", countryTLD: ".in", continentCode: "1020", inEu: true, postal: "600001", latitude: 10.50, longitude: 20.19, timezone: "+5.30", utcOffset: "10", countryCallingCode: "+91", currency: "IN", currencyName: "Rupee", languages: "Hindi", countryArea: 10, countryPopulation: 11, asn: "100", org: "Photon")

        self.mockNetwork?.shouldReturnError = false
        
        self.mockNetwork?.getIP()
                   .sink { completion in
                       switch completion {
                       case .failure:
                           XCTFail("Expected a successful completion")
                       case .finished:
                           break
                       }
                   } receiveValue: { value in
                       XCTAssertEqual(value, expected) // Adjust based on your expected response
                       expectation.fulfill()
                   }
                   .store(in: &cancellables)
   

            wait(for: [expectation], timeout: 1.0)

            // Assert any expectations or outcomes here
    }
    
    // MARK: - Failure Test Case
    public func testGetIPFailure() {
        let expectation = XCTestExpectation(description: "Get IP API call expectation")

        // Set up your mock networking to return an error
      

        self.mockNetwork?.shouldReturnError = true
        
        let expectedError = AFError.invalidURL(url: "https://ipapi./json/")
        
        self.mockNetwork?.getIP()
            .sink { completion in
                switch completion {
                case .failure(let error):
                    XCTAssertEqual(error.localizedDescription, expectedError.localizedDescription)
                    expectation.fulfill()
                case .finished:
                    XCTFail("Expected a failure completion")
                }
            } receiveValue: { _ in
                XCTFail("Expected a failure value")
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 5.0)
    }
}
