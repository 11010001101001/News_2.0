//
//  ContentView.swift
//  News
//
//  Created by Ярослав Куприянов on 26.03.2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query private var savedSettings: [SettingsModel]

    @ObservedObject var viewModel: ViewModel

    var body: some View {
        NavigationView {
            TopicsList(viewModel: viewModel)
                .refreshable {
                    viewModel.playRefresh()
                    viewModel.loadNews()
                }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    NavigationLink {
                        SettingsList(viewModel: viewModel)
                    } label: {
                        Label("", systemImage: "gear")
                    }
                }
            }
            .navigationTitle("News")

        }
        .onAppear {
            loadSettings()
            viewModel.loadNews()
        }
    }
}

// MARK: - Helpers
extension ContentView {
    private func loadSettings() {
        if savedSettings.isEmpty {
            let defaultSettings = [SettingsModel(category: Category.business.rawValue,
                                                 soundTheme: SoundTheme.silentMode.rawValue)]
            modelContext.insert(defaultSettings[0])
            try? modelContext.save()

            viewModel.savedSettings = defaultSettings
        } else {
            viewModel.savedSettings = savedSettings
        }
    }
}

#Preview {
    ContentView(viewModel: ViewModel())
        .modelContainer(for: SettingsModel.self, inMemory: true)
}
