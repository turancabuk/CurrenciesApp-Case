//
//  ViewController.swift
//  CurrencyApp-Case
//
//  Created by Turan Çabuk on 26.01.2023.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    var viewModel : ViewModel?
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        viewModel = ViewModel()
        viewModel?.getCurrencies {_ in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (viewModel?.coinsList.count)!
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: CryptoDetailCell = tableView.dequeueReusableCell(withIdentifier: "CryptoCellIdentifier") as! CryptoDetailCell
        let list = viewModel?.coinsList[indexPath.row]
        cell.configCell(article: list!)
        return cell
    }
}

