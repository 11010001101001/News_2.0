//
//  NewsApp.swift
//  News
//
//  Created by Ярослав Куприянов on 26.03.2024.
//

import SwiftUI
import SwiftData

@main
struct NewsApp: App {
    @Environment(\.scenePhase) var phase
    @StateObject var viewModel = ViewModel()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            SettingsModel.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(viewModel)
                .onChange(of: phase) { _, phase in
                    switch phase {
                    case .active:
                        if let itemName = ShortcutItem.selectedAction?.userInfo?["name"] as? String {
                            viewModel.handleShortcutItemTap(itemName)
                        }
                    case .background:
                        viewModel.addShortcutItems()
                    case .inactive:
                        break
                    @unknown default:
                        assertionFailure("Unknown default phase: \(phase)")
                    }
                }
        }
        .modelContainer(sharedModelContainer)
    }
}
