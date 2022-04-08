//
//  shit.swift
//  FirstUIkitProject
//
//  Created by Айдимир Магомедов on 23.02.2022.
//

import Foundation
import UIKit
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
