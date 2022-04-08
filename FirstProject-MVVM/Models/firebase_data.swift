//
//  firebase_data.swift
//  FirstUIkitProject
//
//  Created by Айдимир Магомедов on 16.02.2022.
//

import Foundation
import Firebase
import Kingfisher
import UIKit
import SwiftUI
import YandexMapsMobile

class FirebaseData{
    let database = Firestore.firestore()
    func getData(_ completionHandler : @escaping ([String:[String:Any]]?)-> Void){
        let docRef = database.document("Products/products_data")
        docRef.getDocument { data, error in
            if let data = data?.data() , error == nil {
            var dict = data as! [String:[String:Any]]
            completionHandler(dict)
            }
            else{
                completionHandler(nil)
            }
        }
    }
    func getPoints(_ completionHandler : @escaping ([Point])->Void){
        let docRef = database.document("MarksOnMap/marks")
        docRef.getDocument { data, error in
            guard let data = data?.data(), error == nil else{ return }
            let dict = data as! [String: [String:Any]]
            var res = [Point]()
            for (_,value) in dict{
                var name = value["name"] as! String
                var description = value["description"] as! String
                var worktime = value["worktime"] as! String
                var mapPoint = value["coordinates"] as! GeoPoint
                res.append(Point(name: name, description: description, worktime: worktime, pointOnMap: YMKPoint(latitude: mapPoint.latitude, longitude: mapPoint.longitude)))
            }
            completionHandler(res)
        }

    }
}
