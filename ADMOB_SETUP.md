# Google AdMob Integration - MauiTrolly iOS

## Overview
This app now includes Google AdMob banner ads using **TEST AD UNITS**. The integration follows the same pattern used in CreoleTranslator-ios.

## Production Ad Units
- **App ID**: `ca-app-pub-7871017136061682~1113336611`
- **Banner Ad Unit**: `ca-app-pub-7871017136061682/6804526856`

## Files Added
1. **BannerAdView.swift** - UIViewRepresentable wrapper for GADBannerView
2. **ATTAuthorization.swift** - App Tracking Transparency permission handler

## Files Modified
1. **Info.plist** - Added GADApplicationIdentifier and NSUserTrackingUsageDescription
2. **MauiTrollyApp.swift** - Initialize AdMob SDK and request ATT permission
3. **SearchView.swift** - Added banner ad at bottom of screen
4. **MauiTrolly.xcodeproj/project.pbxproj** - Added GoogleMobileAds Swift Package

## How Ads Work
- Banner appears at bottom of SearchView (50pt height)
- ATT permission requested when app becomes active
- Ads load automatically using test units
- GeometryReader ensures adaptive sizing for rotation

## Switching to Production
To use your real ad units (when ready for production):

### 1. Update BannerAdView.swift
Replace line 14:
```swift
let adUnitID: String = "ca-app-pub-7871017136061682/YOUR_BANNER_UNIT_ID"
```

### 2. Update Info.plist
Replace the GADApplicationIdentifier value:
```xml
<key>GADApplicationIdentifier</key>
<string>ca-app-pub-7871017136061682~YOUR_APP_ID</string>
```

## Testing
- Test ads will show with "Test Ad" label
- No real impressions or revenue
- Safe for development and App Store review

## Dependencies
- GoogleMobileAds (v12.14.0+) via Swift Package Manager
- Requires iOS 16.0+
- App Tracking Transparency framework

