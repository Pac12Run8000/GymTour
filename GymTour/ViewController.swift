//
//  ViewController.swift
//  GymTour
//
//  Created by MIchelle Grover on 3/10/16.
//  Copyright © 2016 Norbert Grover. All rights reserved.
//


//AIzaSyDURUTUsIvHe8bEIkq3_PcD6qVuJki9fGQ
import UIKit
import GoogleMaps

class gymDestinations:NSObject {
    let name:String
    let location:CLLocationCoordinate2D
    let zoom:Float
    init(name:String, location:CLLocationCoordinate2D, zoom:Float) {
        self.name = name
        self.location = location
        self.zoom = zoom
    
    }
}

class ViewController: UIViewController {
    
    var mapView:GMSMapView?
    
    var currentDestination: gymDestinations?
    
    let destinations = [gymDestinations(name: "Mariner Square Athletic Club", location: CLLocationCoordinate2DMake(37.786235, -122.279099), zoom: 15 ), gymDestinations(name:"Harbor Bay Club", location:CLLocationCoordinate2DMake(37.747553, -122.238843), zoom:15), gymDestinations(name:"Curves", location:CLLocationCoordinate2DMake(37.769069, -122.234815), zoom:15)]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GMSServices.provideAPIKey("AIzaSyDURUTUsIvHe8bEIkq3_PcD6qVuJki9fGQ")
        
        
        let camera = GMSCameraPosition.cameraWithLatitude(37.761686, longitude: -122.244754, zoom: 15)
        mapView = GMSMapView.mapWithFrame(CGRectZero, camera: camera)
        view = mapView
        
        let currentLocation = CLLocationCoordinate2DMake(37.761686, -122.244754)
        let marker = GMSMarker(position: currentLocation)
        marker.title = "Alameda Athletic Club"
        marker.map = mapView
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .Plain, target: self, action: "next")
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .Plain, target: self, action: "back")
       
    }
    func back() {
        
    }

    func next() {
        if (currentDestination == nil) {
            currentDestination = destinations.first
            
            CATransaction.begin()
            CATransaction.setValue(2, forKey: kCATransactionAnimationDuration)
            
            mapView?.animateToCameraPosition(GMSCameraPosition.cameraWithTarget((currentDestination?.location)!, zoom:(currentDestination?.zoom)!))
            
           CATransaction.commit()
            
            let marker = GMSMarker(position:currentDestination!.location)
            marker.title = currentDestination?.name
            marker.map = mapView

        } else {
            if let index = destinations.indexOf(currentDestination!) {
                currentDestination = destinations[index + 1]
                
                 mapView?.animateToCameraPosition(GMSCameraPosition.cameraWithTarget((currentDestination?.location)!, zoom:(currentDestination?.zoom)!))
                
                let marker = GMSMarker(position:currentDestination!.location)
                marker.title = currentDestination?.name
                marker.map = mapView
                
            }
        }
       
           }
    
    func setMapCamera() {
        
    }


}

