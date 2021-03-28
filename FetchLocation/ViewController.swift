//
//  ViewController.swift
//  FetchLocation
//
//  Created by Fahim Rahman on 25/3/21.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var spinner: UIActivityIndicatorView! {
        didSet {
            spinner.hidesWhenStopped = true
        }
    }
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var latLabel: UILabel!
    @IBOutlet weak var lonLabel: UILabel!
    
    var locationManager : CLLocationManager?
    var currentLocation: CLLocation?
    
    
    var lati = 0.0
    var longi = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchLocation()

    }
    
    func fetchLocation() {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestAlwaysAuthorization()
    }


    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            if status == .authorizedAlways || status == .authorizedWhenInUse {
                print(status)
                locationManager?.requestLocation()
            }
            else {
                print("Void with \(status)")
            }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            currentLocation = locations.last
        
            if let lat = currentLocation?.coordinate.latitude {
                print(lat)
                self.lati = lat
                latLabel.text = "lat: " + String(lati)
            }
            if let lon = currentLocation?.coordinate.longitude {
                print(lon)
                self.longi = lon
                lonLabel.text = "lon: " + String(longi)
            }
            textLabel.text = "Process Done!!"
        
        DispatchQueue.main.async {
            self.spinner.stopAnimating()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
           print("In Error part with Error - \(error)")
    }
        
}

