//
//  BusinessDetailView.swift
//  City_Sights
//
//  Created by Will Archer on 7/26/21.
//

import SwiftUI

struct BusinessDetailView: View {
    
    var business: Business
    var body: some View {
        VStack(alignment: .leading) {
            
            GeometryReader () { geo in
                let uiImage = UIImage(data: business.imageData ?? Data())
                Image(uiImage: uiImage ?? UIImage())
                    .resizable()
                    .frame(width: geo.size.width , height: geo.size.height)
                    .clipped()
            }
            .ignoresSafeArea(.all, edges: .top)
            
            ZStack (alignment: .leading){
                if business.isClosed! == false {
                    Rectangle()
                        .frame(height: 36)
                        .foregroundColor(.blue)
                    Text("Open").padding(.leading).foregroundColor(.white)
                }
                else {
                    Rectangle()
                        .frame(height: 20)
                        .foregroundColor(.gray)
                    Text("Closed").padding(.leading).foregroundColor(.white)
                }
            }
            Group {
                
                // Business name
                Text(business.name ?? "").font(.largeTitle).padding(.leading)
                
                // Business address
                if business.location?.displayAddress != nil {
                    ForEach(business.location!.displayAddress!, id: \.self) { displayLine in
                        Text(displayLine)
                    }
                }
                
                // Business rating
                Image("regular_\(business.rating ?? 0)")
                    .padding()
                Divider()
                // Phone
                HStack {
                    Text("Phone").bold()
                    Text(business.displayPhone ?? "")
                    Spacer()
                    Link("Call", destination: URL(string: "tel:\(business.phone ?? "")")!)
                }
                .padding()
                
                Divider()
                // REviews
                HStack {
                    Text("Reviews:").bold()
                    Text(String(business.reviewCount ?? 0))
                    Spacer()
                    Link("Read", destination: URL(string: "\(business.url ?? "")")!)
                }
                .padding()
                Divider()
                
                //Website
                HStack {
                    Text("Website:").bold()
                    Text(business.url ?? "")
                        .lineLimit(1)
                    Spacer()
                    Link("Visit", destination: URL(string: "\(business.url ?? "")")!)
                }
                .padding()
                
                Divider()
            }
            // Get directions Button
            Button {
                // TODO: show directions
            } label: {
                ZStack {
                    Rectangle()
                        .frame(height: 48)
                        .foregroundColor(.blue)
                    Text("Get Directions")
                        .foregroundColor(.white)
                        .bold()
                        .cornerRadius(10)
                }
            }
        }
    }
}

