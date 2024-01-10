//
//  ErrorView.swift
//  FindMyIP
//
//  Created by Murugesh on 10/01/24.
//

import SwiftUI


enum ErrorType {
    case decoding
    case noInternet
    case backend(Int)
}

struct ErrorView: View {
    
    let error: ErrorType
    var retryTapAction : (() -> ()) = {}

    var body: some View {
        VStack {
            Text("Something went wrong")
                .font(.title)
                .padding()
            Group {
                switch error {
                case .decoding:
                    Text("Please contact developer")
                        .font(.customFont(fontWeight: .medium, fontSize: 15))
                case .noInternet:
                    Text("Please check your internet connection")
                        .font(.customFont(fontWeight: .medium, fontSize: 15))

                case .backend(let code):
                    switch code {
                    case 403:
                        Text("Github API limit reached, wait a second")
                            .font(.customFont(fontWeight: .medium, fontSize: 15))

                    case 503:
                        Text("Service unavailable")
                            .font(.customFont(fontWeight: .medium, fontSize: 15))

                    default:
                        Text("Server error code: \(code)")
                            .font(.customFont(fontWeight: .medium, fontSize: 15))

                    }
                }
            }
            .padding()
        }
    }
}

