//
//  collection_view.swift
//  FirstUIkitProject
//
//  Created by Айдимир Магомедов on 22.02.2022.
//

import Foundation
import UIKit

class CapaciousCollectionView : UICollectionView, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{

    
    var groups : Dictionary<String,Array<ProductCard>>
    var arrays : Array<Array<ProductCard>>
    
    let collection : UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
            collection.isPagingEnabled = true
            collection.register(CustomCell.self, forCellWithReuseIdentifier: "Custom cell")
            return collection
        }()
    func setup(collectionView : UICollectionView){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        collectionView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        arrays.count
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    func indexTitles(for collectionView: UICollectionView) -> [String]? {
        return ["apps","Snacks","ALL"]
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Custom cell", for: indexPath) as! CustomCell
        if collectionView == collection{
        cell.setup(cards: arrays[indexPath.row])
        return cell
        }
        else{
        return cell
    }
    }
    
    init(frame : CGRect,groups : Dictionary<String,Array<ProductCard>>, arrays : Array<Array<ProductCard>>){
        self.groups = groups
        self.arrays = arrays
        super.init(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        addSubview(collection)
        setup(collectionView: collection)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

