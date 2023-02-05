//
//  CryptoDetailCell.swift
//  CurrencyApp-Case
//
//  Created by Turan Çabuk on 27.01.2023.
//

import UIKit
import SDWebImageSVGCoder


class CryptoDetailCell: UITableViewCell {
    
    
    @IBOutlet weak var cryptoSymbol: UILabel!
    @IBOutlet weak var cryptoName: UILabel!
    @IBOutlet weak var cryptoCurrentPrice: UILabel!
    @IBOutlet weak var cryptoVolume: UILabel!
    @IBOutlet weak var cryptoChange: UILabel!
    @IBOutlet weak var cryptoImage: UIImageView!
    
    func configCell(article: Coin!) {
        cryptoSymbol.text = article.symbol
        cryptoName.text = article.name
        
        let originalValue = Double(article.price!)
        let roundedValue = String(format: "%.2f", originalValue!)
        cryptoCurrentPrice.text = "$\(roundedValue)"
        
        if let change = Double(article.change!) {
            cryptoChange.text = article.change
            let changeColor = (change > 0) ? UIColor.systemGreen : UIColor.red
            cryptoChange.textColor = changeColor
            cryptoVolume.textColor = changeColor
        }
        
        if let priceValue = Double(article.price!), let changeValue = Double(article.change!) {
            let result = priceValue * changeValue
            let roundedResult = (result ).rounded() / 100
            cryptoVolume.text = String(roundedResult)
        }
        
        let url = URL(string: article.iconURL ?? "")
        SDImageCodersManager.shared.addCoder(SDImageSVGCoder.shared)
        cryptoImage.sd_setImage(with: url, completed: nil)
    }
}
