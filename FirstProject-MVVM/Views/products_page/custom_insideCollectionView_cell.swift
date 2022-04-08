//
//  custom_collectionView_cell.swift
//  FirstUIkitProject
//
//  Created by Айдимир Магомедов on 22.02.2022.
//

import Foundation
import UIKit

class CustomInsideCell : UICollectionViewCell {
    func setup(view : ProductCard){
        let bg = view
        bg.frame = contentView.frame
        contentView.addSubview(bg)
    }
}


