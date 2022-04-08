//
//  homePage_header.swift
//  FirstUIkitProject
//
//  Created by Айдимир Магомедов on 30.03.2022.
//

import Foundation
import UIKit

class CustomHomeCell : UICollectionViewCell {
    func setup(view : ProductCard){
        let bg = view
        bg.frame = contentView.frame
        contentView.addSubview(bg)
    }
}

