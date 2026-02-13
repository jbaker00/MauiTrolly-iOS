//
//  TrolleyScheduleService.swift
//  MauiTrolly
//
//  Created by GitHub Copilot on 2/12/26.
//

import Foundation

class TrolleyScheduleService {
    
    // Travel times between stops in minutes
    private static let travelTimes: [String: Int] = [
        "1-2": 2,   // Whalers to Marriott
        "2-3": 5,   // Marriott to Golf Course
        "3-4": 3,   // Golf Course to Villas
        "4-5": 5,   // Villas to Royal Lahaina
        "5-6": 10,  // Royal Lahaina to Sheraton
        "6-1": 25   // Sheraton back to Whalers (loop)
    ]
    
    // Convert time string to minutes since midnight
    static func timeToMinutes(_ timeStr: String) -> Int? {
        let pattern = #"(\d+):(\d+)\s*(am|pm)"#
        guard let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive),
              let match = regex.firstMatch(in: timeStr, range: NSRange(timeStr.startIndex..., in: timeStr)) else {
            return nil
        }
        
        guard let hoursRange = Range(match.range(at: 1), in: timeStr),
              let minutesRange = Range(match.range(at: 2), in: timeStr),
              let periodRange = Range(match.range(at: 3), in: timeStr) else {
            return nil
        }
        
        var hours = Int(timeStr[hoursRange]) ?? 0
        let minutes = Int(timeStr[minutesRange]) ?? 0
        let period = String(timeStr[periodRange]).lowercased()
        
        if period == "pm" && hours != 12 {
            hours += 12
        }
        if period == "am" && hours == 12 {
            hours = 0
        }
        
        return hours * 60 + minutes
    }
    
    // Convert minutes to time string
    static func minutesToTime(_ minutes: Int) -> String {
        let hours = minutes / 60
        let mins = minutes % 60
        let period = hours >= 12 ? "pm" : "am"
        let displayHours = hours > 12 ? hours - 12 : (hours == 0 ? 12 : hours)
        
        return String(format: "%d:%02d %@", displayHours, mins, period)
    }
    
    // Get travel time between two stops
    static func getTravelTime(from fromId: Int, to toId: Int) -> Int {
        if fromId == toId { return 0 }
        
        guard let fromStop = TrolleyStop.allStops.first(where: { $0.id == fromId }),
              let toStop = TrolleyStop.allStops.first(where: { $0.id == toId }) else {
            return 0
        }
        
        let fromPos = fromStop.routePosition
        let toPos = toStop.routePosition
        
        var totalTime = 0
        
        if fromPos < toPos {
            // Going forward in route
            for i in fromPos..<toPos {
                let key = "\(i)-\(i + 1)"
                totalTime += travelTimes[key] ?? 0
            }
        } else {
            // Going around the loop
            for i in fromPos...6 where i < 6 {
                let key = "\(i)-\(i + 1)"
                totalTime += travelTimes[key] ?? 0
            }
            totalTime += travelTimes["6-1"] ?? 0
            for i in 1..<toPos {
                let key = "\(i)-\(i + 1)"
                totalTime += travelTimes[key] ?? 0
            }
        }
        
        return totalTime
    }
    
    // Find matching trolleys for a search
    static func findTrolleys(from fromId: Int, to toId: Int, desiredTime: Date, searchType: SearchType) -> [TrolleyTrip] {
        guard let fromStop = TrolleyStop.allStops.first(where: { $0.id == fromId }) else {
            return []
        }
        
        let travelTime = getTravelTime(from: fromId, to: toId)
        let calendar = Calendar.current
        let timeComponents = calendar.dateComponents([.hour, .minute], from: desiredTime)
        let desiredMinutes = (timeComponents.hour ?? 0) * 60 + (timeComponents.minute ?? 0)
        
        // Parse all departure times
        let cleanTimes = fromStop.times.compactMap { time -> (original: String, clean: String, minutes: Int)? in
            let cleanTime = time.split(separator: "(").first?.trimmingCharacters(in: .whitespaces) ?? time
            guard let minutes = timeToMinutes(cleanTime) else { return nil }
            return (time, cleanTime, minutes)
        }
        
        // Calculate arrival time for each departure
        let trolleys = cleanTimes.map { departure -> (TrolleyTrip, departureMinutes: Int, arrivalMinutes: Int) in
            let arrivalMinutes = (departure.minutes + travelTime) % (24 * 60)
            let arrivalTime = minutesToTime(arrivalMinutes)
            
            let trip = TrolleyTrip(
                departureTime: departure.clean,
                arrivalTime: arrivalTime,
                travelTime: travelTime,
                isBest: false
            )
            
            return (trip, departure.minutes, arrivalMinutes)
        }
        
        // Find the best matching trolley
        var bestIndex = 0
        if searchType == .departure {
            bestIndex = trolleys.enumerated().reduce(0) { best, current in
                let bestDiff = abs(trolleys[best].departureMinutes - desiredMinutes)
                let currentDiff = abs(current.element.departureMinutes - desiredMinutes)
                return currentDiff < bestDiff ? current.offset : best
            }
        } else {
            bestIndex = trolleys.enumerated().reduce(0) { best, current in
                let bestDiff = abs(trolleys[best].arrivalMinutes - desiredMinutes)
                let currentDiff = abs(current.element.arrivalMinutes - desiredMinutes)
                return currentDiff < bestDiff ? current.offset : best
            }
        }
        
        // Return best + one before and one after
        let indices = [bestIndex - 1, bestIndex, bestIndex + 1].filter { $0 >= 0 && $0 < trolleys.count }
        
        return indices.map { idx in
            TrolleyTrip(
                departureTime: trolleys[idx].0.departureTime,
                arrivalTime: trolleys[idx].0.arrivalTime,
                travelTime: trolleys[idx].0.travelTime,
                isBest: idx == bestIndex
            )
        }
    }
    
    enum SearchType {
        case departure
        case arrival
    }
}
