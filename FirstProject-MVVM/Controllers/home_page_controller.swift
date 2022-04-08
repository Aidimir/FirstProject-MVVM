//
//  HomeViewController.swift
//  FirstUIkitProject
//
//  Created by Айдимир Магомедов on 02.02.2022.
//

import Foundation
import Kingfisher
import UIKit
import SnapKit

var imgArray = [UIImageView(image:  UIImage(systemName: "photo.fill")!),UIImageView(image:  UIImage(systemName: "photo")!),UIImageView(image:  UIImage(systemName: "photo")!),UIImageView(image:  UIImage(systemName: "photo")!),UIImageView(image:  UIImage(systemName: "photo")!)]
class HomeViewController : UIViewController {
    private let itemsToShow : [ProductCard]
    override func viewDidLoad() {
        super.viewDidLoad()
        let collectionView : UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
            let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
            collection.backgroundColor = UIColor.clear
            collection.register(CustomHomeCell.self, forCellWithReuseIdentifier: "anotherCell")
            collection.register(HomeHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "MainPageHeader")
            collection.delegate = self
            collection.dataSource = self
            collection.layer.cornerRadius = 25
            collection.layer.masksToBounds = true
            return collection
        }()
        collectionView.backgroundColor = .black
        let imgView = UIImageView()
        imgView.kf.setImage(with: URL(string: "https://w0.peakpx.com/wallpaper/51/52/HD-wallpaper-apex-legend-crypto-neon.jpg"))
        imgView.contentMode = .scaleAspectFill
        view.backgroundColor = .white
        view.addSubview(imgView)
        imgView.snp.makeConstraints { make in
            make.center.width.height.equalToSuperview()
        }
        title = "Home"
        let mainScrolls = MainScrollSells(sellsArray: imgArray)
        mainScrolls.backgroundColor = .white
        view.addSubview(mainScrolls)
        mainScrolls.snp.makeConstraints { make in
            make.left.right.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.2)
            make.top.equalTo(view.snp.topMargin)
        }
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.98)
            make.top.equalTo(mainScrolls.snp.bottom).offset(view.frame.size.height*0.02)
            make.height.equalToSuperview().dividedBy(2.5)
        }
    }
    init(itemsToShow : [ProductCard]){
        self.itemsToShow = itemsToShow
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension HomeViewController : UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        itemsToShow.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "anotherCell", for: indexPath) as! CustomHomeCell
        cell.setup(view: itemsToShow[indexPath.item])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width/2.3, height: self.view.frame.height/3.5)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height*0.1)
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "MainPageHeader", for: indexPath) as! HomeHeader
        cell.setup(name: "может быть интересно")
        return cell
    }
}
