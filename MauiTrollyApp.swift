//
//  MauiTrollyApp.swift
//  MauiTrolly
//
//  Created by GitHub Copilot on 2/12/26.
//

import SwiftUI
import GoogleMobileAds

@main
struct MauiTrollyApp: App {
    @Environment(\.scenePhase) private var scenePhase
    
    init() {
        // Initialize the Google Mobile Ads SDK early so ad requests can proceed.
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
