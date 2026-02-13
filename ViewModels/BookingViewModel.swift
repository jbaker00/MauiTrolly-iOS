//
//  BookingViewModel.swift
//  MauiTrolly
//
//  Created by GitHub Copilot on 2/12/26.
//

import SwiftUI

class BookingViewModel: ObservableObject {
    @Published var fromStopId: Int = 1
    @Published var toStopId: Int = 6
    @Published var desiredTime: Date = Date()
    @Published var searchType: TrolleyScheduleService.SearchType = .departure
    @Published var searchResults: [TrolleyTrip] = []
    @Published var selectedTrip: TrolleyTrip?
    @Published var hasSearched: Bool = false
    
    var fromStop: TrolleyStop {
        TrolleyStop.allStops.first { $0.id == fromStopId } ?? TrolleyStop.allStops[0]
    }
    
    var toStop: TrolleyStop {
        TrolleyStop.allStops.first { $0.id == toStopId } ?? TrolleyStop.allStops[5]
    }
    
    func swapLocations() {
        let temp = fromStopId
        fromStopId = toStopId
        toStopId = temp
    }
    
    func searchTrolleys() {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        let timeString = formatter.string(from: desiredTime)
        
        searchResults = TrolleyScheduleService.findTrolleys(
            from: fromStopId,
            to: toStopId,
            desiredTime: timeString,
            searchType: searchType
        )
        hasSearched = true
        selectedTrip = nil
    }
}
