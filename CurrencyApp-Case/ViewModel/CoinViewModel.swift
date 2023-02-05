//
//  ViewModel.swift
//  CurrencyApp-Case
//
//  Created by Turan Çabuk on 26.01.2023.
//

import Foundation

class CoinViewModel {
    
    let webService = CurrenciesWebService()
    
    var mainArray: [Coin] = []          // Response incoming
    var searchResultArray: [Coin] = []  // Search result temporary
    var coinsArray: [Coin] = []         // Show user array
    
    func getCurrencies(completion: @escaping ([Coin]) -> Void ) {
        
        webService.fetch(response: Currencies.self, with: .getCurrencies) { [self] result in
            switch result {
            case.success(let response):
                if let coins = response.data?.coins {
                    self.mainArray = coins
                    self.coinsArray = mainArray
                    completion(coins)
                }
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

