//
//  CIVICApp.swift
//  CIVIC
//
//  Created by Pritish Sareen on 18/08/26.
//

import SwiftUI
import SwiftData

@main
struct CIVICApp: App {
    
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environment(\.font, .appDefault)
        }
        .modelContainer(for: CivicTask.self)
    }
}
#Preview {
    MainTabView()}
