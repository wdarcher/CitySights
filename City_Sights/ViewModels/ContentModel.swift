//
//  ContentModel.swift
//  City_Sights
//
//  Created by Will Archer on 7/25/21.
//

import Foundation
import CoreLocation

class ContentModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()
    
    @Published var authorizationState = CLAuthorizationStatus.notDetermined
    @Published var restaurants = [Business]()
    @Published var sights = [Business]()
    override init() {
        // init NSObject
        super.init()
        
        // set content model as the delegate of the location manager
        locationManager.delegate = self
        
        //Request Permission from user
        locationManager.requestWhenInUseAuthorization()
        
        // TODO: Start GeoLocating User, after we get permission
        // locationManager.startUpdatingLocation()
    }
    
    // MARK: - Location Manager Delagete methods
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        // Update authorization state
        
        authorizationState = locationManager.authorizationStatus
        if locationManager.authorizationStatus == .authorizedAlways ||
            locationManager.authorizationStatus == .authorizedWhenInUse {
            
            // We have permission
            // Start Geolocating user after we have permission
            locationManager.startUpdatingLocation()
        }
        else if locationManager.authorizationStatus == .denied {
            // We dont have permission
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // Gives us location of the user
        let userLocation = locations.first
        
        if userLocation != nil {
            // We have a location
            
            // Stop requesting location after we get it once
            locationManager.stopUpdatingLocation()
            
            // if we have the coordinates of the user send into Yelp API
            getBusinesses(category: Constants.sightsKey, location: userLocation!)
            getBusinesses(category: Constants.restaurantsKey, location: userLocation!)
            
        }
    
    }
    // MARK: - Yelp API methods
    func getBusinesses(category: String, location: CLLocation) {
        
        // Create URL
        /*
        let urlString = "https://api.yelp.com/v3/businesses/search?latitude=\(location.coordinate.latitude)&longitude=\(location.coordinate.longitude)&categories=\(category)&limit=6"
        
        let url = URL(string: urlString)
        */
        
        var urlComponents = URLComponents(string: Constants.apiURL)
        
        urlComponents?.queryItems = [
            URLQueryItem(name: "latitude", value: String(location.coordinate.latitude)),
            URLQueryItem(name: "longitude", value: String(location.coordinate.longitude)),
            URLQueryItem(name: "categories", value: category),
            URLQueryItem(name: "limit", value: "6")
        ]
        let url = urlComponents?.url
        if let url = url {
            // Create URL request
            var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10.0)
            request.httpMethod = "GET"
            request.addValue("Bearer \(Constants.apiKey)", forHTTPHeaderField: "Authorization")
            
            // get URLSession
            let session = URLSession.shared
            // Create Data Task
            let dataTask = session.dataTask(with: request) { (data, response, error) in
                
                // Check that there isn't an error
                if error == nil {
                    // Parse JSON
                    let decoder = JSONDecoder()
                    
                    do {
                        let result = try decoder.decode(BusinessSearch.self, from: data!)
                        // Assign results to appropriate property
                        DispatchQueue.main.async {
                            switch category {
                            case Constants.sightsKey:
                                self.sights = result.businesses
                            case Constants.restaurantsKey:
                                self.restaurants = result.businesses
                            default:
                                break
                            }
                        }
                    }
                    catch {
                        print(error)
                    }
                }
                
            }
            dataTask.resume()
            // Start the Data Task
        }
    }
}
