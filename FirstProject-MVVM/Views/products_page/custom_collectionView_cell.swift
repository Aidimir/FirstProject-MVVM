//
//  custom_collectionView_cell.swift
//  FirstUIkitProject
//
//  Created by Айдимир Магомедов on 22.02.2022.
//

import Foundation
import UIKit

class CustomCell: UICollectionViewCell{
    func setup(cards : Array<ProductCard>){
        let cell = InsideCollectionView(frame: .zero, cards: cards, name: "")
        cell.frame = contentView.bounds
        contentView.addSubview(cell)
    }
}
