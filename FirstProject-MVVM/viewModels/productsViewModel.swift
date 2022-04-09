//
//  productsViewModel.swift
//  FirstProject-MVVM
//
//  Created by Айдимир Магомедов on 08.04.2022.
//

import Foundation

protocol ProductsViewModelDelegate{
    func presentProducts(array : [ProductData])
    func errorHandler()
}

class ProductsViewModel {
    var products : Observable<[ProductData]?> = Observable(value: nil)
    var mapPoints : Observable<[Point]?> = Observable(value: nil)
    var viewModelDelegate : ProductsViewModelDelegate?
    func updateValue(){
        FirebaseData().getData { [weak self] dict in
            self?.products.value = self?.convertToProductData(dict: dict!)
            FirebaseData().getPoints { points in
                self?.mapPoints.value = points
            }
        }
    }
    private func convertToProductData(dict : [String : [String : Any]]) -> [ProductData]{
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
    init(){
        updateValue()
    }
}
