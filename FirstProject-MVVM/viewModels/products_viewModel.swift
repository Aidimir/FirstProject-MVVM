//
//  products_viewModel.swift
//  FirstProject-MVVM
//
//  Created by Айдимир Магомедов on 10.04.2022.
//

import Foundation
import YandexMapsMobile

protocol ProductsPresenterDelegate{
    func presentProducts(array : [ProductData] , allPoints : [Point])
    func errorHandler()
}

typealias delegateType = ProductsPresenterDelegate & UIViewController

class ProductsViewModel{
    public static var productsArray : Observable<[ProductData]?> = Observable(value: nil)
    public static var allPoints : Observable<[Point]?> = Observable(value: nil)
    static var delegate : delegateType?
    func setDelegate(delegate : delegateType){
        ProductsViewModel.delegate = delegate
    }
    static func updateValue(){
        FirebaseData().getData { dict in
            if dict != nil{
                let array = convertToProductData(dict: dict!)
                FirebaseData().getPoints { p in
                    if p.isEmpty == false {
                        ProductsViewModel.allPoints.value = p
                    }
                    else{
                        ProductsViewModel.allPoints.value = [Point(name: "нет информации", description: "нет информаци", worktime: "нет информации", pointOnMap: YMKPoint(latitude: 56.84173039415533, longitude: 60.65174074759386))]
                    }
                    if ProductsViewModel.productsArray.value == nil{
                        ProductsViewModel.productsArray.value = array
                        ProductsViewModel.delegate?.presentProducts(array: ProductsViewModel.productsArray.value!, allPoints: ProductsViewModel.allPoints.value!)
                    }
                    else{
                        ProductsViewModel.productsArray.value = array
                    }
                }
            }
            else{
                // some cache stuff will be here
                ProductsViewModel.productsArray.value = nil
                self.delegate?.errorHandler()
                print("is nil")
            }
        }
    }
}
