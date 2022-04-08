////
////  copy.swift
////  FirstUIkitProject
////
////  Created by Айдимир Магомедов on 21.02.2022.
////
//
//import Foundation
//import UIKit
//import SwiftUI
//
//var UIController = UIHostingController(rootView: Page(images: [Image(systemName: "leaf.fill"),Image(systemName: "leaf"),Image(systemName: "leaf.fill")], mainImage: Image(systemName: "leaf"), productName: "Leaf", description: "IT'S A REGULAR LEAF ! THERE IS A LOT LEAFS LIKE THAT , BUT THIS IS MINE ! WITHOUT ME MI LEAF IS NOTHING, WITHOUT LEAF NOTHING IS ME !IT'S A REGULAR LEAF ! THERE IS A LOT LEAFS LIKE THAT , BUT THIS IS MINE ! WITHOUT ME MI LEAF IS NOTHING, WITHOUT LEAF NOTHING IS ME !IT'S A REGULAR LEAF ! THERE IS A LOT LEAFS LIKE THAT , BUT THIS IS MINE ! WITHOUT ME MI LEAF IS NOTHING, WITHOUT LEAF NOTHING IS ME !", price: 1))
//
//class productCardsPageController : UIViewController {
//    let collectionView : UICollectionView = {
//    let layout = UICollectionViewFlowLayout()
//    let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        collection.register(CustomCell.self, forCellWithReuseIdentifier: "cell")
//    return collection
//    }()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        title = "Products"
//        view.addSubview(collectionView)
//        collectionView.delegate = self
//        collectionView.dataSource = self
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
//        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
//        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
//        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
//        collectionView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
//        collectionView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
//    }
//}
//
//extension productCardsPageController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: collectionView.frame.width/2.1, height: collectionView.frame.height/2.5)
//    }
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return cards.count
//    }
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCell
//            
//        cell.setup(name: cards[indexPath.item].name, discription: cards[indexPath.item].shortDescription, image: cards[indexPath.item].image)
//        return cell
//    }
//}
//
//class CustomCell : UICollectionViewCell {
//    func setup(name : String, discription : String, image : UIImage){
//        let bg = ProductCard(name: name, image: image, shortdescription: discription, frame: .zero, destinationPage: UIController)
//        contentView.addSubview(bg)
//        bg.translatesAutoresizingMaskIntoConstraints = false
//        bg.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
//        bg.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
//        bg.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
//        bg.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
//    }
//    override init(frame: CGRect){
//        super.init(frame: .zero)
//    }
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//    }
//}
//
