//
//  NetworkErrorView.swift
//  FindMyIP
//
//  Created by Murugesh on 10/01/24.
//

import Foundation
import SwiftUI


struct NetworkErrorView: View {
    var retryTapAction : (() -> ()) = {}


    var body: some View {
        ZStack{
            Color.white
                .frame(maxWidth:.infinity,maxHeight: .infinity)
            
            VStack {
                Spacer()

                Text("Oops! Slow or no internet")
                    .font(.customFont(fontWeight: .semibold, fontSize: 24))
                    .kerning(-0.33)
                    .padding()
                Text("Please check your internet connection and try again")
                    .font(.customFont(fontWeight: .regular, fontSize: 16))
                    .kerning(-0.33)
                    .opacity(0.5)
                    .padding([.leading, .trailing, .bottom])
                Spacer()
                
                Button {
                    retryTapAction()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: UIScreen.main.bounds.size.width - 50, height: 50, alignment: .center)
                            .foregroundColor(Color.blue)
                            .offset(x: 4, y: 4)
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: UIScreen.main.bounds.size.width - 50, height: 50, alignment: .center)
                            .foregroundColor(Color.blue)
                        
                        HStack {
                            Text("Try Again")
                                .font(.customFont(fontWeight: .medium, fontSize: 16))
                                .foregroundColor(.white)
                        }
                    }
                }
                .frame(width: UIScreen.main.bounds.size.width - 40, height: 60)
                .padding(.bottom,20)

            }
        }
    }
}
