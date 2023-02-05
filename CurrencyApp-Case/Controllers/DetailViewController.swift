//
//  DetailViewController.swift
//  CurrencyApp-Case
//
//  Created by Turan Çabuk on 29.01.2023.
//

import UIKit
import SDWebImageSVGCoder

class DetailViewController: UIViewController {
    
    var article: Coin?
    
    @IBOutlet weak var viewBackgroundImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var cryptoImageView: UIImageView!
    @IBOutlet weak var currentPriceLabel: UILabel!
    @IBOutlet weak var changeLabel: UILabel!
    @IBOutlet weak var volumeLabel: UILabel!
    @IBOutlet weak var highLabel: UILabel!
    @IBOutlet weak var lowLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configCell(article: article)
        
    }
    func configCell(article: Coin!) {
        
        if let article = self.article {
            
            nameLabel.text = article.name
            symbolLabel.text = article.symbol
            
            let originalValue = Double(article.price ?? "5")
            let roundedValue = String(format: "%.2f", originalValue!)
            currentPriceLabel.text = "$\(roundedValue)"
            
            if let change = Double(article.change ?? "12") {
                changeLabel.text = article.change
                let changeColor = (change > 0) ? UIColor.systemGreen : UIColor.red
                changeLabel.textColor = changeColor
                volumeLabel.textColor = changeColor
            }
            if let priceValue = Double((article.price)!), let changeValue = Double((article.change)!) {
                let result = priceValue * changeValue
                let roundedResult = (result ).rounded() / 100
                volumeLabel.text = String(roundedResult)
            }
            let url = URL(string: article.iconURL ?? "")
            SDImageCodersManager.shared.addCoder(SDImageSVGCoder.shared)
            cryptoImageView.sd_setImage(with: url, completed: nil)
            
            highLabel.text = "$\(String(format: "%.2f", (article.sparkline?.map{Double($0)!}.max() ?? 0.00)))"
            lowLabel.text = "$\(String(format: "%.2f", (article.sparkline?.map{Double($0)!}.min() ?? 0.00)))"
            
        }
    }
}

