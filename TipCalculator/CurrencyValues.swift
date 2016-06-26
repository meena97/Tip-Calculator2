//
//  CurrencyValues.swift
//  TipCalculator
//
//  Created by Meena Sengottuvelu on 6/25/16.
//  Copyright © 2016 Meena Sengottuvelu. All rights reserved.
//

import Foundation

enum CurrencyValues: Int {
    case Dollar = 0, Euro, Pound, Yen
    
    static let allValues = [Dollar, Euro, Pound, Yen]
    
    func symbol() -> String {
        switch self {
        case .Dollar:
            return "$"
        case .Euro:
            return "€"
        case .Pound:
            return "£"
        case .Yen:
            return "¥"
        }
    }
    
    func currencyType() -> String {
        switch self {
        case .Dollar:
            return "Dollar"
        case .Euro:
            return "Euro"
        case .Pound:
            return "Pound"
        case .Yen:
            return "Yen"
        }
    }
}
