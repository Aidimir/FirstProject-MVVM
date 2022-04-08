//
//  presenter.swift
//  FirstUIkitProject
//
//  Created by Айдимир Магомедов on 28.03.2022.
//

import Foundation
import UIKit
import SwiftUI
import Kingfisher
import YandexMapsMobile

protocol ProductsPresenterDelegate{
    func presentProducts(dict: Dictionary<String,Array<ProductCard>>, allPoints : [Point])
    func errorHandler()
}
typealias PresenterDelegate = ProductsPresenterDelegate & UIViewController

class ProductsPresenter {
    weak var delegate : PresenterDelegate?
    func setDelegate(delegate : PresenterDelegate){
        self.delegate = delegate
    }
    func fetchData(){
        FirebaseData().getData { dict in
            if dict != nil{
                FirebaseData().getPoints { p in
                    self.presentData(dict: dict!, allPoints: p)
                }
            }
            else{
                // some cache stuff will be here
                self.delegate?.errorHandler()
            }
        }
    }
    func presentData(dict : [String : [String : Any]], allPoints : [Point]){
        var array : Array<ProductCard> = []
        var allGroups = [String]()
        for (key,value) in dict{
            if !allGroups.contains(value["group"] as! String){
                allGroups.append(value["group"] as! String)
            }
        }
        allGroups.sort()
        allGroups.append("all")
        var dictionary : Dictionary<String,Array<ProductCard>> = [:]
        for i in allGroups{
            dictionary[i] = []
        }
        for (_,value) in dict{
            var uiImages = [UIImage]()
            if value["images"] != nil{
                for i in value["images"] as! Array<String>{
                    let url = URL(string: i)
                    let image = try? UIImage(data: Data(contentsOf: url!))
                    uiImages.append(image ?? UIImage(systemName: "photo")!)
                }
            }
            if uiImages.isEmpty{
                uiImages.append(UIImage(systemName: "photo")!)
            }
            let productName = value["name"] as! String
            let price = value["price"] as! Int
            var images = [Image]()
            for i in uiImages{
                images.append(Image(uiImage: i))
            }
            let destinationPage = UIHostingController(rootView: Page(images: images, mainImg: uiImages[0], productName: productName, description: value["description"] as! String, price: price))
            let shortdescription = value["description"] as! String
            dictionary[value["group"] as! String]!.append(ProductCard(name: productName, image: uiImages[0], shortdescription: shortdescription, frame: .zero, destinationPage: destinationPage , price: price))
            dictionary["all"]!.append(ProductCard(name: value["name"] as! String, image: uiImages[0], shortdescription: shortdescription, frame: .zero, destinationPage: destinationPage , price: price))
        }
        
        self.delegate?.presentProducts(dict: dictionary , allPoints: allPoints)
    }
}
