//
//  ContentView.swift
//  MauiTrolly
//
//  Created by GitHub Copilot on 2/12/26.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = BookingViewModel()
    
    var body: some View {
        NavigationStack {
            if let selectedTrip = viewModel.selectedTrip {
                BookingConfirmationView(
                    trip: selectedTrip,
                    fromStop: viewModel.fromStop,
                    toStop: viewModel.toStop,
                    onBack: {
                        viewModel.selectedTrip = nil
                    }
                )
            } else {
                SearchView(viewModel: viewModel)
            }
        }
    }
}

#Preview {
    ContentView()
}
