//
//  VoiceAssistantApp.swift
//  VoiceAssistant
//
//  Created by Jor . on 19/03/2024.
//

import SwiftUI

@main
struct VoiceAssistantApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
            #if os(macOS)
                .frame(width: 400, height: 400)
            #endif
        }
        #if os(macOS)
        .windowStyle(.hiddenTitleBar)
        .windowResizability(.contentSize)
        #elseif os(visionOS)
        .defaultSize(width: 0.4, height: 0.4, depth: 0.0, in: .meters)
        .windowResizability(.contentSize)
        #endif
    }
}
