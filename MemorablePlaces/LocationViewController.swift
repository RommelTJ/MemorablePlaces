//
//  LocationViewController.swift
//  MemorablePlaces
//
//  Created by Rommel Rico on 3/4/15.
//  Copyright (c) 2015 Rommel Rico. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class LocationViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var myMapView: MKMapView!
    var manager:CLLocationManager!
    @IBOutlet weak var myLatitudeLabel: UILabel!
    @IBOutlet weak var myLongitudeLabel: UILabel!
    @IBOutlet weak var mySpeedLabel: UILabel!
    @IBOutlet weak var myCourseLabel: UILabel!
    @IBOutlet weak var myAltitudeLabel: UILabel!
    @IBOutlet weak var myAddressTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let lat = NSString(string: places[activePlace]["lat"]!).doubleValue
        let lon = NSString(string: places[activePlace]["lon"]!).doubleValue
        
        //Initialize default location.
        var latitude:CLLocationDegrees = lat
        var longitude:CLLocationDegrees = lon
        
        //Initialize zoom-level
        var latDelta:CLLocationDegrees = 0.01
        var lonDelta:CLLocationDegrees = 0.01
        
        //Define view variables
        var span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        var location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        var region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        //Set the map to the region
        myMapView.setRegion(region, animated: true)

        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        myAddressTextView.text = ""
    }

    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        var userLocation:CLLocation = locations[0] as CLLocation
        
        //Set the labels
        myLatitudeLabel.text = "Latitude: \(userLocation.coordinate.latitude)"
        myLongitudeLabel.text = "Longitude: \(userLocation.coordinate.longitude)"
        mySpeedLabel.text = "Speed: \(userLocation.speed)"
        myCourseLabel.text = "Course: \(userLocation.course)"
        myAltitudeLabel.text = "Altitude: \(userLocation.altitude)"
        
        //Nearest address
        CLGeocoder().reverseGeocodeLocation(userLocation, completionHandler: { (placemarks, error) -> Void in
            if (error != nil) {
                NSLog("ERROR: \(error)")
            } else {
                let place = CLPlacemark(placemark: placemarks[0] as CLPlacemark)
                
                var name = place.name
                var subThoroughfare = place.subThoroughfare
                var thoroughfare = place.thoroughfare
                var city = place.locality
                var state = place.administrativeArea
                var zipCode = place.postalCode
                var country = place.country
                
                if (name == nil) {
                    name = ""
                }
                if (subThoroughfare == nil) {
                    subThoroughfare = ""
                }
                if (thoroughfare == nil) {
                    thoroughfare = ""
                }
                if (city == nil) {
                    city = ""
                }
                if (state == nil) {
                    state = ""
                }
                if (zipCode == nil) {
                    zipCode = ""
                }
                if (country == nil) {
                    country = ""
                }
                
                
                self.myAddressTextView.text = "\(name) \n \(subThoroughfare) \(thoroughfare) \n \(city), \(state) \(zipCode) \n \(country)"
            }
        })
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
