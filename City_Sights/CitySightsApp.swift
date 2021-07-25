//
//  CitySightsApp.swift
//  City_Sights
//
//  Created by Will Archer on 7/25/21.
//

import SwiftUI

@main
struct CitySightsApp: App {
    var body: some Scene {
        WindowGroup {
            LaunchView()
                .environmentObject(ContentModel())
        }
    }
}
