//
//  ViewModel.swift
//  CurrencyApp-Case
//
//  Created by Turan Çabuk on 26.01.2023.
//

import Foundation
import UIKit

final class CoinViewModel {
    
    let webservice = CurrenciesWebService()
    
    var coinsList: [Coin] = []


    func getCurrencies (completion: @escaping ([Coin]) -> Void) {
        webservice.fetch(response: Currencies.self, with: .getCurrencies) { [self] result in
            switch result {
            case.success(let response):
                if let coins = response.data?.coins {
                    self.coinsList = coins
                    completion(coins)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

}
