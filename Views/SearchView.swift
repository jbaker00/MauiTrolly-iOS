//
//  SearchView.swift
//  MauiTrolly
//
//  Created by GitHub Copilot on 2/12/26.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var viewModel: BookingViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // Header
                VStack(spacing: 8) {
                    Text("🚃 Kaanapali Trolley")
                        .font(.title.bold())
                        .foregroundColor(.white)
                    
                    Text("Find Your Free Ride")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.9))
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 24)
                .background(
                    LinearGradient(
                        colors: [Color(red: 0, green: 0.4, blue: 0.8), Color(red: 0, green: 0.32, blue: 0.64)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                
                VStack(spacing: 16) {
                    // Search Card
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Plan Your Ride")
                            .font(.title2.bold())
                            .foregroundColor(.primary)
                        
                        // From/To Row
                        HStack(spacing: 12) {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("FROM")
                                    .font(.caption.bold())
                                    .foregroundColor(.secondary)
                                
                                Picker("From", selection: $viewModel.fromStopId) {
                                    ForEach(TrolleyStop.allStops) { stop in
                                        Text(stop.shortName).tag(stop.id)
                                    }
                                }
                                .pickerStyle(.menu)
                                .tint(Color(red: 0, green: 0.4, blue: 0.8))
                            }
                            
                            Button(action: viewModel.swapLocations) {
                                Image(systemName: "arrow.up.arrow.down")
                                    .font(.title3)
                                    .foregroundColor(.secondary)
                                    .frame(width: 44, height: 44)
                                    .background(Color.gray.opacity(0.1))
                                    .cornerRadius(8)
                            }
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text("TO")
                                    .font(.caption.bold())
                                    .foregroundColor(.secondary)
                                
                                Picker("To", selection: $viewModel.toStopId) {
                                    ForEach(TrolleyStop.allStops) { stop in
                                        Text(stop.shortName).tag(stop.id)
                                    }
                                }
                                .pickerStyle(.menu)
                                .tint(Color(red: 0, green: 0.4, blue: 0.8))
                            }
                        }
                        
                        // Time Row
                        HStack(spacing: 12) {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("TIME")
                                    .font(.caption.bold())
                                    .foregroundColor(.secondary)
                                
                                DatePicker("", selection: $viewModel.desiredTime, displayedComponents: .hourAndMinute)
                                    .labelsHidden()
                            }
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text("TYPE")
                                    .font(.caption.bold())
                                    .foregroundColor(.secondary)
                                
                                Picker("Type", selection: $viewModel.searchType) {
                                    Text("Depart").tag(TrolleyScheduleService.SearchType.departure)
                                    Text("Arrive").tag(TrolleyScheduleService.SearchType.arrival)
                                }
                                .pickerStyle(.segmented)
                            }
                        }
                        
                        Button(action: viewModel.searchTrolleys) {
                            Text("Search Times")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(
                                    LinearGradient(
                                        colors: [Color(red: 0, green: 0.4, blue: 0.8), Color(red: 0, green: 0.32, blue: 0.64)],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                                .cornerRadius(12)
                        }
                    }
                    .padding()
                    .background(Color(uiColor: .systemBackground))
                    .cornerRadius(12)
                    .shadow(radius: 5)
                    
                    // Results
                    if viewModel.hasSearched {
                        if viewModel.searchResults.isEmpty {
                            VStack(spacing: 12) {
                                Image(systemName: "exclamationmark.triangle")
                                    .font(.largeTitle)
                                    .foregroundColor(.orange)
                                Text("No trolleys available for this time")
                                    .font(.body)
                                    .foregroundColor(.secondary)
                                Text("Please try a different time")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            .padding(40)
                            .frame(maxWidth: .infinity)
                            .background(Color(uiColor: .systemBackground))
                            .cornerRadius(12)
                            .shadow(radius: 5)
                        } else {
                            VStack(alignment: .leading, spacing: 12) {
                                Text("Available Trolleys")
                                    .font(.title3.bold())
                                    .foregroundColor(.primary)
                                    .padding(.horizontal)
                                
                                ForEach(viewModel.searchResults) { trip in
                                    TrolleyTripCard(
                                        trip: trip,
                                        fromStop: viewModel.fromStop,
                                        toStop: viewModel.toStop,
                                        onSelect: {
                                            viewModel.selectedTrip = trip
                                        }
                                    )
                                }
                            }
                        }
                    } else {
                        // Info Card
                        VStack(alignment: .leading, spacing: 12) {
                            HStack {
                                Image(systemName: "info.circle.fill")
                                    .foregroundColor(.accentColor)
                                Text("About the Trolley")
                                    .font(.headline)
                                    .foregroundColor(.primary)
                            }
                            
                            InfoRow(title: "Operating Hours:", value: "10:00 AM - 9:30 PM Daily")
                            InfoRow(title: "Frequency:", value: "Every 30 minutes (approximate)")
                            InfoRow(title: "Cost:", value: "FREE for Kaanapali resort guests")
                            InfoRow(title: "Phone:", value: "1-808-667-0648")
                        }
                        .padding()
                        .background(Color(uiColor: .systemBackground))
                        .cornerRadius(12)
                        .shadow(radius: 5)
                    }
                }
                .padding()
            }
        }
        .background(Color(uiColor: .systemGroupedBackground))
    }
}

struct InfoRow: View {
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.subheadline.bold())
            Text(value)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
}
