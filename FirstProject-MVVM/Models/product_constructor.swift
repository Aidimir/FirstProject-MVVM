//
//  product_constructor.swift
//  FirstProject-MVVM
//
//  Created by Айдимир Магомедов on 09.04.2022.
//

import Foundation
import UIKit
import SwiftUI

class ProductConstructor{
    public static func presentData(products : [ProductData]) -> Dictionary<String,Array<ProductCard>>{
        var allGroups = [String]()
        for i in products{
            if i.group != nil{
                if !allGroups.contains(i.group!){
                    allGroups.append(i.group!)
                }
            }
        }
        allGroups.sort()
        allGroups.append("all")
        var dictionary : Dictionary<String,Array<ProductCard>> = [:]
        for i in allGroups{
            dictionary[i] = []
        }
        for (value) in products{
            var uiImages = [UIImage]()
            if value.images != nil{
                for i in value.images!{
                    let url = URL(string: i)
                    let image = try? UIImage(data: Data(contentsOf: url!))
                    uiImages.append(image ?? UIImage(systemName: "photo")!)
                }
            }
            if uiImages.isEmpty{
                uiImages.append(UIImage(systemName: "photo")!)
            }
            let productName = value.name
            let price = value.price
            let destinationPage = UIHostingController(rootView: Page(images: uiImages, mainImg: uiImages[0], productName: productName, description: value.shortDescription, price: price))
            let shortdescription = value.shortDescription
            if value.group != nil{
            dictionary[value.group!]!.append(ProductCard(name: productName, image: uiImages[0], shortdescription: shortdescription, frame: .zero, destinationPage: destinationPage , price: price))
            }
            dictionary["all"]!.append(ProductCard(name: value.name, image: uiImages[0], shortdescription: shortdescription, frame: .zero, destinationPage: destinationPage , price: price))
        }
        return dictionary
    }
}
