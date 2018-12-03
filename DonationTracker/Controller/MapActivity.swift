//
//  MapActivity.swift
//  DonationTracker
//
//  Created by Jessica Bishop on 12/2/18.
//  Copyright © 2018 Brachio. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps

class MapActivity: UIViewController {
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
    
    override func loadView() {
        let currentLocation = NavigateToMapActivity.getLocationSelected()
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        var camera = GMSCameraPosition.camera(withLatitude: 33.75416, longitude: -84.37742, zoom: 10.0)
        var mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        if (currentLocation == 1) {
            camera = GMSCameraPosition.camera(withLatitude: 33.75416, longitude: -84.37742, zoom: 20.0)
            mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        } else if (currentLocation == 2) {
            camera = GMSCameraPosition.camera(withLatitude: 33.73182, longitude: -84.43971, zoom: 20.0)
            mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        } else if (currentLocation == 3) {
            camera = GMSCameraPosition.camera(withLatitude: 33.70866, longitude: -84.41853, zoom: 20.0)
            mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        } else if (currentLocation == 4) {
            camera = GMSCameraPosition.camera(withLatitude: 33.80129, longitude: -84.25537, zoom: 20.0)
            mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        } else if (currentLocation == 5) {
            camera = GMSCameraPosition.camera(withLatitude: 33.71747, longitude: -84.2521, zoom: 20.0)
            mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        } else if (currentLocation == 6) {
            camera = GMSCameraPosition.camera(withLatitude: 33.96921, longitude: -84.3688, zoom: 20.0)
            mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        } else {
            camera = GMSCameraPosition.camera(withLatitude: 33.75416, longitude: -84.37742, zoom: 10.0)
            mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        }
        view = mapView
        
        // Creates a marker in the center of the map.
        let markerAFD = GMSMarker()
        markerAFD.position = CLLocationCoordinate2D(latitude: 33.75416, longitude: -84.37742)
        markerAFD.title = "AFD Station"
        markerAFD.snippet = "(404) 555 - 3456"
        markerAFD.map = mapView
        
        let markerBG = GMSMarker()
        markerBG.position = CLLocationCoordinate2D(latitude: 33.73182, longitude: -84.43971)
        markerBG.title = "Boys & Girls Club W.W. Woolfolk"
        markerBG.snippet = "(404) 555 - 1234"
        markerBG.map = mapView
        
        let markerPath = GMSMarker()
        markerPath.position = CLLocationCoordinate2D(latitude: 33.70866, longitude: -84.41853)
        markerPath.title = "Pathway Upper Room Christian Ministries"
        markerPath.snippet = "(404) 555 - 5432"
        markerPath.map = mapView
        
        let markerPav = GMSMarker()
        markerPav.position = CLLocationCoordinate2D(latitude: 33.80129, longitude: -84.25537)
        markerPav.title = "Pavilion of Hope Inc."
        markerPav.snippet = "(404) 555 - 8765"
        markerPav.map = mapView
        
        let markerDaD = GMSMarker()
        markerDaD.position = CLLocationCoordinate2D(latitude: 33.71747, longitude: -84.2521)
        markerDaD.title = "D&D Convenience Store"
        markerDaD.snippet = "(404) 555 - 9876"
        markerDaD.map = mapView
        
        let markerKeep = GMSMarker()
        markerKeep.position = CLLocationCoordinate2D(latitude: 33.96921, longitude: -84.3688)
        markerKeep.title = "Keep North Fulton Beautiful"
        markerKeep.snippet = "(770) 555 - 7321"
        markerKeep.map = mapView
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
