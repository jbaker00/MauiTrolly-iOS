//
//  AnalyticsService.swift
//  MauiTrolly
//
//  Centralised Firebase Analytics event logging.
//

import FirebaseAnalytics

enum AnalyticsService {

    // MARK: - Event names
    private enum Event {
        static let searchTrolley    = "search_trolley"
        static let selectTrip       = "select_trip"
        static let viewRideDetails  = "view_ride_details"
        static let searchNoResults  = "search_no_results"
        static let swapStops        = "swap_stops"
        static let changeStop       = "change_stop"
        static let changeSearchType = "change_search_type"
        static let searchAgain      = "search_again"
        static let reviewPrompt     = "review_prompt_requested"
    }

    // MARK: - Public API

    /// Logged when the user taps "Find Trolleys"
    static func logSearch(from fromStop: String, to toStop: String, searchType: String, resultCount: Int) {
        Analytics.logEvent(Event.searchTrolley, parameters: [
            "from_stop": fromStop,
            "to_stop": toStop,
            "search_type": searchType,
            "result_count": resultCount,
        ])
    }

    /// Logged when the user taps "View Ride Details" on a trip card
    static func logSelectTrip(departureTime: String, isBestMatch: Bool) {
        Analytics.logEvent(Event.selectTrip, parameters: [
            "departure_time": departureTime,
            "is_best_match": isBestMatch ? "true" : "false",
        ])
    }

    /// Logged when the confirmation / ride summary screen appears
    static func logViewRideDetails(from fromStop: String, to toStop: String) {
        Analytics.logEvent(Event.viewRideDetails, parameters: [
            "from_stop": fromStop,
            "to_stop": toStop,
        ])
    }

    /// Logged when the app asks StoreKit for a rating prompt
    static func logReviewPromptRequested(rideViews: Int) {
        Analytics.logEvent(Event.reviewPrompt, parameters: [
            "ride_views": rideViews,
        ])
    }

    /// Logged when a search returns zero results
    static func logSearchNoResults(from fromStop: String, to toStop: String, searchType: String) {
        Analytics.logEvent(Event.searchNoResults, parameters: [
            "from_stop": fromStop,
            "to_stop": toStop,
            "search_type": searchType,
        ])
    }

    /// Logged when the user taps the swap (from ⇄ to) button
    static func logSwapStops(from fromStop: String, to toStop: String) {
        Analytics.logEvent(Event.swapStops, parameters: [
            "from_stop": fromStop,
            "to_stop": toStop,
        ])
    }

    /// Logged when the user picks a different stop in the FROM/TO menu
    static func logChangeStop(field: String, stop: String) {
        Analytics.logEvent(Event.changeStop, parameters: [
            "field": field,     // "from" | "to"
            "stop": stop,
        ])
    }

    /// Logged when the user flips the Depart/Arrive segmented control
    static func logChangeSearchType(_ searchType: String) {
        Analytics.logEvent(Event.changeSearchType, parameters: [
            "search_type": searchType,
        ])
    }

    /// Logged when the user taps "Search Again" on the ride summary screen
    static func logSearchAgain(from fromStop: String, to toStop: String) {
        Analytics.logEvent(Event.searchAgain, parameters: [
            "from_stop": fromStop,
            "to_stop": toStop,
        ])
    }
}
