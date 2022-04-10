import Foundation
import Kingfisher
import UIKit
import SnapKit

var imgArray = [UIImageView(image:  UIImage(systemName: "photo.fill")!),UIImageView(image:  UIImage(systemName: "photo")!),UIImageView(image:  UIImage(systemName: "photo")!),UIImageView(image:  UIImage(systemName: "photo")!),UIImageView(image:  UIImage(systemName: "photo")!)]
class HomeViewController : UIViewController {
    private var itemsToShow : [ProductCard]
    private var collectionView : UICollectionView!
    private let scroll = UIScrollView()
    private let mainScrolls = MainScrollSells(sellsArray: imgArray)
    private let refreshControl : UIRefreshControl = {
        let control = UIRefreshControl()
        control.addTarget(self, action: #selector(update), for: .valueChanged)
        control.tintColor = .white
        return control
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        let imgView = UIImageView()
        imgView.backgroundColor = UIColor(red: 0.33, green: 0.33, blue: 0.5, alpha: 1)
        imgView.kf.setImage(with: URL(string: "https://w0.peakpx.com/wallpaper/51/52/HD-wallpaper-apex-legend-crypto-neon.jpg"))
        imgView.contentMode = .scaleAspectFill
        view.backgroundColor = .white
        view.addSubview(imgView)
        imgView.snp.makeConstraints { make in
            make.center.width.height.equalToSuperview()
        }
        title = "Home"
        mainScrolls.backgroundColor = .white
        scroll.addSubview(mainScrolls)
        mainScrolls.snp.makeConstraints { make in
            make.left.right.width.equalTo(scroll)
            make.height.equalTo(scroll).multipliedBy(0.2)
            make.top.equalTo(scroll)
        }
        setupCollection()
        addBindings()
        view.addSubview(scroll)
        scroll.snp.makeConstraints { make in
            make.left.right.bottom.width.height.equalToSuperview()
            make.top.equalTo(view.snp.topMargin)
        }
    }
    init(itemsToShow : [ProductCard]){
        self.itemsToShow = itemsToShow
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupCollection(){
        scroll.refreshControl = refreshControl
        collectionView = HomeCollection(itemsToShow: itemsToShow)
        collectionView.backgroundColor = .black
        scroll.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.centerX.equalTo(scroll)
            make.width.equalTo(scroll).multipliedBy(0.98)
            make.top.equalTo(mainScrolls.snp.bottom).offset(view.frame.size.height*0.02)
            make.height.equalTo(scroll).dividedBy(2.5)
        }
    }
}
extension HomeViewController{
    func addBindings(){
        ProductsViewModel.productsArray.bind { array in
            DispatchQueue.main.async {
                self.refreshControl.endRefreshing()
                self.collectionView.removeFromSuperview()
                self.itemsToShow = getNewInstances(array: getRandomPos(dict: ProductConstructor.presentData(products: array!)))
                self.setupCollection()
            }
        }
    }
    @objc func update(){
        NotificationCenter.default.post(name: NSNotification.Name("updateAll"), object: nil)
    }
}
