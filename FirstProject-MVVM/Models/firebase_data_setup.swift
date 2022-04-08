//
//  product_page_data.swift
//  FirstUIkitProject
//
//  Created by Айдимир Магомедов on 04.02.2022.
//

import Foundation

class DataSetup{
    var names = FirebaseData().getNames()
    func printNames(){
        print(names)
    }
}
