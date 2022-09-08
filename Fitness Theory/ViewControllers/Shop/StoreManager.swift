#if canImport(SwiftyStoreKit) && canImport(StoreKit)
import Foundation
import SwiftyStoreKit

struct Product {
    let name: String
    let productId: String
    let consumable: Bool
    let image: String
    var price: String
    var purchased: Bool

    init(
        name: String,
        productId: String,
        price: String,
        image: String,
        consumable: Bool = false
    ) {
        self.name = name
        self.productId = productId
        self.price = price
        self.purchased = StoreManager.shared.isProductPurchased(productId, consumable: consumable)
        self.image = image
        self.consumable = consumable
    }
}

protocol StoreManagerDelegate: AnyObject {
    func showHud()
    func hideHud()
    func purchaseSuccess(productId: String)
}

final class StoreManager {
    // MARK: - Properties
    static var shared = StoreManager()
    private let userDefaults: UserDefaults = UserDefaults()
    
    weak var storeManagerDelegate: StoreManagerDelegate?
    var storeItems  = [Product]()
    
    // MARK: - Lifecycle
    private init() {}
    
    // MARK: - Methods
    func loadStoreProducts() {
        let productIds = Set<String>(storeItems.map(\.productId))
        retrieveProductInfo(productIds: productIds)
    }
    
    func completeTransactionAtAppLaunch() {
        SwiftyStoreKit.completeTransactions(atomically: true) { purchases in
            for purchase in purchases {
                guard
                    purchase.transaction.transactionState == .purchased ||
                        purchase.transaction.transactionState == .restored
                else { continue }
                if purchase.needsFinishTransaction {
                    SwiftyStoreKit.finishTransaction(purchase.transaction)
                }
                print("purchased: \(purchase)")
            }
        }
    }

    func purchaseProduct(productId: String) {
        storeManagerDelegate?.showHud()
        SwiftyStoreKit.purchaseProduct(productId, quantity: 1, atomically: true) { result in
            self.storeManagerDelegate?.hideHud()
            switch result {
            case .success(let purchase):
                print("Purchase Success: \(purchase.productId)")
                self.postProductPurchase(purchase.productId)
            case .error(let error):
                switch error.code {
                case .unknown: print("Unknown error. Please contact support")
                case .clientInvalid: print("Not allowed to make the payment")
                case .paymentCancelled: break
                case .paymentInvalid: print("The purchase identifier was invalid")
                case .paymentNotAllowed: print("The device is not allowed to make the payment")
                case .storeProductNotAvailable: print("The product is not available in the current storefront")
                case .cloudServicePermissionDenied: print("Access to cloud service information is not allowed")
                case .cloudServiceNetworkConnectionFailed: print("Could not connect to the network")
                case .cloudServiceRevoked: print("User has revoked permission to use this cloud service")
                case .privacyAcknowledgementRequired:
                    print("Unknown error. Please contact support")
                case .unauthorizedRequestData:
                    print("Unknown error. Please contact support")
                case .invalidOfferIdentifier:
                    print("Unknown error. Please contact support")
                case .invalidSignature:
                    print("Unknown error. Please contact support")
                case .missingOfferParams:
                    print("Unknown error. Please contact support")
                case .invalidOfferPrice:
                    print("Unknown error. Please contact support")
                default:
                    print("Unknown error. Please contact support")
                }
            }
        }
    }

    func restoreProducts() {
        storeManagerDelegate?.showHud()
        SwiftyStoreKit.restorePurchases(atomically: true) { results in
            self.storeManagerDelegate?.hideHud()
            if results.restoreFailedPurchases.count > 0 {
                print("Restore Failed: \(results.restoreFailedPurchases)")
            }
            else if results.restoredPurchases.count > 0 {
                print("Restore Success: \(results.restoredPurchases)")
                for purchase in results.restoredPurchases {
                    self.postProductPurchase(purchase.productId)
                }
            }
            else {
                print("Nothing to Restore")
            }
        }
    }

    func shouldAddStorePaymentHandling(_ handler: @escaping (String) -> (Bool)) {
        SwiftyStoreKit.shouldAddStorePaymentHandler = { payment, product in
            return handler(product.productIdentifier)
        }
    }

    func isProductPurchased(_ productId: String, consumable: Bool = false) -> Bool {
        consumable ? false : userDefaults.bool(forKey: productId)
    }

    private func retrieveProductInfo(productIds: Set<String>) {
        SwiftyStoreKit.retrieveProductsInfo(productIds) { result in
            for product in result.retrievedProducts {
                let priceString = product.localizedPrice!
                print("Product: \(product.localizedDescription), price: \(priceString)")
                self.updateProductPrice(productId: product.productIdentifier, price: priceString)
            }
            for invalidProductId in result.invalidProductIDs {
                print("Invalid Product Identifier: \(invalidProductId)")
            }
            if let error = result.error {
                print("Error: \(String(describing: error))")
            }
        }
    }

    private func updateProductPrice(productId: String, price: String) {
        for (index, item) in storeItems.enumerated() where item.productId == productId {
            var copyItem = item
            copyItem.price = price
            storeItems.remove(at: index)
            storeItems.insert(copyItem, at: index)
        }
    }

    private func makeProductPurchased(productId: String) {
        for (index, item) in storeItems.enumerated() where item.productId == productId {
            if item.consumable {
                userDefaults.set(userDefaults.integer(forKey: productId) + 1, forKey: productId)
            }
            else {
                var copyItem = item
                copyItem.purchased = true
                storeItems.remove(at: index)
                storeItems.insert(copyItem, at: index)
                userDefaults.setValue(true, forKey: productId)
            }
        }
    }

    private func postProductPurchase(_ productId: String) {
        makeProductPurchased(productId: productId)
        storeManagerDelegate?.purchaseSuccess(productId: productId)
        NotificationCenter.default.post(name: .userBoughtProduct, object: productId)
    }
}

extension Notification.Name {
    static let userDownloadedAppByInAppPurchase = Notification.Name("userDownloadedAppByInAppPurchase")
    static let userBoughtProduct = Notification.Name("userBoughtProduct")
    
}
#endif
