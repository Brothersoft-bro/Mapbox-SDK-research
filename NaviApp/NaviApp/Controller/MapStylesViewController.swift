//
//  MapStylesViewController.swift
//  NaviApp
////
//  Created by Brothersoft
//  Copyright © 2020 Brothersoft. All rights reserved.
//

import UIKit
import Mapbox

class MapStylesViewController: UIViewController {

    @IBOutlet weak var mapView: MGLMapView!
    @IBOutlet weak var styleSelectionTableView: UITableView!
    
    var listOfStyles: [MapStylesTableViewCellData] = []

    // MARK: UIViewController Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Map Styles View Controller"
        self.mapView.showsUserLocation = true;
        
        setMapCenter(zoomLevel: 10)
        
        setupTableViewCellData()

        self.styleSelectionTableView.register(UINib(nibName: "MapStylesCustomCell", bundle: nil), forCellReuseIdentifier: "MapStylesCustomCell")
    }
   
    // MARK: UI Control events

    @IBAction func zoomToCurrentLocationPressed(_ sender: Any) {
        setMapCenter(zoomLevel: self.mapView.zoomLevel)
    }
    
    // MARK: Helper Methods

    func setupTableViewCellData() {
        let satelliteStyleCellData = MapStylesTableViewCellData(cellType: MapStylesTableViewCellType.satelliteStyleCellType, cellTitle: "Satellite Style")
        let streetStyleCellData = MapStylesTableViewCellData(cellType: MapStylesTableViewCellType.streetsStyleCellType, cellTitle: "Street Style")
        let satelliteStreetStyleCellData = MapStylesTableViewCellData(cellType: MapStylesTableViewCellType.satelliteStreetStyleCellType, cellTitle: "Satellite Street Style")
        let outdoorStyleCellData = MapStylesTableViewCellData(cellType: MapStylesTableViewCellType.outdoorStyleCellType, cellTitle: "Outdoor Style")
        let lightStyleCellData = MapStylesTableViewCellData(cellType: MapStylesTableViewCellType.lightStyleURLCellType, cellTitle: "Light Style")

        self.listOfStyles = [satelliteStyleCellData, streetStyleCellData, satelliteStreetStyleCellData, outdoorStyleCellData, lightStyleCellData]
    }
    
    func setMapCenter(zoomLevel: Double) {
        let center = CLLocationCoordinate2D(latitude: 46.770439, longitude: 23.591423)
        self.mapView.setCenter(center, zoomLevel: zoomLevel, direction: 0, animated: false)
    }
}

extension MapStylesViewController: MGLMapViewDelegate {
    // MARK: MGLMapViewDelegate
    
    func mapViewDidFinishLoadingMap(_ mapView: MGLMapView) {
        // Wait for the map to load before initiating the first camera movement.

         // Create a camera that rotates around the same center point, rotating with rotationAngle.
         // `fromDistance:` is meters above mean sea level that an eye would have to be in order to see what the map view is showing.
           
         let rotationAngle = 0.0
         let camera = MGLMapCamera(lookingAtCenter: self.mapView.centerCoordinate, altitude: 4500, pitch: 15, heading: rotationAngle)
        
         // Animate the camera movement over nr of seconds.
         let nrOfSeconds = 2.0
         self.mapView.setCamera(camera, withDuration: nrOfSeconds, animationTimingFunction: CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut))
    }
}

extension MapStylesViewController: UITableViewDataSource, UITableViewDelegate {
       // MARK: UITableViewDataSource, UITableViewDelegate

       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return listOfStyles.count
       }
       
       func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return MapStylesTableViewCellData.mapStylesTableViewCellHeight
       }

       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cellData = self.listOfStyles[indexPath.row]
                   
           let mapStylesCustomCell = self.styleSelectionTableView.dequeueReusableCell(withIdentifier: "MapStylesCustomCell", for: indexPath) as? MapStylesCustomCell
               
           mapStylesCustomCell?.stylesCustomCellTitleLabel.text = cellData.cellTitle
           mapStylesCustomCell?.selectionStyle = .none
           mapStylesCustomCell?.backgroundColor = .systemTeal
           
           return mapStylesCustomCell!
       }

       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           let cellData = self.listOfStyles[indexPath.row]
           
           switch cellData.cellType {
           case MapStylesTableViewCellType.satelliteStyleCellType:
               self.mapView.styleURL = MGLStyle.satelliteStyleURL
           case MapStylesTableViewCellType.streetsStyleCellType:
               self.mapView.styleURL = MGLStyle.streetsStyleURL
           case MapStylesTableViewCellType.satelliteStreetStyleCellType:
               self.mapView.styleURL = MGLStyle.satelliteStreetsStyleURL
           case MapStylesTableViewCellType.outdoorStyleCellType:
               self.mapView.styleURL = MGLStyle.outdoorsStyleURL
           case MapStylesTableViewCellType.lightStyleURLCellType:
               self.mapView.styleURL = MGLStyle.lightStyleURL
           }
       }
}
