//
//  ViewController.swift
//  where am i
//
//  Created by Raúl T on 28/03/16.
//  Copyright © 2016 rtc. All rights reserved.
//

import UIKit
import CoreLocation

var direction = ""

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var manager: CLLocationManager!

    @IBOutlet var longitudeLabel: UILabel!
    @IBOutlet var latitudLabel: UILabel!
    @IBOutlet var accuracyLabel: UILabel!
    @IBOutlet var speedLabel: UILabel!
    @IBOutlet var altitudeLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // round info of labels
        let userLocation: CLLocation = locations[0]
        let multiplier = pow(10.0, 4.0)
        
        let lat = userLocation.coordinate.latitude
        let latRounded = round(lat * multiplier) / multiplier
        let lon = userLocation.coordinate.longitude
        let lonRounded = round(lon * multiplier) / multiplier
        let speed = (abs(userLocation.speed))
        let speedRounded = round(speed * multiplier) / multiplier
        let altitude = (userLocation.altitude)
        let altitudeRounded = round(altitude * multiplier) / multiplier
        let accuracy = abs(userLocation.verticalAccuracy)
        let accuracyRounded = round(accuracy * multiplier / multiplier)
        
        // set info labels
        
        self.latitudLabel.text = "\(latRounded)"
        
        self.longitudeLabel.text = "\(lonRounded)"
        
        self.speedLabel.text = "\(speedRounded) m/s"
        
        self.altitudeLabel.text = "\(altitudeRounded) m"
        
        self.accuracyLabel.text = "\(accuracyRounded)"
        
        CLGeocoder().reverseGeocodeLocation(userLocation, completionHandler: { (placemarks, error) -> Void in
            
            if (error != nil) {
                
                print(error)
                
            }
                
                
            else {
                
                // finding info about location
                if let p = placemarks?[0] {
                    
                    var fullAddress = ""
                    
                    // checking if the infirmation exist to add it to the label
                    if let street = p.thoroughfare {
                        
                        fullAddress.appendContentsOf(street)
                        
                    }
                    
                    if let sublocal = p.subLocality {
                        
                        fullAddress.appendContentsOf("\n\(sublocal)")
                        direction = sublocal

                    }
                    
                    if let adminArea = p.administrativeArea {
                        
                        fullAddress.appendContentsOf("\n\(adminArea)")
                        
                    }
                    
                    if let postCode = p.postalCode {
                        
                        fullAddress.appendContentsOf("\n\(postCode)")
                        
                    }
                    
                    if let country = p.country {
                        
                        fullAddress.appendContentsOf("\n\(country)")
                    }
                    
                    //print(fullAddress)
                    self.addressLabel.text = fullAddress
                    
                }
                
                
            }
            
        })
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

