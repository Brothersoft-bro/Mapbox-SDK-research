//
//  NavigationViewController.swift
//  NaviApp
//
//  Created by Brothersoft
//  Copyright © 2020 Brothersoft. All rights reserved.
//

import UIKit
import Mapbox
import MapboxCoreNavigation
import MapboxNavigation
import MapboxDirections

class BasicNavigationViewController: UIViewController {

    @IBOutlet weak var mapView: MGLMapView!
    var directionsRoute: Route?
    var pointAnnotation: MGLPointAnnotation?
    
    // MARK: UIViewController Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Navigation View Controller"
        
        // Allow the map to display the user's location
        self.mapView.showsUserLocation = true
        self.mapView.setUserTrackingMode(.follow, animated: true, completionHandler: nil)

        // Add a gesture recognizer to the map view
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(didLongPress(_:)))
        self.mapView.addGestureRecognizer(longPress)
    }

    // MARK: Gesture Recognizers

    @objc func didLongPress(_ sender: UILongPressGestureRecognizer) {
        guard sender.state == .began else { return }
     
        // Converts point where user did a long press to map coordinates
        let point = sender.location(in: self.mapView)
        let coordinate = self.mapView.convert(point, toCoordinateFrom: self.mapView)
     
        if (self.pointAnnotation != nil) {
            self.mapView.removeAnnotation(self.pointAnnotation!)
        }
        
        // Create a basic point annotation and add it to the map
        self.pointAnnotation = MGLPointAnnotation()
        self.pointAnnotation!.coordinate = coordinate
        self.pointAnnotation!.title = "Start navigation"
        self.mapView.addAnnotation(self.pointAnnotation!)
     
        // Calculate the route from the user's location to the set destination
        calculateRoute(from: (self.mapView.userLocation!.coordinate), to: self.pointAnnotation!.coordinate) { (route, error) in
            if error != nil {
                print("Error calculating route")
            }
        }
    }
    
    // MARK: Helper Methods

    // Calculate route to be used for navigation
    func calculateRoute(from origin: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D, completion: @escaping (Route?, Error?) -> ()) {
        // Coordinate accuracy is the maximum distance away from the waypoint that the route may still be considered viable, measured in meters. Negative values indicate that a indefinite number of meters away from the route and still be considered viable.
        let origin = Waypoint(coordinate: origin, coordinateAccuracy: -1, name: "Start")
        let destination = Waypoint(coordinate: destination, coordinateAccuracy: -1, name: "Finish")
     
        // Specify that the route is intended for automobiles avoiding traffic
        let options = NavigationRouteOptions(waypoints: [origin, destination], profileIdentifier: .automobileAvoidingTraffic)
     
        // Generate the route object and draw it on the map
        _ = Directions.shared.calculate(options) { [unowned self] (waypoints, routes, error) in
            self.directionsRoute = routes?.first
            // Draw the route on the map after creating it
            
            if (self.directionsRoute != nil) {
                self.drawRoute(route: self.directionsRoute!)
            }
        }
    }
    
    func drawRoute(route: Route) {
        guard route.coordinateCount > 0 else { return }
        // Convert the route’s coordinates into a polyline
        var routeCoordinates = route.coordinates!
        let polyline = MGLPolylineFeature(coordinates: &routeCoordinates, count: route.coordinateCount)
     
        // If there's already a route line on the map, reset its shape to the new route
        if let source = self.mapView.style?.source(withIdentifier: "route-source") as? MGLShapeSource {
            source.shape = polyline
            } else {
            let source = MGLShapeSource(identifier: "route-source", features: [polyline], options: nil)
     
            // Customize the route line color and width
            let lineStyle = MGLLineStyleLayer(identifier: "route-style", source: source)
            lineStyle.lineColor = NSExpression(forConstantValue: #colorLiteral(red: 0.1897518039, green: 0.3010634184, blue: 0.7994888425, alpha: 1))
            lineStyle.lineWidth = NSExpression(forConstantValue: 3)
     
            // Add the source and style layer of the route line to the map
            self.mapView.style?.addSource(source)
            self.mapView.style?.addLayer(lineStyle)
        }
    }
}


extension BasicNavigationViewController: MGLMapViewDelegate {
    // MARK: MGLMapViewDelegate

    // Implement the delegate method that allows annotations to show callouts when tapped
    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        return true
    }
     
    // Present the navigation view controller when the callout is selected
    func mapView(_ mapView: MGLMapView, tapOnCalloutFor annotation: MGLAnnotation) {
        let navigationViewController = NavigationViewController(for: self.directionsRoute!)
        navigationViewController.modalPresentationStyle = .fullScreen
        self.present(navigationViewController, animated: true, completion: nil)
    }
}
