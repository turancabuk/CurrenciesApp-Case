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
            let changeColor = (change > 0) ? UIColor.blue : UIColor.red
            cryptoChange.textColor = changeColor
            cryptoVolume.textColor = changeColor
        }

//        let cryptoChangeValue = Double("\(cryptoChange)")!
//        let cryptoVolumeValue = Double("\(cryptoVolume)")!
//        let resultValue = cryptoVolumeValue / cryptoChangeValue
//        cryptoVolume.text = String(resultValue)
        
//        if let cryptoChangeValue = Double("\(article.change)"), let cryptoVolumeValue = Double("\(article.the24HVolume)") {
//            let resultValue = cryptoVolumeValue / cryptoChangeValue
//            cryptoVolume.text = String(resultValue)
//        }
        

//        let change = Double("\(article.change)")
//        let volume = Double("\(article.the24HVolume)")
//        let result = volume / change
//        cryptoVolume.text = String(result)
        
        if let priceValue = Double(article.price!), let changeValue = Double(article.change!) {
            let result = priceValue * changeValue * 100
            let roundedResult = (result * 10).rounded() / 100000
            cryptoVolume.text = String(roundedResult)
        }



        
        let url = URL(string: article.iconURL ?? "")
        SDImageCodersManager.shared.addCoder(SDImageSVGCoder.shared)
        cryptoImage.sd_setImage(with: url, completed: nil)

        
    }
    
}
