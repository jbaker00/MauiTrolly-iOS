//
//  SearchView.swift
//  MauiTrolly
//

import SwiftUI

private let primaryBlue = Color(red: 0, green: 0.4, blue: 0.8)
private let darkBlue    = Color(red: 0, green: 0.32, blue: 0.64)
private let accentOrange = Color(red: 1, green: 0.42, blue: 0.21)

struct SearchView: View {
    @ObservedObject var viewModel: BookingViewModel
    @StateObject private var interstitialAd = InterstitialAdCoordinator()

    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(spacing: 0) {
                    // ── Header ──────────────────────────────────────────
                    HStack(spacing: 10) {
                        Text("🚃")
                            .font(.title3)
                        VStack(alignment: .leading, spacing: 1) {
                            Text("Kaanapali Trolley")
                                .font(.headline.bold())
                                .foregroundColor(.white)
                            Text("Free Resort Shuttle · Kaanapali, Maui")
                                .font(.caption)
                                .foregroundColor(.white.opacity(0.85))
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                    .background(
                        LinearGradient(colors: [primaryBlue, darkBlue],
                                       startPoint: .topLeading, endPoint: .bottomTrailing)
                    )

                    // ── Search Card ──────────────────────────────────────
                    VStack(spacing: 20) {
                        VStack(alignment: .leading, spacing: 16) {

                            // Route selector (vertical with connecting line)
                            HStack(alignment: .center, spacing: 14) {
                                // Dot → line → dot
                                VStack(spacing: 0) {
                                    Circle()
                                        .fill(primaryBlue)
                                        .frame(width: 13, height: 13)
                                    Rectangle()
                                        .fill(Color.gray.opacity(0.35))
                                        .frame(width: 2, height: 44)
                                    Circle()
                                        .fill(accentOrange)
                                        .frame(width: 13, height: 13)
                                }

                                // Stop pickers
                                VStack(alignment: .leading, spacing: 8) {
                                    StopPickerRow(label: "FROM", stopId: $viewModel.fromStopId)
                                    Divider()
                                    StopPickerRow(label: "TO",   stopId: $viewModel.toStopId)
                                }
                                .frame(maxWidth: .infinity)

                                // Swap button
                                Button(action: viewModel.swapLocations) {
                                    Image(systemName: "arrow.up.arrow.down.circle.fill")
                                        .font(.system(size: 28))
                                        .foregroundColor(primaryBlue.opacity(0.8))
                                }
                            }
                            .padding(.horizontal, 4)

                            Divider()

                            // Time & search type
                            HStack(spacing: 16) {
                                VStack(alignment: .leading, spacing: 4) {
                                    Label("TIME", systemImage: "clock")
                                        .font(.caption.bold())
                                        .foregroundColor(.secondary)
                                    DatePicker("", selection: $viewModel.desiredTime,
                                               displayedComponents: .hourAndMinute)
                                        .labelsHidden()
                                }

                                Spacer()

                                VStack(alignment: .leading, spacing: 4) {
                                    Label("TYPE", systemImage: "arrow.left.arrow.right")
                                        .font(.caption.bold())
                                        .foregroundColor(.secondary)
                                    Picker("Type", selection: $viewModel.searchType) {
                                        Text("Depart").tag(TrolleyScheduleService.SearchType.departure)
                                        Text("Arrive").tag(TrolleyScheduleService.SearchType.arrival)
                                    }
                                    .pickerStyle(.segmented)
                                    .frame(width: 150)
                                }
                            }

                            // Search button
                            Button(action: {
                                viewModel.searchTrolleys()
                                interstitialAd.showAd()
                            }) {
                                HStack {
                                    Image(systemName: "magnifyingglass")
                                    Text("Find Trolleys")
                                        .font(.headline)
                                }
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 14)
                                .background(
                                    LinearGradient(colors: [primaryBlue, darkBlue],
                                                   startPoint: .leading, endPoint: .trailing)
                                )
                                .cornerRadius(12)
                            }
                        }
                        .padding(20)
                        .background(Color(uiColor: .systemBackground))
                        .cornerRadius(16)
                        .shadow(color: .black.opacity(0.08), radius: 8, x: 0, y: 2)

                        // ── Results / Empty state ────────────────────────
                        if viewModel.hasSearched {
                            if viewModel.searchResults.isEmpty {
                                VStack(spacing: 12) {
                                    Image(systemName: "tram.fill")
                                        .font(.system(size: 40))
                                        .foregroundColor(.secondary.opacity(0.5))
                                    Text("No trolleys available")
                                        .font(.headline)
                                        .foregroundColor(.primary)
                                    Text("Try a different time or direction")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                                .padding(40)
                                .frame(maxWidth: .infinity)
                                .background(Color(uiColor: .systemBackground))
                                .cornerRadius(16)
                                .shadow(color: .black.opacity(0.06), radius: 6, x: 0, y: 2)
                            } else {
                                VStack(alignment: .leading, spacing: 12) {
                                    HStack {
                                        Text("Available Trolleys")
                                            .font(.title3.bold())
                                        Spacer()
                                        Text("\(viewModel.searchResults.count) options")
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                    }
                                    .padding(.horizontal, 4)

                                    ForEach(viewModel.searchResults) { trip in
                                        TrolleyTripCard(
                                            trip: trip,
                                            fromStop: viewModel.fromStop,
                                            toStop: viewModel.toStop,
                                            onSelect: { viewModel.selectedTrip = trip }
                                        )
                                    }
                                }
                            }
                        } else {
                            // Info card shown before first search
                            InfoCard()
                        }
                    }
                    .padding(16)
                    .background(Color(uiColor: .systemGroupedBackground))
                }
            }

            // ── Banner Ad ──────────────────────────────────────────────
            GeometryReader { geo in
                BannerAdView(width: geo.size.width)
                    .frame(width: geo.size.width, height: 50)
                    .background(Color(uiColor: .tertiarySystemBackground))
                    .overlay(alignment: .top) { Divider() }
                    .ignoresSafeArea(edges: .bottom)
            }
            .frame(height: 50)
        }
    }
}

// MARK: - Stop Picker Row

private struct StopPickerRow: View {
    let label: String
    @Binding var stopId: Int

    var body: some View {
        HStack(spacing: 8) {
            Text(label)
                .font(.caption.bold())
                .foregroundColor(.secondary)
                .frame(width: 36, alignment: .leading)
            Picker(label, selection: $stopId) {
                ForEach(TrolleyStop.allStops) { stop in
                    Text(stop.shortName).tag(stop.id)
                }
            }
            .pickerStyle(.menu)
            .tint(Color(red: 0, green: 0.4, blue: 0.8))
        }
    }
}

// MARK: - Info Card

private struct InfoCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack(spacing: 8) {
                Image(systemName: "tram.fill")
                    .foregroundColor(Color(red: 0, green: 0.4, blue: 0.8))
                Text("About the Trolley")
                    .font(.headline)
            }

            InfoRow(icon: "clock.fill",         title: "Hours",     value: "10:00 AM – 9:30 PM Daily")
            InfoRow(icon: "arrow.clockwise",     title: "Frequency", value: "Every ~30 minutes")
            InfoRow(icon: "dollarsign.circle",   title: "Cost",      value: "FREE for resort guests")
            InfoRow(icon: "phone.fill",          title: "Phone",     value: "1-808-667-0648")
        }
        .padding(20)
        .background(Color(uiColor: .systemBackground))
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.06), radius: 6, x: 0, y: 2)
    }
}

// MARK: - Info Row

struct InfoRow: View {
    let icon: String
    let title: String
    let value: String

    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: icon)
                .font(.subheadline)
                .foregroundColor(Color(red: 0, green: 0.4, blue: 0.8))
                .frame(width: 20)
            Text(title)
                .font(.subheadline.bold())
                .foregroundColor(.primary)
            Text(value)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
}
