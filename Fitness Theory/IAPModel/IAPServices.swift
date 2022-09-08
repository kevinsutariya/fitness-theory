import UIKit
import StoreKit

class IAPServices: NSObject {
    
    private override init() {}
    static let shared = IAPServices()
    
    var products = [SKProduct]()
    let paymentQueue = SKPaymentQueue.default()
    var productPrice = ""
    
    func getProducts() {
        let products: Set = [IAPProduct.autoRenew.rawValue]
        let request = SKProductsRequest(productIdentifiers: products)
        request.delegate = self
        request.start()
        paymentQueue.add(self)
    }
    
    func purchase(product: IAPProduct) {
        guard let productToPurchase = products.filter({ $0.productIdentifier == product.rawValue }).first else { return }
        let payment = SKPayment(product: productToPurchase)
        paymentQueue.add(payment)
    }
    
    func restorePurchase() {
        print("RESTORING PURCHASE")
        paymentQueue.restoreCompletedTransactions()
    }
    
    func validateReceipt() {
#if DEBUG
        let urlString = "https://sandbox.itunes.apple.com/verifyReceipt"
#else
        let urlString = "https://buy.itunes.apple.com/verifyReceipt"
#endif
        
        
        guard let receiptURL = Bundle.main.appStoreReceiptURL, let receiptString = try? Data(contentsOf: receiptURL).base64EncodedString() , let url = URL(string: urlString) else {
            // SUBSCRIPTION EXPIRED
            //            NotificationCenter.default.post(name: .subscriptionExpired, object: nil)
            //            restorePurchase()
            return
        }
        
        let requestData : [String : Any] = ["receipt-data" : receiptString,
                                            "password" : "8cdd5ae5090e4c30bdbcbd32f8bfa6da",
                                            "exclude-old-transactions" : false]
        let httpBody = try? JSONSerialization.data(withJSONObject: requestData, options: [])
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = httpBody
        URLSession.shared.dataTask(with: request)  { (data, response, error) in
            // convert data to Dictionary and view purchases
            self.performSelector(onMainThread: #selector(self.readReceiptData(data:)), with: data, waitUntilDone: false)
        }.resume()
    }
    
    @objc func readReceiptData(data: Data) {
        if let jsonData = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] {
            print("APPSTORE RECEIPT JSON: \(jsonData)")
            
            if let lastreceipts = jsonData["latest_receipt_info"] as? [[String: Any]] {
                if let firstreceipt = lastreceipts.first {
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss VV"
                    if let expiresDate = firstreceipt["expires_date"] as? String {
                        
                        if let expdategmt = formatter.date(from: expiresDate) {
                            if Date().compare(expdategmt) == .orderedAscending {
                                // NOT EXPIRED
                                //                                    UserDefaults.standard.set(firstreceipt["transaction_id"] as? String, forKey: "transaction_id")
                                //                                    UserDefaults.standard.set(firstreceipt["expires_date"] as? String, forKey: "expires_date")
                                //                                    NotificationCenter.default.post(name: .receiptUpdated, object: nil)
                                return
                            } else {
                                // EXPIRED
                                //                                    NotificationCenter.default.post(name: .subscriptionExpired, object: nil)
                            }
                        }
                    }
                }
            }
            
            if let decodedData = Data(base64Encoded: jsonData["latest_receipt_info"] as? String ?? "") {
                if let decodedString = String(data: decodedData, encoding: .utf8) {
                    print("LAST DECODED RECEIPT: \(decodedString)")
                }
            }
        }
        // EXPIRED
        //        NotificationCenter.default.post(name: .subscriptionExpired, object: nil)
    }
}
 
extension IAPServices: SKProductsRequestDelegate {
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
//        stopIndicator()
        print("\(response.products.count) products found")
        self.products = response.products
        for product in response.products {
            let numberFormatter = NumberFormatter()
            numberFormatter.formatterBehavior = .behavior10_4
            numberFormatter.numberStyle = .currency
            numberFormatter.locale = product.priceLocale
//            numberFormatter.currencyCode = "INR"
            if let formattedPrice = numberFormatter.string(from: product.price) {
                print("PRODUCTS: \(product.localizedTitle) -- PRICE: \(formattedPrice)")
                self.productPrice = formattedPrice
                DispatchQueue.main.async {
//                    NotificationCenter.default.post(name: .setPurchasePrice, object: nil)
                }
            }
        }
    }
    
    func request(_ request: SKRequest, didFailWithError error: Error) {
//        stopIndicator()
        print("IAP didFailWithError: \(error.localizedDescription)")
        DispatchQueue.main.async {
//            NotificationCenter.default.post(name: .failedPurchaseProduct, object: nil)
        }
    }
}

extension IAPServices: SKPaymentTransactionObserver {
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transcation in transactions {
            print("TRANSACTION STATE: \(transcation.transactionState.status())")
            switch transcation.transactionState {
            case .purchasing: break
            default:
//                stopIndicator()
                paymentQueue.finishTransaction(transcation)
                if transcation.transactionState == .purchased {
//                    NotificationCenter.default.post(name: NSNotification.Name.init("userPurchaseComplete"), object: nil) 
                } else if transcation.transactionState == .failed {
//                    NotificationCenter.default.post(name: NSNotification.Name.init("userPurchaseComplete"), object: nil)
                }
            }
        }
    }
}

extension SKPaymentTransactionState {
    func status() -> String {
        switch self {
        case .deferred: return "deferred"
        case .failed: return "failed"
        case .purchased: return "purchased"
        case .purchasing: return "purchasing"
        case .restored: return "restored"
        default: return ""
        }
    }
}
