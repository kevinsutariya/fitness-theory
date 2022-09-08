//
//  SplashVC.swift
//  Fitness Theory
//
//  Created by Jay Borania on 23/07/22.
//

import UIKit

class SplashVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainMenuVC") as? MainMenuVC {
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}
