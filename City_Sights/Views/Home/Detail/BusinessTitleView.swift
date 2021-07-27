//
//  BusinessTitleView.swift
//  City_Sights
//
//  Created by Will Archer on 7/26/21.
//

import SwiftUI

struct BusinessTitleView: View {
    
    var business: Business
    
    var body: some View {
        VStack (alignment: .leading) {
            // Business name
            Text(business.name ?? "")
                .font(.title2)
                .bold()
                .padding(.leading)
            
            // Business address
            if business.location?.displayAddress != nil {
                ForEach(business.location!.displayAddress!, id: \.self) { displayLine in
                    Text(displayLine)
                }
            }
            
            // Business rating
            Image("regular_\(business.rating ?? 0)")
        }
    }
}

