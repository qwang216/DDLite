//
//  DeliveryMapController.swift
//  DDLite
//
//  Created by Jason wang on 6/23/19.
//  Copyright © 2019 Jason wang. All rights reserved.
//

import UIKit
import MapKit

protocol DeliverMapControllerDelegate: class {
    func userSelectedLocation(at lng: Double, lat: Double)
}

class DeliveryMapController: UIViewController {
    
    let regionInMeters:Double = 1000
    var previousLocation: CLLocation?
    weak var delegate: DeliverMapControllerDelegate?
    let geocoder = DDGeocodeService()
    
    let mapview: MKMapView = {
        let mv = MKMapView()
        mv.showsUserLocation = true
        return mv
    }()
    
    let pinOverLayImageView: UIImageView = {
       let iv = UIImageView()
        iv.image = UIImage(named: "map-pin-black")
        iv.setSize(.init(width: 30, height: 30))
        return iv
    }()
    
    lazy var confirmButton: UIButton = {
        let bt = UIButton(type: .system)
        bt.setTitleColor(.white, for: .normal)
        bt.setTitle("Confirm Address", for: .normal)
        bt.backgroundColor = UIColor.red
        bt.addTarget(self, action: #selector(handleConfirmButton), for: .touchUpInside)
        return bt
    }()
    
    let addressTextField: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = .white
        tf.placeholder = "Enter Delivery Address..."
        tf.textAlignment = .center
        tf.isUserInteractionEnabled = false
        return tf
    }()
    
    let locationManager = LocationManager()
    
    
    // Functions ---
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Choose an Address"
        mapview.delegate = self
        setupStackView()
        setupPinView()
        startLocationServices()
    }
    
    func setupPinView() {
        mapview.addSubview(pinOverLayImageView)
        pinOverLayImageView.centerSuperView(offSetX: 0, offSetY: 30)
    }
    
    func setupStackView() {
        let width = view.bounds.width
        let height:CGFloat = 80
        confirmButton.setSize(.init(width: width, height: height))
        addressTextField.setSize(.init(width: width, height: height))
        let vStackView = UIStackView(arrangedSubviews: [mapview, addressTextField, confirmButton])
        vStackView.axis = .vertical
        vStackView.spacing = 0
        view.addSubview(vStackView)
        vStackView.fillToSuperView()
    }
    
    func startLocationServices() {
        locationManager.checkLocationServices()
        locationManager.delegate = self
    }
    
    @objc
    func handleConfirmButton() {
        if let selectedLocation = previousLocation {
            let coordinate = selectedLocation.coordinate
            delegate?.userSelectedLocation(at: coordinate.longitude, lat: coordinate.latitude)
        }
        dismiss(animated: true, completion: nil)
    }
    
}

extension DeliveryMapController: LocationManagerDelegate {
    
    func updateUserLocationAt(location: CLLocation?) {
        guard let location = location else { return }
        let region = MKCoordinateRegion.init(center: location.coordinate, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
        mapview.setRegion(region, animated: true)
        previousLocation = mapview.centerLocation
    }
    
    func deviceLocationStatus(_ status: DeviceLocationStatus) {
        switch status {
        case .denied:
            showAlertView(title: "Opps", message: "Please go to settings to enable location services in order to use our service")
        case .notEnabled:
            showAlertView(title: "Error", message: "This device does not have location services enabled")
        case .restricted:
            showAlertView(title: "Oh no! 😱", message: "Your device has location services restricted")
        case .unknown:
            showAlertView(title: "Error", message: "Please take a screen shot and email to a developer for this error")
        }
    }
}

extension DeliveryMapController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let center = mapView.centerLocation
        
        // prevent reverse geolocation to exceed it's limit by check distant delta > 80 meters
        guard let preLocation = previousLocation, center.distance(from: preLocation) > 80 else { return }
        previousLocation = center
        geocoder.fetchAddressFrom(location: center) { [unowned self] (result) in
            switch result {
            case .success(let address):
                self.addressTextField.placeholder = address
            case .failure(let err):
                self.showAlertView(title: "Location Error", message: err.localizedDescription)
            }
        }
    }
}
