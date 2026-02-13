# MauiTrolly iOS

A native iOS app for finding and booking rides on the free Kaanapali Trolley shuttle service in Maui, Hawaii.

## Features

- 🚃 **Real-time Schedule Search**: Find trolley times based on your departure or arrival preferences
- 📍 **6 Resort Locations**: Coverage across all major Kaanapali resort stops
- ⏰ **Smart Suggestions**: Get 3 trolley options with the best match highlighted
- 🎯 **Trip Confirmation**: Visual timeline showing your complete journey
- 🆓 **Free Service**: Complimentary shuttle for Kaanapali resort guests

## Trolley Stops

1. Whalers Village & Westin Hotel
2. Maui Marriott & Hyatt
3. Kaanapali Golf Course
4. Maui Kaanapali Villas
5. Royal Lahaina & El Dorado
6. Sheraton & Kaanapali Beach Hotel

## Requirements

- iOS 16.0+
- Xcode 14.0+
- Swift 5.7+

## Installation

### Option 1: Xcode

1. Open `MauiTrolly.xcodeproj` in Xcode
2. Select your target device or simulator
3. Press ⌘R to build and run

### Option 2: Command Line

```bash
xcodebuild -project MauiTrolly.xcodeproj -scheme MauiTrolly -destination 'platform=iOS Simulator,name=iPhone 15' build
```

## Project Structure

```
MauiTrolly-iOS/
├── MauiTrollyApp.swift        # App entry point
├── Models/
│   ├── TrolleyStop.swift      # Stop data model
│   └── TrolleyTrip.swift      # Trip result model
├── Views/
│   ├── ContentView.swift      # Main container view
│   ├── SearchView.swift       # Search interface
│   ├── TrolleyTripCard.swift  # Trip result card
│   └── BookingConfirmationView.swift  # Confirmation screen
├── ViewModels/
│   └── BookingViewModel.swift # Business logic
├── Services/
│   └── TrolleyScheduleService.swift  # Schedule algorithms
└── Info.plist                 # App configuration
```

## Usage

1. **Select Locations**: Choose your starting point (FROM) and destination (TO)
2. **Set Time**: Pick your desired time using the time picker
3. **Search Type**: Select "Depart" or "Arrive" based on your preference
4. **Search**: Tap "Search Times" to find available trolleys
5. **Select Trolley**: Choose from up to 3 options (best match is highlighted)
6. **Confirm**: Review your trip details and travel timeline

## Operating Hours

- **Daily**: 10:00 AM - 9:30 PM
- **Frequency**: Approximately every 30 minutes
- **Cost**: FREE for Kaanapali resort guests
- **Phone**: 1-808-667-0648

## Architecture

- **Pattern**: MVVM (Model-View-ViewModel)
- **UI Framework**: SwiftUI
- **State Management**: ObservableObject with @Published properties
- **Service Layer**: TrolleyScheduleService for business logic
- **Navigation**: NavigationStack for screen transitions

## Key Features

### Smart Search Algorithm
- Finds 3 trolley options based on desired time
- Highlights best match with visual badge
- Supports both departure and arrival time searches
- Calculates travel times based on route positions

### Visual Timeline
- Animated route visualization on confirmation screen
- Stop images for visual reference
- Clear departure and arrival indicators
- Travel time and cost display

### Mobile-First Design
- Optimized for iPhone and iPad
- Portrait and landscape support
- Touch-friendly buttons and controls
- Smooth scrolling and animations

## Related Projects

- **Web App**: [MauiTrolly](https://github.com/jbaker00/MauiTrolly) - React-based web version

## License

MIT License - Feel free to use this code for your own projects!

## Contact

For questions or issues, please contact the Kaanapali Trolley at 1-808-667-0648.

---

Built with ❤️ in Swift and SwiftUI
