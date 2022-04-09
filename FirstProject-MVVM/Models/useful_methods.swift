//
//  shit.swift
//  FirstUIkitProject
//
//  Created by Айдимир Магомедов on 23.02.2022.
//

import Foundation
import UIKit
import SwiftUI
func getAllValuesInOneArray(dict : Dictionary<String,Array<ProductCard>>)-> Array<ProductCard>{
    var res = [ProductCard]()
    for (key,value) in dict{
        for i in value{
            res.append(i)
        }
    }
    return res 
}
func getAllProudctInOneDict(dict : Dictionary<String,Array<ProductCard>>) -> Dictionary<String,ProductCard>{
    var res = [String:ProductCard]()
    var all = dict["all"]
    for (key,value) in dict{
        for i in value{
            res[i.name] = i
        }
    }
    return res
}

func getAllNames(array : [ProductCard])-> [String]{
    var res = [String]()
    for i in array{
        res.append(i.name)
    }
    return res
}
func convertToProductData(dict : [String : [String : Any]]) -> [ProductData]{
    var res = [ProductData]()
    for (_,value) in dict{
        var images = [String]()
        if value["images"] != nil{
            for i in value["images"] as! Array<String>{
                images.append(i)
            }
        }
        let productName = value["name"] as? String
        let price = value["price"] as? Int
        let shortdescription = value["description"] as? String
        let group = value["group"] as? String
        res.append(ProductData(name: productName! , images: images, shortDescription: shortdescription ?? "нет информации", price: price ?? 0, group: group))
    }
    return res
}
func getNewInstances(array : [ProductCard]) ->[ProductCard]{
    var res = [ProductCard]()
    for i in array{
        res.append(ProductCard(name: i.name, image: i.image, shortdescription: i.shortDescription, frame: i.frame, destinationPage: i.destinationPage ?? EmptyController(), price: i.price))
    }
    return res
}
func getRandomPos(dict : [String:[ProductCard]]) -> [ProductCard]{
    var res = [ProductCard]()
    for _ in 0...3{
        var randomEl = dict["all"]!.randomElement()
        if res.contains(randomEl!) == false{
            res.append(randomEl!)
        }
    }
    return res
}
