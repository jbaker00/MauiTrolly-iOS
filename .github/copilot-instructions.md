# MauiTrolly iOS - Copilot Instructions

## Build and Run

**Open in Xcode:**
```bash
open MauiTrolly.xcodeproj
```

**Build and run:**
- Open `MauiTrolly.xcodeproj` in Xcode
- Select your target device or simulator (iPhone or iPad)
- Press ⌘R to build and run
- Or use ⌘B to build without running

**Command line build:**
```bash
xcodebuild -project MauiTrolly.xcodeproj -scheme MauiTrolly -destination 'platform=iOS Simulator,name=iPhone 15 Pro' build
```

**Note:** No automated tests, linting, or package managers are currently configured.

## Architecture Overview

### MVVM Pattern with SwiftUI

This is a SwiftUI app following the MVVM (Model-View-ViewModel) pattern:

- **Models** (`Models/`): Data structures with no business logic
  - `TrolleyStop`: Contains stop metadata AND schedule data via static extension
  - `TrolleyTrip`: Search result model

- **Services** (`Services/`): Pure business logic with no UI dependencies
  - `TrolleyScheduleService`: Static methods for schedule calculations and trip finding
  
- **ViewModels** (`ViewModels/`): Bridge between Views and Services
  - `BookingViewModel`: Single source of truth for app state using `@Published` properties
  
- **Views** (`Views/`): Pure presentation layer
  - All Views receive dependencies via parameters or `@ObservedObject`
  - No direct service calls from Views - always through ViewModel

### Data Flow

1. User interacts with `SearchView`
2. Action updates `BookingViewModel` `@Published` properties
3. ViewModel calls `TrolleyScheduleService` static methods
4. Service returns computed results
5. ViewModel publishes updated state
6. SwiftUI automatically re-renders affected Views

### Navigation

- Uses `NavigationStack` (iOS 16+) in `ContentView`
- Navigation is state-driven: when `viewModel.selectedTrip` is set, shows `BookingConfirmationView`
- No traditional push/pop - Views conditionally render based on ViewModel state

## Key Conventions

### Schedule Data Location

**All trolley schedule times are hardcoded in `TrolleyStop.swift` static extension.** When operating hours or stop times change:
- Update the `times` array for the affected stop in `TrolleyStop.allStops`
- Format: `"HH:MM am/pm"` or `"HH:MM am/pm (Drop Off Only)"`

### Time Parsing & Calculation

**The app uses a minutes-since-midnight system:**
- `TrolleyScheduleService.timeToMinutes()`: Converts "3:30 pm" → 930 minutes
- `TrolleyScheduleService.minutesToTime()`: Converts 930 minutes → "3:30 pm"
- Travel times between stops are defined in `travelTimes` dictionary with format `"fromPosition-toPosition": minutes`

**Important:** Time calculations handle wraparound (after midnight) with modulo 24*60.

### Search Algorithm ("Best Match")

The `findTrolleys()` method returns exactly 3 results when available:
1. The "best" match (closest to desired time)
2. One trolley before best
3. One trolley after best

The best match is determined by:
- **Departure search**: Closest departure time to desired time
- **Arrival search**: Closest arrival time to desired time

Mark the best result with `isBest: true` so the UI can highlight it.

### Color Scheme

The app uses a consistent blue color scheme:
- Primary blue: `Color(red: 0, green: 0.4, blue: 0.8)`
- Darker blue: `Color(red: 0, green: 0.32, blue: 0.64)`
- Background: `Color(red: 0.96, green: 0.97, blue: 0.98)`

Use these exact values for consistency. Apply gradients for buttons and headers.

### Model Extensions

Models use static extensions for data:
```swift
extension TrolleyStop {
    static let allStops = [...]
}
```
This pattern keeps data separate from the struct definition. Access via `TrolleyStop.allStops`.

### State Management

- Use `@StateObject` for ViewModel creation (root view only)
- Use `@ObservedObject` for ViewModel passing (child views)
- Use `@Published` for all properties that trigger UI updates
- Computed properties (like `fromStop`, `toStop`) should NOT be `@Published`

### Service Layer Pattern

Services are stateless classes with static methods only:
- No stored properties
- No initializers needed
- All logic is pure functions
- Example: `TrolleyScheduleService.findTrolleys(...)`

This ensures services can be called from anywhere without instantiation or dependency injection.
