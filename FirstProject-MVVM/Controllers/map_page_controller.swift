//
//  map_page_controller.swift
//  FirstUIkitProject
//
//  Created by Айдимир Магомедов on 09.03.2022.


import Foundation
import UIKit
import YandexMapsMobile
import MapKit

class MapPageController : UIViewController, YMKMapObjectTapListener {
    private var openedSheet = false
    func onMapObjectTap(with mapObject: YMKMapObject, point: YMKPoint) -> Bool {
        NotificationCenter.default.post(name: NSNotification.Name("openSheet"), object: nil)
        return true
    }
    let viewControllerToPresent = BottomSheet()
    let mapView = YMKMapView()
    var allPoints : [Point]?
    let bottomButton : UIButton = {
        let button = BottomMapButton().createButton()
        button.addTarget(self, action: #selector(onTap), for: .touchUpInside)
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(moveTo), name: NSNotification.Name("moveMap"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onTap), name: NSNotification.Name("openSheet"), object: nil)
        let defaultLocation = YMKPoint(latitude: 56.84173039415533, longitude: 60.65174074759386)
        let mapObjects = mapView.mapWindow.map.mapObjects
        let map = mapView.mapWindow.map
        var style = """
        [
       {
        "tags": {
            "any": ["poi","transit", "polyline"]
       },
       "types": ["point"],
       "stylers": {
       "visibility": "off"       }
       }
       ]
       """
        points = allPoints!
        for i in allPoints!{
            let rect = YMKRect(min: CGPoint(x: 0, y: 0), max: CGPoint(x: 1, y: 1))
            var placeMark = mapObjects.addPlacemark(with: i.pointOnMap, image: UIImage(systemName: "rhombus.fill")!, style: YMKIconStyle(anchor: nil, rotationType: 1, zIndex: nil, flat: 1, visible: 1, scale: 2.5, tappableArea: rect))
            placeMark.addTapListener(with: self)
            
        }
        map.move(
            with: YMKCameraPosition(target: points[0].pointOnMap, zoom: 10, azimuth: 0, tilt: 0),
            animationType: YMKAnimation(type: YMKAnimationType.smooth, duration: 3),
            cameraCallback: nil)
        map.setMapStyleWithStyle(style)
        view.addSubview(mapView)
        setup(map: mapView)
            NotificationCenter.default.post(name: NSNotification.Name("reloadBottomSheet"), object: nil)
        view.addSubview(bottomButton)
        buttonSetup(button: bottomButton)
        map.move(
            with: YMKCameraPosition.init(target: defaultLocation, zoom: 10, azimuth: 0, tilt: 0),
            animationType: YMKAnimation(type: YMKAnimationType.smooth, duration: 0),
            cameraCallback: nil)
        title = "Map"
    }
    func setup(map : UIView){
        map.translatesAutoresizingMaskIntoConstraints = false
        map.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        map.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        map.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        map.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
    func buttonSetup(button : UIButton){
        button.translatesAutoresizingMaskIntoConstraints = false
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: view.bottomAnchor , constant: -view.frame.height*0.09).isActive = true
        button.widthAnchor.constraint(equalTo: view.widthAnchor , multiplier: 0.4).isActive = true
        button.heightAnchor.constraint(equalTo: view.heightAnchor , multiplier: 0.06).isActive = true
    }
    @objc func moveTo(notification : NSNotification){
        mapView.mapWindow.map.move(
            with: YMKCameraPosition.init(target: notification.object as! YMKPoint, zoom: 15, azimuth: 0, tilt: 0),
            animationType: YMKAnimation(type: YMKAnimationType.smooth, duration: 1),
            cameraCallback: nil)
    }
    @objc func onTap(){
        if let sheet = viewControllerToPresent.sheetPresentationController{
            sheet.detents = [ .medium() , .large()]
            sheet.prefersGrabberVisible = true
            sheet.largestUndimmedDetentIdentifier = .medium
            sheet.prefersScrollingExpandsWhenScrolledToEdge = true
            sheet.prefersEdgeAttachedInCompactHeight = true
            sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
            sheet.prefersEdgeAttachedInCompactHeight = true
        }
        if openedSheet == false{
        present(viewControllerToPresent, animated: true, completion: nil)
        }
        else{
            dismiss(animated: true)
        }
        print("it has been tapped")
        openedSheet = !(openedSheet)
    }
}
