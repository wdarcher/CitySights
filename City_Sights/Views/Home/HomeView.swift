//
//  HomeView.swift
//  City_Sights
//
//  Created by Will Archer on 7/25/21.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var model: ContentModel
    @State var isMapShowing = false
    @State var selectedBusiness: Business?
    var body: some View {
        if model.restaurants.count != 0 || model.sights.count != 0 {
            //Determine if we should show list or map
            
            NavigationView {
                if !isMapShowing {
                    //Show list
                    VStack (alignment: .leading){
                        HStack{
                            Image(systemName: "location")
                            Text("San Francisco")
                            Spacer()
                            Button("Switch to map view") {
                                self.isMapShowing = true
                            }
                        }
                        Divider()
                        
                        BusinessList()
                        
                    }.padding([.horizontal, .top])
                    .navigationBarHidden(true)
                }
                else {
                    //show map
                    BusinessMap(selectedBusiness: $selectedBusiness)
                        .ignoresSafeArea()
                        .sheet(item: $selectedBusiness) { business in
                            
                            // Create business detail view instance
                            // Pass in business
                            BusinessDetailView(business: business)
                        }
                }
            }
            
        }
        else {
            //Still waiting on data so show spinner
            ProgressView()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
