//
//  SplashController.swift
//  CurrencyApp-Case
//
//  Created by Turan Çabuk on 30.01.2023.
//

import UIKit

class SplashController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            self.performSegue(withIdentifier: "SplashScreenIdentifier", sender: nil)
        }
    }

}
