//
//  TrolleyTripCard.swift
//  MauiTrolly
//

import SwiftUI

private let primaryBlue  = Color(red: 0, green: 0.4, blue: 0.8)
private let accentOrange = Color(red: 1, green: 0.42, blue: 0.21)

struct TrolleyTripCard: View {
    let trip: TrolleyTrip
    let fromStop: TrolleyStop
    let toStop: TrolleyStop
    let onSelect: () -> Void

    var body: some View {
        ZStack(alignment: .top) {
            VStack(spacing: 0) {
                // ── Route timeline ────────────────────────────────────
                HStack(alignment: .center, spacing: 0) {

                    // Departure
                    VStack(alignment: .leading, spacing: 4) {
                        Text(trip.departureTime)
                            .font(.system(size: 22, weight: .bold, design: .rounded))
                            .foregroundColor(.primary)
                        Text(fromStop.shortName)
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .lineLimit(2)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)

                    // Duration line
                    VStack(spacing: 4) {
                        Text("\(trip.travelTime) min")
                            .font(.caption.bold())
                            .foregroundColor(.secondary)
                        HStack(spacing: 0) {
                            Circle()
                                .fill(primaryBlue)
                                .frame(width: 8, height: 8)
                            Rectangle()
                                .fill(Color.gray.opacity(0.4))
                                .frame(height: 2)
                            Image(systemName: "tram.fill")
                                .font(.caption)
                                .foregroundColor(primaryBlue)
                            Rectangle()
                                .fill(Color.gray.opacity(0.4))
                                .frame(height: 2)
                            Circle()
                                .fill(accentOrange)
                                .frame(width: 8, height: 8)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 8)

                    // Arrival
                    VStack(alignment: .trailing, spacing: 4) {
                        Text(trip.arrivalTime)
                            .font(.system(size: 22, weight: .bold, design: .rounded))
                            .foregroundColor(.primary)
                        Text(toStop.shortName)
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .lineLimit(2)
                            .multilineTextAlignment(.trailing)
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .padding(.horizontal, 20)
                .padding(.top, trip.isBest ? 28 : 20)
                .padding(.bottom, 16)

                Divider()
                    .padding(.horizontal, 20)

                // ── Select button (HIG: filled prominent button) ──────
                Button(action: {
                    AnalyticsService.logSelectTrip(
                        departureTime: trip.departureTime,
                        isBestMatch: trip.isBest
                    )
                    onSelect()
                }) {
                    Text("View Ride Details")
                        .font(.subheadline.bold())
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 13)
                        .background(primaryBlue)
                        .cornerRadius(10)
                }
                .buttonStyle(.plain)
                .padding(.horizontal, 16)
                .padding(.bottom, 16)
            }
            .background(Color(uiColor: .systemBackground))
            .cornerRadius(16)
            .shadow(
                color: trip.isBest ? primaryBlue.opacity(0.2) : .black.opacity(0.06),
                radius: trip.isBest ? 10 : 6,
                x: 0, y: 2
            )
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(trip.isBest ? accentOrange : Color.clear, lineWidth: 2)
            )

            // ── Best Match badge ──────────────────────────────────────
            if trip.isBest {
                Text("⭐ Best Match")
                    .font(.caption.bold())
                    .foregroundColor(.white)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 5)
                    .background(accentOrange)
                    .clipShape(Capsule())
                    .offset(y: -10)
            }
        }
        .padding(.top, trip.isBest ? 10 : 0)
    }
}
