//
//  homePage_header.swift
//  FirstUIkitProject
//
//  Created by Айдимир Магомедов on 31.03.2022.
//

import Foundation
import UIKit

class HomeHeader : UICollectionReusableView{
    func setup(name: String){
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 60)
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        label.text = name
        addSubview(label)
        label.frame = bounds
    }
}
