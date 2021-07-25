//
//  BusinessList.swift
//  City_Sights
//
//  Created by Will Archer on 7/25/21.
//

import SwiftUI

struct BusinessList: View {
    @EnvironmentObject var model: ContentModel
    var body: some View {
        ScrollView {
            LazyVStack (alignment: .leading, pinnedViews: [.sectionHeaders]){
                
                BusinessSection(title: "Restaurants", businesses: model.restaurants)
                
                BusinessSection(title: "Sights", businesses: model.sights)
            }
        }
    }
}
struct BusinessList_Previews: PreviewProvider {
    static var previews: some View {
        BusinessList()
    }
}
