//
//  YelpAttribution.swift
//  City_Sights
//
//  Created by Will Archer on 7/27/21.
//

import SwiftUI

struct YelpAttribution: View {
    
    var link: String
    var body: some View {
        Link(destination: URL(string: link)!) {
            Image("yelp")
                .resizable()
                .scaledToFit()
                .frame(height: 36)
        }
    }
}


