//
//  BusinessSearch.swift
//  City_Sights
//
//  Created by Will Archer on 7/25/21.
//

import Foundation

struct BusinessSearch: Decodable {
    
    var businesses = [Business]()
    var total = 0
    var region = Region()
}

struct Region: Decodable {
    var center = Coordinate()
}
