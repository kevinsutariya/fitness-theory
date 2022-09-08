//
//  ShopVC.swift
//  Fitness Theory
//
//  Created by Jay Borania on 24/07/22.
//

import UIKit
import MBProgressHUD

class ShopVC: UIViewController {
    
    @IBOutlet weak var lblHeaderTitle: UILabel!
    @IBOutlet weak var lblNoAdsTitle: UILabel!
    @IBOutlet weak var buyButton: UIButton!
    @IBOutlet weak var btnRestore: UIButton!
    
    private lazy var products = StoreManager.shared.storeItems.compactMap { ProductType(rawValue: $0.productId) }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        StoreManager.shared.storeManagerDelegate = self
        
        if let product = products.first?.rawValue {
            let isPurchased = StoreManager.shared.isProductPurchased(product)
            let title: String = isPurchased ?
            "Bought".localized :
            StoreManager.shared.storeItems.first(where: { $0.productId == product })?.price ?? "Buy".localized
            buyButton.setTitle(title, for: .normal)
            buyButton.isEnabled = !isPurchased
        }
        else {
            buyButton.setTitle("Buy".localized, for: .normal)
        }
        
        lblHeaderTitle.text = "Shop".localized
        lblNoAdsTitle.text = "No ADS".localized
        btnRestore.setTitle("Restore".localized, for: .normal)
    }
    
    // MARK: - UIBUTTON CLICK METHODS
    @IBAction func onClickBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onClickRestore(_ sender: UIButton) {
        AppSounds.shared.playClickSound()
        StoreManager.shared.restoreProducts()
    }
    
    @IBAction func buyButtonPressed(_ sender: Any) {
        guard let product = products.first?.rawValue else {
            return
        }
        if StoreManager.shared.isProductPurchased(product) {
            showAlert()
        } else {
            StoreManager.shared.purchaseProduct(productId: product)
        }
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: "Purchased", message: "You already purchased this item",
                                      preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { (_: UIAlertAction!)in
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

extension ShopVC: StoreManagerDelegate {
    
    // MARK: - HudDelegate
    public func showHud() {
        MBProgressHUD.showAdded(to: view, animated: true)
    }
    
    public func hideHud() {
        MBProgressHUD.hide(for: view, animated: true)
    }
    
    public func purchaseSuccess(productId: String) {
        buyButton.isEnabled = false
        buyButton.setTitle("Bought".localized, for: .normal)
    }
    
}
