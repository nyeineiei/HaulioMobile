//
//  MapVC.swift
//  HaulioMobileSwift
//
//  Created by Moe Han on 9/9/18.
//  Copyright © 2018 Nyein Ei. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
//import CoreLocation

class MapVC: UIViewController,CLLocationManagerDelegate,GMSAutocompleteViewControllerDelegate {

    var locationManager:CLLocationManager!
    var mapView:GMSMapView!
    var viewData:Any!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
        self.setupLocationManager()
        self.setupRightBarButton()
    }
    
    func setData(data:Any) {
        self.viewData = data
    }
    
    func setupNavigationBar() {
        navigationController?.navigationBar.barTintColor = .init(red: 235/255, green: 33/255, blue: 46/255, alpha: 1.0)
        let vwimg = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
        vwimg.image = UIImage(named: "img_logo")
        self.navigationItem.titleView = vwimg;
    }
    
    func setupLocationManager() {
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
    }
    
    func setupRightBarButton() {
        let homeButton : UIBarButtonItem = UIBarButtonItem(title: "Search", style: UIBarButtonItemStyle.plain, target: self, action:#selector(self.showSearch))
        self.navigationItem.rightBarButtonItem = homeButton
    }
    
    //CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations.last!
        print("Location: \(location)")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error){
        print("Error: \(error)")
    }
    
    // Handle authorization for the location manager.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted:
            print("Location access was restricted.")
        case .denied:
            print("User denied access to location.")
            // Display the map using the default location.
            mapView.isHidden = false
        case .notDetermined:
            print("Location status not determined.")
        case .authorizedAlways: fallthrough
        case .authorizedWhenInUse:
            print("Location status is OK.")
        }
    }
    
    //Map
    override func loadView() {
        let camera = GMSCameraPosition.camera(withLatitude: 1.401599, longitude: 103.746416, zoom: 6.0)
        self.mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        self.mapView.isMyLocationEnabled = true
        
        let userpin = GMSMarker()
        userpin.position = CLLocationCoordinate2D(latitude: 1.401599, longitude: 103.746416)
        userpin.title = "current location"
        userpin.map = self.mapView
        
        //Job pin
        let jobpin = GMSMarker()
        let d = self.viewData as! Dictionary<String, Any>
        let geoLocation:Dictionary<String,Any> = d["geolocation"] as! Dictionary<String, Any>
        let lng:NSNumber = geoLocation["longitude"] as! NSNumber
        let lat:NSNumber = geoLocation["latitude"] as! NSNumber
        
        print(lng,lat)
        jobpin.position = CLLocationCoordinate2D(latitude: Double(lat), longitude: Double(lng))
        jobpin.title = d["address"] as? String
        jobpin.map = self.mapView
        
        view = self.mapView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func showSearch() {
        let placePickerController = GMSAutocompleteViewController()
        placePickerController.delegate = self
        present(placePickerController, animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        print("Place name: \(place.name)")
        print("Place address: \(String(describing: place.formattedAddress))")
        print("Place attributions: \(String(describing: place.attributions))")
        dismiss(animated: true, completion: nil)
        let jobpin = GMSMarker()
        jobpin.position = place.coordinate
        jobpin.title = place.name
        jobpin.map = self.mapView
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("Error: ", error.localizedDescription)
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    

}
