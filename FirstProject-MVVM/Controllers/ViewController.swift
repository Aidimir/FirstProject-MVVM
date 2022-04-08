import UIKit
import Kingfisher
import SnapKit
class ViewController : UITabBarController, ProductsPresenterDelegate {
    func presentProducts(dict: Dictionary<String, Array<ProductCard>>, allPoints : [Point]) {
        spinner.removeFromSuperview()
        let home = HomeViewController(itemsToShow: getNewInstances(array: getRandomPos(dict: dict)))
        let productsPage = ProductsPageController(dict: dict)
        let mapPage = MapPageController()
        mapPage.allPoints = allPoints
        let cartPage = CartController(dict: dict)
        let pages = [home,productsPage,mapPage,cartPage]
        self.setViewControllers(pages, animated: true)
        self.selectedViewController = pages[0]
        tabBar.backgroundColor = .gray
    }
    func errorHandler() {
        spinner.removeFromSuperview()
        print("error handler in action")
        let scroll = UIScrollView()
        let errorImvView : UIImageView = {
            let imgView = UIImageView(image: UIImage(systemName: "wifi.slash")!)
            imgView.tintColor = .white
            imgView.contentMode = .scaleAspectFit
            return imgView
        }()
        let label : UILabel = {
            let label = UILabel()
            label.text = "Нет подключения к сети"
            label.font = .boldSystemFont(ofSize: 40)
            label.textColor = .white
            label.textAlignment = .center
            label.adjustsFontSizeToFitWidth = true
            return label
        }()
        let refreshControl : UIRefreshControl = {
            let control = UIRefreshControl()
            control.addTarget(self, action: #selector(reloadAll(sender:)), for: .valueChanged)
            control.tintColor = .white
            return control
        }()
        scroll.addSubview(errorImvView)
        errorImvView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalToSuperview().dividedBy(3)
        }
        scroll.addSubview(label)
        label.snp.makeConstraints { make in
            make.left.right.width.equalToSuperview()
            make.bottom.equalTo(errorImvView.snp.top)
        }
        scroll.refreshControl = refreshControl
        scroll.backgroundColor = .black
        view.addSubview(scroll)
        scroll.snp.makeConstraints { make in
            make.left.right.top.bottom.width.height.equalToSuperview()
        }
    }
    private let spinner = UIActivityIndicatorView()
    private let presenter = ProductsPresenter()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(spinner)
        spinner.tintColor = .white
        spinner.startAnimating()
        spinner.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        presenter.setDelegate(delegate: self)
        presenter.fetchData()
    }
    @objc func reloadAll(sender : UIRefreshControl){
        view.subviews.forEach({ $0.removeFromSuperview() })
        presenter.fetchData()
    }
    func getRandomPos(dict : [String:[ProductCard]]) -> [ProductCard]{
        var res = [ProductCard]()
        for i in 0...3{
            var randomEl = dict["all"]!.randomElement()
            if res.contains(randomEl!) == false{
                res.append(randomEl!)
            }
        }
        return res
    }
    func getNewInstances(array : [ProductCard]) ->[ProductCard]{
        var res = [ProductCard]()
        for i in array{
            res.append(ProductCard(name: i.name, image: i.image, shortdescription: i.shortDescription, frame: i.frame, destinationPage: i.destinationPage, price: i.price))
        }
        return res
    }
}



