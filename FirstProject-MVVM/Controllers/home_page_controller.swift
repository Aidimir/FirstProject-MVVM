import Foundation
import Kingfisher
import UIKit
import SnapKit

var imgArray = [UIImageView(image:  UIImage(systemName: "photo.fill")!),UIImageView(image:  UIImage(systemName: "photo")!),UIImageView(image:  UIImage(systemName: "photo")!),UIImageView(image:  UIImage(systemName: "photo")!),UIImageView(image:  UIImage(systemName: "photo")!)]
class HomeViewController : UIViewController {
    private var itemsToShow : [ProductCard]
    private var collectionView : UICollectionView!
    private let mainScrolls = MainScrollSells(sellsArray: imgArray)
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView = HomeCollection(itemsToShow: itemsToShow)
        let imgView = UIImageView()
        imgView.kf.setImage(with: URL(string: "https://w0.peakpx.com/wallpaper/51/52/HD-wallpaper-apex-legend-crypto-neon.jpg"))
        imgView.contentMode = .scaleAspectFill
        view.backgroundColor = .white
        view.addSubview(imgView)
        imgView.snp.makeConstraints { make in
            make.center.width.height.equalToSuperview()
        }
        title = "Home"
        mainScrolls.backgroundColor = .white
        view.addSubview(mainScrolls)
        mainScrolls.snp.makeConstraints { make in
            make.left.right.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.2)
            make.top.equalTo(view.snp.topMargin)
        }
        collectionView.backgroundColor = .black
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.98)
            make.top.equalTo(mainScrolls.snp.bottom).offset(view.frame.size.height*0.02)
            make.height.equalToSuperview().dividedBy(2.5)
        }
        addBindings()
    }
    init(itemsToShow : [ProductCard]){
        self.itemsToShow = itemsToShow
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension HomeViewController{
    func addBindings(){
        ViewController.productsArray.bind { array in
            self.collectionView.removeFromSuperview()
            self.itemsToShow = getNewInstances(array: getRandomPos(dict: ProductConstructor.presentData(products: array!)))
            self.collectionView = HomeCollection(itemsToShow: self.itemsToShow)
            self.collectionView.backgroundColor = .black
            self.view.addSubview(self.collectionView)
            self.collectionView.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.width.equalToSuperview().multipliedBy(0.98)
                make.top.equalTo(self.mainScrolls.snp.bottom).offset(self.view.frame.size.height*0.02)
                make.height.equalToSuperview().dividedBy(2.5)
            }
        }
    }
}

