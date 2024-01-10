//
//  Extension.swift
//  FindMyIP
//
//  Created by Murugesh on 10/01/24.
//

import SwiftUI



struct Resources {

    enum Weight: String {
        case light = "Poppins-Light"
        case regular = "Poppins-Regular"
        case medium = "Poppins-Medium"
        case semibold = "Poppins-Semibold"
        case bold = "Poppins-Bold"

    }
}

extension Font{
    
    
    static func customFont(fontWeight:Weight,fontSize:CGFloat) -> Font{
        switch fontWeight {
        case .light:
            return  Font.custom(Resources.Weight.light.rawValue, fixedSize: fontSize)
        case .regular:
            return  Font.custom(Resources.Weight.regular.rawValue, fixedSize: fontSize)
        case .medium:
            return  Font.custom(Resources.Weight.medium.rawValue, fixedSize: fontSize)

        case .semibold:
            return  Font.custom(Resources.Weight.semibold.rawValue, fixedSize: fontSize)

        case .bold:
            return  Font.custom(Resources.Weight.bold.rawValue, fixedSize: fontSize)
     
        default:
            return  Font.custom(Resources.Weight.regular.rawValue, fixedSize: fontSize)
        }
    }
}
