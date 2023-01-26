//
//  Constant.swift
//  CurrencyApp-Case
//
//  Created by Turan Çabuk on 26.01.2023.
//

import Foundation

enum currenciesAPICall: String {
    
    private var baseUrl: String {
        "https://psp-merchantpanel-service-sandbox.ozanodeme.com.tr/api/v1/dummy/coins"
    }
    
    case getCurrencies
    
    private var urlString: String {
        
        switch self {
        case.getCurrencies:
            return "\(baseUrl)"
        }
    }
    
    var url: URL {
        switch self {
        case.getCurrencies:
            return URL (string: "\(baseUrl)")!
        }
    }
}
