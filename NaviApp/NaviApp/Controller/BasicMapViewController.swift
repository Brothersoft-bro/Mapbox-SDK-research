//
//  BasicMapViewController.swift
//  NaviApp
//
//  Created by Brothersoft
//  Copyright © 2020 Brothersoft. All rights reserved.
//

import UIKit
import Mapbox

class BasicMapViewController: UIViewController {

    @IBOutlet weak var mapView: MGLMapView!
    
    // MARK: UIViewController Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Basic Map View Controller"
        self.mapView.showsUserLocation = true;
        
        setMapCenter(zoomLevel: 10)
    }
    
    // MARK: UI Control events

    @IBAction func zoomToCurrentLocationPressed(_ sender: Any) {
        setMapCenter(zoomLevel: self.mapView.zoomLevel)
    }
    
    // MARK: Helper Methods

    func setMapCenter(zoomLevel: Double) {
        let center = CLLocationCoordinate2D(latitude: 46.770439, longitude: 23.591423)
        self.mapView.setCenter(center, zoomLevel: zoomLevel, direction: 0, animated: false)
    }
}

extension BasicMapViewController: MGLMapViewDelegate {
    // MARK: MGLMapViewDelegate
    
    func mapViewDidFinishLoadingMap(_ mapView: MGLMapView) {
        // Wait for the map to load before initiating the first camera movement.

         // Create a camera that rotates around the same center point, rotating with rotationAngle.
         // `fromDistance:` is meters above mean sea level that an eye would have to be in order to see what the map view is showing.
           
         let rotationAngle = 0.0
         let camera = MGLMapCamera(lookingAtCenter: self.mapView.centerCoordinate, altitude: 4500, pitch: 15, heading: rotationAngle)
        
         // Animate the camera movement over nr of seconds.
         let nrOfSeconds = 4.0
         self.mapView.setCamera(camera, withDuration: nrOfSeconds, animationTimingFunction: CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut))
    }
}
