import UIKit
import Kingfisher
import SnapKit
class ViewController : UIViewController {
    private let spinner = UIActivityIndicatorView()
    public static var productsArray : Observable<[ProductData]?> = Observable(value: nil)
    let button : UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(updateValue), for: .touchUpInside)
        button.backgroundColor = .red
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(spinner)
        view.backgroundColor = .black
        spinner.tintColor = .white
        spinner.startAnimating()
        spinner.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        fetchData()
    }
    @objc func reloadAll(sender : UIRefreshControl){
        view.subviews.forEach({ $0 != spinner ? $0.removeFromSuperview() : nil})
        fetchData()
    }
    func fetchData(){
        FirebaseData().getData { dict in
            if dict != nil{
                FirebaseData().getPoints { p in
                    let array = convertToProductData(dict: dict!)
                    if ViewController.productsArray.value == nil{
                        ViewController.productsArray.value = array
                        self.presentProducts(array: array, allPoints: p)
                    }
                    ViewController.productsArray.value = array
                }
            }
            else{
                // some cache stuff will be here
                self.errorHandler()
            }
        }
    }
    @objc func updateValue(){
        FirebaseData().getData { dict in
            if dict != nil{
                let array = convertToProductData(dict: dict!)
                FirebaseData().getPoints { p in
                    ViewController.productsArray.value = array
                }
                print(dict)
            }
            else{
                // some cache stuff will be here
                ViewController.productsArray.value = nil
                print("is nil")
            }
        }
        print("update button tapped")
    }
}

extension ViewController : ProductsPresenterDelegate{
    func presentProducts(array : [ProductData] , allPoints : [Point]) {
        spinner.removeFromSuperview()
        let dict = ProductConstructor.presentData(products: array)
        let home = HomeViewController(itemsToShow: getNewInstances(array: getRandomPos(dict: dict)))
        let productsPage = ProductsPageController(dict: dict)
        let mapPage = MapPageController()
        mapPage.allPoints = allPoints
        let cartPage = CartController(dict: dict)
        let pages = [home,productsPage,mapPage,cartPage]
        let tabBar = UITabBarController()
        tabBar.setViewControllers(pages, animated: true)
        tabBar.selectedViewController = pages[0]
        tabBar.tabBar.backgroundColor = .gray
        addChild(tabBar)
        didMove(toParent: self)
        view.addSubview(tabBar.view)
        tabBar.view.snp.makeConstraints { make in
            make.bottom.left.right.width.equalToSuperview()
            make.height.equalToSuperview()
        }
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.centerX.topMargin.width.equalToSuperview()
            make.height.equalToSuperview().dividedBy(10)
        }
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
        scroll.refreshControl = refreshControl
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
        scroll.backgroundColor = .black
        view.addSubview(scroll)
        scroll.snp.makeConstraints { make in
            make.left.right.top.bottom.width.height.equalToSuperview()
        }
    }
}
