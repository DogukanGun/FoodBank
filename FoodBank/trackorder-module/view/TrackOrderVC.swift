//
//  TrackOrderVC.swift
//  FoodBank
//
//  Created by Dogukan Gundogan on 13.01.2022.
//

import Foundation
import UIKit
import CoreLocation
import MapKit

class TrackOrderVC:UIViewController{
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var mapKit: MKMapView!
    let locationManager=CLLocationManager()
    var location:CLLocation?
    var updatingLocation = false
    var lastLocationError:Error?
    var placemark:CLPlacemark? = nil
    let gecoder = CLGeocoder()

    var performingReverseGecoding=false
    var lastGecodingError:Error?
    var logoVisible=false
    var timer:Timer?


    override func viewDidLoad() {
        self.changeBarColor(color: UIColor.black)
        mapKit.delegate = self
        if userDefaults.bool(forKey: Constants.userDefaultsOrderStatus){
            getLocation()
        }else{
            errorDialog(title: "Oppps", errorMessage: "First order, than track ", okayButtonText: "Okay")
        }
        
    }
    
    private func getLocation(){
        let authStatus = locationManager.authorizationStatus
        if authStatus == .notDetermined{
            locationManager.requestWhenInUseAuthorization()
            return
        }
        if authStatus == .denied || authStatus == .restricted{
            showLocationServiceDeniedError()
            return
        }
        if logoVisible{
            hideLogoView()
        }
        if updatingLocation {
            stopLocationManager()
        }else{
            location=nil
            lastLocationError=nil
            placemark=nil
            lastGecodingError=nil
            startLocation()

        }
    }
    func showLogoView(){
        if !logoVisible{
            self.view.addSubview(indicator)
            self.view.bringSubviewToFront(indicator)
            indicator.startAnimating()
        }
    }
    func hideLogoView(){
        if !logoVisible {return}
        indicator.stopAnimating()
        logoVisible=false
        
        

        
    }
    func showLocationServiceDeniedError(){
        let alert=UIAlertController(title: "Location Service Disabled", message: "Enable Location Service", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    func startLocation(){
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate=self
            locationManager.desiredAccuracy=kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            
            indicator.stopAnimating()
        }
    }
    func stopLocationManager(){
        if updatingLocation {
             updatingLocation=false
            if let timer = timer{
                timer.invalidate()
            }
        }
    }
    @objc func didTimeOut(){
        if location == nil{
             lastLocationError = NSError(domain: "MyLocationErrorDomain", code: 1, userInfo: nil)
        }
    }
}
 
 
extension TrackOrderVC : MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
         
        let identifier = "Location"
        // bu identifier yoksa yaratmaz for identifierli olan yaratir
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil{
            let pinView =  MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            //tiklanabilir
            pinView.isEnabled = true
            //tiklandiginda ustundde baloncuk ciksin mi
            pinView.canShowCallout = true
            //animasyonlu mu ciksin balon
            pinView.animatesDrop = false
            //pinin rengi degissin mi
            pinView.pinTintColor = UIColor(red: 0.32, green: 0.82, blue: 0.4, alpha: 1.0)
            // bulut icinde info butonu gozukmesi icin
            let rightButton = UIButton(type: .detailDisclosure)
            rightButton.addTarget(nil, action: #selector(showLocationDetails(_:)), for: .touchUpInside)
            pinView.rightCalloutAccessoryView = rightButton
            
            annotationView = pinView
        }
        if let annotationView = annotationView{
            annotationView.annotation = annotation
            let button = annotationView.rightCalloutAccessoryView as! UIButton
            
        }
        return annotationView
        
    }
    @objc func showLocationDetails(_ sender:UIButton){
        performSegue(withIdentifier: "EditLocation", sender: sender)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditLocation"{
           
        }
    }
}


extension TrackOrderVC:CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if (error as NSError).code == CLError.locationUnknown.rawValue{
            return
        }
        lastLocationError=error
        stopLocationManager()
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let newLocation = locations.last!
        
        if newLocation.timestamp.timeIntervalSinceNow < -5{
            return
        }
        if newLocation.horizontalAccuracy < 0{
            return
        }
        var distance = CLLocationDistance(Double.greatestFiniteMagnitude)
        if let location = location{
            distance = newLocation.distance(from: location)
        }
        if location == nil || location!.horizontalAccuracy > newLocation.horizontalAccuracy{
            lastLocationError=nil
            location = newLocation
            if newLocation.horizontalAccuracy <= locationManager.desiredAccuracy{
                stopLocationManager()
                
                if distance>0{
                    performingReverseGecoding=false
                }
            }
            
            if !performingReverseGecoding{
                performingReverseGecoding=true
                gecoder.reverseGeocodeLocation(newLocation){ placemark,error in
                    self.lastGecodingError=error
                     
                    if let places = placemark,error == nil, !places.isEmpty{
                        if self.placemark == nil{
                            self.placemark=places.last
                            let region = MKCoordinateRegion(center: self.mapKit.userLocation.coordinate, latitudinalMeters:  100, longitudinalMeters: 100)
                            
                            self.mapKit.setRegion(region, animated: true)
                            self.indicator.stopAnimating()
                            self.indicator.alpha = 0
                        }
                        
                    }else{
                        self.placemark=nil
                    }
                    self.performingReverseGecoding=false
                }
            }
        }else if distance<1{
            let timeInterval = newLocation.timestamp.timeIntervalSince(location!.timestamp)
            if timeInterval>10{
                stopLocationManager()
            }
        }
        
        
    }
}
