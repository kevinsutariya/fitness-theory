//
//  AppDelegate.swift
//  Fitness Theory
//
//  Created by Jay Borania on 23/07/22.
//

import UIKit
import AdColony

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        loadStore()
        AdColony.configure(withAppID: AD_COLONY_APP_ID, options: nil) { [weak self] (zones) in
            // configured
        }
        return true
    }
}

extension AppDelegate {
    // MARK: - CHANGE ROOT VIEW CONTROLLER METHOD
    
    func setRootViewController(vc: UIViewController) {
        guard let window = UIApplication.shared.keyWindow else {
            return
        }
        
        // Set the new rootViewController of the window.
        // Calling "UIView.transition" below will animate the swap.
        window.rootViewController = vc
        
        // A mask of options indicating how you want to perform the animations.
        let options: UIView.AnimationOptions = .transitionFlipFromLeft
        
        // The duration of the transition animation, measured in seconds.
        let duration: TimeInterval = 0.3
        
        // Creates a transition animation.
        // Though `animations` is optional, the documentation tells us that it must not be nil. ¯\_(ツ)_/¯
        UIView.transition(with: window, duration: duration, options: options, animations: {}, completion:
                            { completed in
            // maybe do something on completion here
            window.makeKeyAndVisible()
        })
    }
    
    // MARK: - Methods
    private func loadStore() {
        StoreManager.shared.storeItems = [ProductType.allCases.first!]
            .map({ Product(name: "", productId: $0.rawValue, price: "Buy".localized, image: "") })
        StoreManager.shared.loadStoreProducts()
        StoreManager.shared.completeTransactionAtAppLaunch()
        
        #if canImport(CCC)
        StoreManager.shared.shouldAddStorePaymentHandling { productId in
            CCCManager.shared.appInstalledByInAppProduct(productId: productId)
            return false
        }
        #endif
    }
}

enum ProductType: String, CaseIterable {
    case disableads = "com.BetanoFit.BetanoFit.bo.noads"
    case disableadvertisement = "2"
    case bg1 = "3"
    case bg2 = "4"
    case bg3 = "5"
    case bg4 = "6"
    case bg5 = "7"
    case bg6 = "8"
    case bg7 = "9"
    
    var name: String {
        switch self {
        case .disableads: return "Disable banner"
        case .disableadvertisement: return "Disable interstitial"
        case .bg1: return "Background 1"
        case .bg2: return "Background 2"
        case .bg3: return "Background 3"
        case .bg4: return "Background 4"
        case .bg5: return "Background 5"
        case .bg6: return "Background 6"
        case .bg7: return "Background 7"
        }
    }
    
    var imageName: String {
        switch self {
        case .disableads: return "disableads"
        case .disableadvertisement:
            return "disableadvertisement"
        case .bg1:
            return "bg1"
        case .bg2:
            return "bg2"
        case .bg3:
            return "bg3"
        case .bg4:
            return "bg4"
        case .bg5:
            return "bg5"
        case .bg6:
            return "bg6"
        case .bg7:
            return "bg7"
        }
    }
    
}
