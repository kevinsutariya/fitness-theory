//
//  AdColonyModel.swift
//  Fitness Theory
//
//  Created by Jay Borania on 26/07/22.
//

import Foundation
import AdColony

class AdColonyModel: NSObject, AdColonyInterstitialDelegate {
    
    static let shared = AdColonyModel()
    weak var interstitial: AdColonyInterstitial?
    
    func requestInterstitial() {
        AdColony.requestInterstitial(inZone: "vz885973a41e2c4f6187", options: nil, andDelegate: self)
    }

    // MARK:- AdColony Interstitial Delegate

    // Store a reference to the returned interstitial object
    func adColonyInterstitialDidLoad(_ interstitial: AdColonyInterstitial) {
        self.interstitial = interstitial
    }
    
    // Handle loading error
    func adColonyInterstitialDidFail(toLoad error: AdColonyAdRequestError) {
        print("Interstitial request failed with error: \(error.localizedDescription) and suggestion: \(error.localizedRecoverySuggestion ?? "")")
    }
    
    func adColonyInterstitialDidClose(_ interstitial: AdColonyInterstitial) {
        print("Interstitial did close")
        AdColonyModel.shared.requestInterstitial()
    }
    
    // Handle expiring ads (optional)
    func adColonyInterstitialExpired(_ interstitial: AdColonyInterstitial) {
        // remove reference to stored ad
        self.interstitial = nil

        // you can request new ad
        self.requestInterstitial()
    }
}
