//
//  navigation_collectionCell.swift
//  FirstUIkitProject
//
//  Created by Айдимир Магомедов on 27.02.2022.
//

import Foundation
import UIKit

class NavigationCell : UICollectionReusableView{
    func setup(name: String){
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 60)
        label.text = name
        label.textColor = .white
        addSubview(label)
        label.frame = bounds
    }
}
