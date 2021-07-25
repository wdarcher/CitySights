//
//  LaunchView.swift
//  City_Sights
//
//  Created by Will Archer on 7/25/21.
//

import SwiftUI
import CoreLocation

struct LaunchView: View {
    
    @EnvironmentObject var model: ContentModel
    var body: some View {
        
        // Detect the authorization status of Geolocating user
        if model.authorizationState == .notDetermined {
            // if undetermined, show onboarding
            
        }
        else if model.authorizationState == CLAuthorizationStatus.authorizedAlways || model.authorizationState == CLAuthorizationStatus.authorizedWhenInUse {
            // if approved, show home view
            HomeView()
        }
        else {
            // if denied, show denied view
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
    }
}
