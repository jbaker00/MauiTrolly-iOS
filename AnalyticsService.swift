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
    }

    // MARK: - Public API

    /// Logged when the user taps "Find Trolleys"
    static func logSearch(from fromStop: String, to toStop: String, searchType: String) {
        Analytics.logEvent(Event.searchTrolley, parameters: [
            "from_stop": fromStop,
            "to_stop": toStop,
            "search_type": searchType,
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

    /// Logged when a search returns zero results
    static func logSearchNoResults(from fromStop: String, to toStop: String, searchType: String) {
        Analytics.logEvent(Event.searchNoResults, parameters: [
            "from_stop": fromStop,
            "to_stop": toStop,
            "search_type": searchType,
        ])
    }
}
