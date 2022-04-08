//
//  inside_collectionView.swift
//  FirstUIkitProject
//
//  Created by Айдимир Магомедов on 22.02.2022.
//

import Foundation
import UIKit
class InsideCollectionView : UICollectionViewController {
    var cards : Array<ProductCard>
    var name : String
    init(frame : CGRect,cards : Array<ProductCard>, name : String){
        self.cards = cards
        self.name = name
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView.backgroundColor = .black
        collectionView.register(CustomInsideCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(NavigationCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        collectionView.collectionViewLayout = layout
    }
}
extension InsideCollectionView : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2.3, height: collectionView.frame.height/2.5)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomInsideCell
        var sortedCards = cards.sorted{
            $0.name < $1.name
        }
        cell.setup(view: sortedCards[indexPath.item])
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header", for: indexPath) as! NavigationCell
        cell.setup(name: name)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height*0.1)
    }
}

