//
//  BusinessDetailView.swift
//  City_Sights
//
//  Created by Will Archer on 7/26/21.
//

import SwiftUI

struct BusinessDetailView: View {
    
    @State private var showDirections = false
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
                HStack {
                    BusinessTitleView(business: business)
                        .padding()
                    Spacer()
                    YelpAttribution(link: business.url!)
                }
                
                DashedDivider()
                    .padding(.horizontal)
                // Phone
                HStack {
                    Text("Phone").bold()
                    Text(business.displayPhone ?? "")
                    Spacer()
                    Link("Call", destination: URL(string: "tel:\(business.phone ?? "")")!)
                }
                .padding()
                
                DashedDivider()
                    .padding(.horizontal)
                // REviews
                HStack {
                    Text("Reviews:").bold()
                    Text(String(business.reviewCount ?? 0))
                    Spacer()
                    Link("Read", destination: URL(string: "\(business.url ?? "")")!)
                }
                .padding()
                DashedDivider()
                    .padding(.horizontal)
                
                //Website
                HStack {
                    Text("Website:").bold()
                    Text(business.url ?? "")
                        .lineLimit(1)
                    Spacer()
                    Link("Visit", destination: URL(string: "\(business.url ?? "")")!)
                }
                .padding()
                
                DashedDivider()
                    .padding(.horizontal)
            }
            // Get directions Button
            Button {
                // TODO: show directions
                showDirections = true
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
            .sheet(isPresented: $showDirections) {
                DirectionsView(business: business)
            }
        }
    }
}

