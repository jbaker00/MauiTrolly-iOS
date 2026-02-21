//
//  InterstitialAdCoordinator.swift
//  MauiTrolly
//

import GoogleMobileAds
import UIKit

class InterstitialAdCoordinator: NSObject, ObservableObject, FullScreenContentDelegate {
    private var interstitial: InterstitialAd?
    private let adUnitID = "ca-app-pub-7871017136061682/5526958414"

    override init() {
        super.init()
        loadAd()
    }

    func loadAd() {
        InterstitialAd.load(with: adUnitID, request: Request()) { [weak self] ad, _ in
            self?.interstitial = ad
            self?.interstitial?.fullScreenContentDelegate = self
        }
    }

    func showAd() {
        guard let interstitial,
              let rootVC = UIApplication.shared.connectedScenes
                .compactMap({ ($0 as? UIWindowScene)?.keyWindow })
                .first?
                .rootViewController
        else { return }
        interstitial.present(from: rootVC)
    }

    // Preload the next ad after dismissal
    func adDidDismissFullScreenContent(_ ad: FullScreenPresentingAd) {
        interstitial = nil
        loadAd()
    }
}
