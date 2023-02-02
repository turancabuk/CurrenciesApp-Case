//
//  ViewController.swift
//  CurrencyApp-Case
//
//  Created by Turan Çabuk on 26.01.2023.
//

import UIKit



class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var viewModel : CoinViewModel!
    
    
    let menuView = UIView(frame: CGRect(x: 260, y: 100, width: 140, height: 150))
    let priceButton = UIButton(frame: CGRect(x: 20, y: 50, width: 100, height: 20))
    let marketCapButton = UIButton(frame: CGRect(x: 20, y: 20, width: 100, height: 20))
    let changeButton = UIButton(frame: CGRect(x: 20, y: 80, width: 100, height: 20))
    let the24hVolume = UIButton(frame: CGRect(x: 20, y: 110, width: 100, height: 20))
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var rankingList: UINavigationItem!
    @IBOutlet weak var searchBar: UISearchBar!

    var selectedTitle: String?
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        menuView.layer.cornerRadius = 20
        menuView.layer.masksToBounds = true
        view.addSubview(menuView)
//         MARK: HamburgerMenu
        menuView.backgroundColor = UIColor(red: 119/255, green: 104/255, blue: 180/255, alpha: 1)
        menuView.isHidden = true
        priceButton.backgroundColor = .clear
        priceButton.setTitle("Price", for: .normal)
        priceButton.setTitleColor(UIColor.black, for: .normal)
        priceButton.addTarget(self, action: #selector(sortByPrice), for: .touchUpInside)
        marketCapButton.backgroundColor = .clear
        marketCapButton.setTitle("Market Cap", for: .normal)
        marketCapButton.setTitleColor(UIColor.black, for: .normal)
        marketCapButton.addTarget(self, action: #selector(sortByMarketCap), for: .touchUpInside)
        changeButton.backgroundColor = .clear
        changeButton.setTitle("Change", for: .normal)
        changeButton.setTitleColor(UIColor.black, for: .normal)
        changeButton.addTarget(self, action: #selector(sortByChange), for: .touchUpInside)
        the24hVolume.backgroundColor = .clear
        the24hVolume.setTitle("24h Volume", for: .normal)
        the24hVolume.setTitleColor(UIColor.black, for: .normal)
        the24hVolume.addTarget(self, action: #selector(sortByVolume), for: .touchUpInside)
        menuView.addSubview(marketCapButton)
        menuView.addSubview(priceButton)
        menuView.addSubview(changeButton)
        menuView.addSubview(the24hVolume)
        
        
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
       
        viewModel = CoinViewModel()
        viewModel?.getCurrencies {_ in
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
    }
    

    @objc func sortByPrice() {
        guard let viewModel = self.viewModel else {return}
        viewModel.mainArray.sort { (crypto1, crypto2) -> Bool in
            return crypto1.price! < crypto2.price!
        }
        DispatchQueue.main.async { [self] in
            self.tableView.reloadData()
            menuView.isHidden = true
        }
        self.selectedTitle = "Price"
    }
    @objc func sortByMarketCap() {
        guard let viewModel = self.viewModel else {return}
        viewModel.mainArray.sort { (crypto1, crypto2) -> Bool in
            return crypto1.marketCap! < crypto2.marketCap!
        }
        DispatchQueue.main.async { [self] in
            self.tableView.reloadData()
            menuView.isHidden = true
        }
        self.selectedTitle = "Market Cap"
    }
    @objc func sortByVolume() {
        guard let viewModel = self.viewModel else {return}
        viewModel.mainArray.sort { (crypto1, crypto2) -> Bool in
            return crypto1.the24HVolume! < crypto2.the24HVolume!
        }
        DispatchQueue.main.async { [self] in
            self.tableView.reloadData()
            menuView.isHidden = true
        }
        self.selectedTitle = "24h Volume"
    }
    @objc func sortByChange() {
        guard let viewModel = self.viewModel else {return}
        viewModel.mainArray.sort { (crypto1, crypto2) -> Bool in
            return crypto1.change! < crypto2.change!
        }
        DispatchQueue.main.async { [self] in
            self.tableView.reloadData()
            menuView.isHidden = true
        }
        self.selectedTitle = "Change"
    }
    @IBAction func sortButton(_ sender: Any) {
        
        if menuView.isHidden {
            menuView.isHidden = false
        } else {
            menuView.isHidden = true
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
       
        return (viewModel?.mainArray.count)!
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CryptoDetailCell = tableView.dequeueReusableCell(withIdentifier: "CryptoCellIdentifier", for: indexPath) as! CryptoDetailCell
        let list = viewModel?.mainArray[indexPath.section]
        cell.configCell(article: list!)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let chosenProduct = viewModel?.mainArray[indexPath.section] {
            let vc = storyboard!.instantiateViewController(withIdentifier: "CryptoDetailViewController") as! DetailViewController
            vc.article = chosenProduct
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
    }
}
extension ViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchResultArray = self.viewModel.mainArray.filter( { (coin) -> Bool in
            return coin.name!.contains(searchText)
        })
        if searchText.isEmpty == true {
            self.viewModel.coinsArray = self.viewModel.mainArray
        } else {
            self.viewModel.coinsArray = self.viewModel.searchResultArray
        }
        tableView.reloadData()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.coinsArray = viewModel.mainArray
        tableView.reloadData()
    }
    
}









