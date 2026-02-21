//
//  BookingConfirmationView.swift
//  MauiTrolly
//

import SwiftUI

struct BookingConfirmationView: View {
    let trip: TrolleyTrip
    let fromStop: TrolleyStop
    let toStop: TrolleyStop
    let onBack: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(spacing: 0) {
                    // ── Header ──────────────────────────────────────────
                    HStack(spacing: 12) {
                        Image(systemName: "tram.fill")
                            .font(.title2)
                            .foregroundColor(.white)
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Ride Summary")
                                .font(.headline.bold())
                                .foregroundColor(.white)
                            Text("Times are approximate — plan accordingly")
                                .font(.caption)
                                .foregroundColor(.white.opacity(0.85))
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 14)
                    .background(
                        LinearGradient(
                            colors: [Color(red: 0, green: 0.4, blue: 0.8), Color(red: 0, green: 0.32, blue: 0.64)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )

                    VStack(spacing: 16) {
                        // Trip Card
                        VStack(spacing: 24) {
                            // Route Timeline
                            VStack(spacing: 0) {
                                // Departure
                                HStack(alignment: .top, spacing: 16) {
                                    VStack(spacing: 4) {
                                        Circle()
                                            .fill(Color(red: 0, green: 0.4, blue: 0.8))
                                            .frame(width: 16, height: 16)
                                        Rectangle()
                                            .fill(Color.gray.opacity(0.3))
                                            .frame(width: 2, height: 80)
                                    }

                                    VStack(alignment: .leading, spacing: 8) {
                                        Text(trip.departureTime)
                                            .font(.title2.bold())
                                            .foregroundColor(.primary)
                                        Text(fromStop.name)
                                            .font(.headline)
                                        AsyncImage(url: URL(string: fromStop.imageURL)) { image in
                                            image.resizable()
                                                .aspectRatio(contentMode: .fill)
                                        } placeholder: {
                                            Color.gray.opacity(0.2)
                                        }
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 120)
                                        .cornerRadius(12)
                                    }
                                }

                                // Arrival
                                HStack(alignment: .top, spacing: 16) {
                                    Circle()
                                        .fill(Color(red: 1, green: 0.42, blue: 0.21))
                                        .frame(width: 16, height: 16)

                                    VStack(alignment: .leading, spacing: 8) {
                                        Text(trip.arrivalTime)
                                            .font(.title2.bold())
                                            .foregroundColor(.primary)
                                        Text(toStop.name)
                                            .font(.headline)
                                        AsyncImage(url: URL(string: toStop.imageURL)) { image in
                                            image.resizable()
                                                .aspectRatio(contentMode: .fill)
                                        } placeholder: {
                                            Color.gray.opacity(0.2)
                                        }
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 120)
                                        .cornerRadius(12)
                                    }
                                }
                            }

                            Divider()

                            // Trip Details
                            HStack {
                                VStack(spacing: 4) {
                                    Image(systemName: "clock")
                                        .font(.title2)
                                        .foregroundColor(Color(red: 0, green: 0.4, blue: 0.8))
                                    Text("Travel Time")
                                        .font(.caption.bold())
                                        .foregroundColor(.secondary)
                                    Text("\(trip.travelTime) min")
                                        .font(.headline)
                                }
                                .frame(maxWidth: .infinity)

                                Divider()
                                    .frame(height: 60)

                                VStack(spacing: 4) {
                                    Image(systemName: "dollarsign.circle")
                                        .font(.title2)
                                        .foregroundColor(.green)
                                    Text("Cost")
                                        .font(.caption.bold())
                                        .foregroundColor(.secondary)
                                    Text("FREE")
                                        .font(.headline)
                                }
                                .frame(maxWidth: .infinity)
                            }
                        }
                        .padding(24)
                        .background(Color(uiColor: .systemBackground))
                        .cornerRadius(16)
                        .shadow(radius: 5)

                        // Reminder Card
                        VStack(alignment: .leading, spacing: 12) {
                            HStack {
                                Image(systemName: "info.circle.fill")
                                    .foregroundColor(.accentColor)
                                Text("Important Reminders")
                                    .font(.headline)
                                    .foregroundColor(.primary)
                            }

                            ReminderRow(icon: "clock.fill",
                                        text: "Please arrive 5 minutes early")
                            ReminderRow(icon: "person.2.fill",
                                        text: "This is a free shared trolley service")
                            ReminderRow(icon: "exclamationmark.triangle.fill",
                                        text: "Times are approximate and subject to traffic")
                        }
                        .padding()
                        .background(Color(uiColor: .secondarySystemGroupedBackground))
                        .cornerRadius(12)

                        Button(action: onBack) {
                            Text("Search Again")
                                .font(.headline)
                                .foregroundColor(.accentColor)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color(uiColor: .systemBackground))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color.accentColor, lineWidth: 2)
                                )
                                .cornerRadius(12)
                        }
                    }
                    .padding()
                }
            }
            .background(Color(uiColor: .systemGroupedBackground))

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
        .navigationBarBackButtonHidden(true)
        .onAppear {
            AnalyticsService.logViewRideDetails(
                from: fromStop.shortName,
                to: toStop.shortName
            )
        }
    }
}

struct ReminderRow: View {
    let icon: String
    let text: String

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: icon)
                .font(.subheadline)
                .foregroundColor(.orange)
            Text(text)
                .font(.subheadline)
                .foregroundColor(.primary)
        }
    }
}
