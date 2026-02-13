//
//  TrolleyTripCard.swift
//  MauiTrolly
//
//  Created by GitHub Copilot on 2/12/26.
//

import SwiftUI

struct TrolleyTripCard: View {
    let trip: TrolleyTrip
    let fromStop: TrolleyStop
    let toStop: TrolleyStop
    let onSelect: () -> Void
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack(spacing: 16) {
                HStack(alignment: .center, spacing: 12) {
                    // Departure
                    VStack(spacing: 8) {
                        AsyncImage(url: URL(string: fromStop.imageURL)) { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fill)
                        } placeholder: {
                            Color.gray.opacity(0.2)
                        }
                        .frame(width: 60, height: 60)
                        .cornerRadius(8)
                        
                        Text("DEPART")
                            .font(.caption2.bold())
                            .foregroundColor(.secondary)
                        
                        Text(trip.departureTime)
                            .font(.subheadline.bold())
                            .foregroundColor(.primary)
                    }
                    
                    // Duration
                    VStack {
                        Text("\(trip.travelTime) min")
                            .font(.caption.bold())
                            .foregroundColor(.secondary)
                    }
                    .padding(.horizontal, 8)
                    
                    // Arrival
                    VStack(spacing: 8) {
                        Text("ARRIVE")
                            .font(.caption2.bold())
                            .foregroundColor(.secondary)
                        
                        Text(trip.arrivalTime)
                            .font(.subheadline.bold())
                            .foregroundColor(.primary)
                        
                        AsyncImage(url: URL(string: toStop.imageURL)) { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fill)
                        } placeholder: {
                            Color.gray.opacity(0.2)
                        }
                        .frame(width: 60, height: 60)
                        .cornerRadius(8)
                    }
                }
                .padding(.top, trip.isBest ? 12 : 0)
                
                Button(action: onSelect) {
                    Text("Select This Trolley")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(red: 0, green: 0.4, blue: 0.8))
                        .cornerRadius(8)
                }
            }
            .padding()
            .background(Color(uiColor: .systemBackground))
            .cornerRadius(12)
            .shadow(radius: 3)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(trip.isBest ? Color(red: 1, green: 0.42, blue: 0.21) : Color.clear, lineWidth: 2)
            )
            
            if trip.isBest {
                Text("✨ Best Match")
                    .font(.caption.bold())
                    .foregroundColor(.white)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 6)
                    .background(Color(red: 1, green: 0.42, blue: 0.21))
                    .cornerRadius(20)
                    .offset(y: -12)
            }
        }
        .padding(.horizontal)
        .padding(.vertical, trip.isBest ? 8 : 4)
    }
}
