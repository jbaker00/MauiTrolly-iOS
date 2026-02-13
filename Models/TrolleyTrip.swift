//
//  TrolleyTrip.swift
//  MauiTrolly
//
//  Created by GitHub Copilot on 2/12/26.
//

import Foundation

struct TrolleyTrip: Identifiable {
    let id = UUID()
    let departureTime: String
    let arrivalTime: String
    let travelTime: Int
    let isBest: Bool
}
