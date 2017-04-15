//
//  ViewController.swift
//  NPF-3
//
//  Created by Payal Kothari on 4/13/17.
//  Copyright © 2017 Payal Kothari. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var refreshBtn: UIBarButtonItem!
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var userLication: CLLocation?
    var locationManager = CLLocationManager()
    var parksObject = Parks()  // object of Parks class object. It contains list of all parks
    var allParks : [Park]{    // array containing objects of class Park which contains all park properties
        get{
            return parksObject.allParksList
        }
        set(parksList){
            parksObject.allParksList = parksList
        }
    }
    
    
    @IBAction func segmentedAction(_ sender: UISegmentedControl) {
        switch (sender.selectedSegmentIndex) {
            case 0:
                mapView.mapType = .standard
            case 1:
                mapView.mapType = .satellite
            case 2:
                mapView.mapType = .hybrid
            default:
                mapView.mapType = .standard
        }
    }
    @IBAction func zoomOut(_ sender: UIBarButtonItem) {
        locationManager.startUpdatingLocation()
        let userLocation = locationManager.location
        
        let mkCoordinateRegion = MKCoordinateRegionMakeWithDistance(userLocation!.coordinate, 4000000, 4000000)
        self.mapView?.setRegion(mkCoordinateRegion, animated: true)
        stopUpdating()
    }
    
    @IBAction func refreshClicked(_ sender: UIBarButtonItem) {
        startUpdating()
        let userLocation = locationManager.location
        
        let mkCoordinateRegion = MKCoordinateRegionMakeWithDistance(userLocation!.coordinate, 20000, 20000)
        self.mapView?.setRegion(mkCoordinateRegion, animated: true)
        stopUpdating()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.center = view.center
        activityIndicator.startAnimating()
        
        if CLLocationManager.locationServicesEnabled(){
            if locationManager.responds(to: #selector(CLLocationManager.requestWhenInUseAuthorization)){ //request to access location when using the app
                locationManager.requestAlwaysAuthorization()        // request to access location also in background
            }
        }
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest   // best accuracy
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        
        for park: MKAnnotation in allParks{
            mapView.addAnnotation(park)
        }
        mapView.delegate = self
    }
    
    
    func mapView(_ mv: MKMapView, viewFor  annotation: MKAnnotation) -> MKAnnotationView? {
        var view: MKPinAnnotationView
        let identifier = "Pin"
        
        if annotation is MKUserLocation {
            //if annotation is not an MKPointAnnotation (eg. MKUserLocation),
            //return nil so map draws default view for it (eg. blue dot)...
            return nil
        }
        if annotation !== mv.userLocation   {
            //look for an existing view to reuse
            if let dequeuedView = mv.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView {
                dequeuedView.annotation = annotation
                view = dequeuedView
            } else {
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.pinTintColor = MKPinAnnotationView.purplePinColor()
                view.animatesDrop = true
                view.canShowCallout = true
                
                let leftButton = UIButton(type: .infoLight)
                let rightButton = UIButton(type: .detailDisclosure)
                leftButton.tag = 0
                rightButton.tag = 1
                view.leftCalloutAccessoryView = leftButton
                view.rightCalloutAccessoryView = rightButton
            }
            activityIndicator.stopAnimating()
            return view
        }
        
        return nil
    }
    
    
    func mapView(_ mv: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        let parkAnnotation = view.annotation as! Park
        switch control.tag {
        case 0: //left button
            if let url = URL(string: parkAnnotation.getLink()){
                UIApplication.shared.open(url, options: [:], completionHandler: nil)                }
        case 1: //right button
            let coordinate = locationManager.location?.coordinate //make sure location manager has updated before trying to use
            let url = String(format: "http://maps.apple.com/maps?saddr=%f,%f&daddr=%f,%f", coordinate!.latitude,coordinate!.longitude,parkAnnotation.getLocation().coordinate.latitude,parkAnnotation.getLocation().coordinate.longitude)
            UIApplication.shared.open(URL(string: url)!, options: [:], completionHandler: nil)
        default:
            break
        }
    }
    
    func startUpdating(){
        locationManager.startUpdatingLocation()
    }
    
    func stopUpdating(){
        locationManager.stopUpdatingLocation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        mapView.showsUserLocation = true
        activityIndicator.stopAnimating()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

