//
//  LocationFinder.swift
//  LocationFinder
//
//  Created by Elizabeth Kiernan on 4/6/20.
//  Copyright © 2020 Elizabeth Kiernan. All rights reserved.
//

import UIKit
import GooglePlaces
import CoreLocation
import MapKit


class LocationFinder: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    
    var placesClient: GMSPlacesClient!
    let locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        placesClient = GMSPlacesClient.shared()
        
        // provide API key
        func didFinishLaunchingWithOptions () {
            GMSPlacesClient.provideAPIKey("API Key omitted for security")
        }

        let placesClient = GMSPlacesClient.shared()
        
        // Printed errors if place is not found
        placesClient.currentPlace { (likelihoodlist, error) -> Void in
            if error != nil {
                print("Current Place error: \(error!.localizedDescription)")
                return
            } 
            
            placesClient.currentPlace(callback: { (placeLikelihoodList, error) -> Void in
                if let error = error {
                    print("Pick Place error: \(error.localizedDescription)")
                    return
                }
                
                // Assigns and prints name and address of current place to labels                            
                self.nameLabel.text = "No current place"
                self.addressLabel.text = ""
                
                if let placeLikelihoodList = placeLikelihoodList {
                    let place = placeLikelihoodList.likelihoods.first?.place
                    if let place = place {
                        self.nameLabel.text = place.name
                        self.addressLabel.text = place.formattedAddress?.components(separatedBy: ", ")
                            .joined(separator: "\n")
                        
                    }
                }
            })
        }
    }
}
