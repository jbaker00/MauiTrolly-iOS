//
//  MauiTrollyApp.swift
//  MauiTrolly
//

import SwiftUI 
import GoogleMobileAds
import FirebaseCore

@main
struct MauiTrollyApp: App {
    @Environment(\.scenePhase) private var scenePhase

    init() {
        // Firebase must be configured before any other Firebase service
        FirebaseApp.configure()
        // Initialize Google Mobile Ads SDK
        MobileAds.shared.start { status in }
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .active {
                ATTAuthorization.requestIfNeeded()
            }
        }
    }
}
