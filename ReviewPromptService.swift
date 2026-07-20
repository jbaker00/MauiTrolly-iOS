//
//  ReviewPromptService.swift
//  MauiTrolly
//
//  Asks for an App Store rating at a positive moment: after the user has
//  viewed their 2nd ride summary, at most once per app version.
//

import StoreKit
import UIKit

enum ReviewPromptService {
    private static let rideViewsKey = "reviewPrompt.rideDetailViews"
    private static let promptedVersionKey = "reviewPrompt.lastPromptedVersion"

    static func recordRideViewedAndMaybePrompt() {
        let defaults = UserDefaults.standard
        let count = defaults.integer(forKey: rideViewsKey) + 1
        defaults.set(count, forKey: rideViewsKey)

        let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "unknown"
        guard count >= 2, defaults.string(forKey: promptedVersionKey) != version else { return }

        guard let scene = UIApplication.shared.connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .first(where: { $0.activationState == .foregroundActive }) else { return }

        defaults.set(version, forKey: promptedVersionKey)
        AnalyticsService.logReviewPromptRequested(rideViews: count)
        // Let the ride summary settle on screen before the system sheet appears
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            SKStoreReviewController.requestReview(in: scene)
        }
    }
}
