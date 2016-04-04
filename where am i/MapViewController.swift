//
//  MapViewController.swift
//  where am i
//
//  Created by Raúl T on 28/03/16.
//  Copyright © 2016 rtc. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit


class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBAction func cancel(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    @IBOutlet var map: MKMapView!
    
    var locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation: CLLocation = locations[0]
        
        let latitude = userLocation.coordinate.latitude
        
        let longitude = userLocation.coordinate.longitude
        
        let latDelta: CLLocationDegrees = 0.015
        
        let longDelta: CLLocationDegrees = 0.015
        
        let span: MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
        
        let location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        
        let region: MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        self.map.setRegion(region, animated: true)
        
        // setting pin location
        let annontation = MKPointAnnotation()
        
        annontation.coordinate = location
        
        annontation.title = direction
        
        annontation.subtitle = "Your location"
        
        map.addAnnotation(annontation)
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
