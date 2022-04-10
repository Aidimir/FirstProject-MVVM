import UIKit
import Kingfisher
import SnapKit
import BLTNBoard

class ViewController : UIViewController {
    private let spinner = UIActivityIndicatorView()
    private var viewModel = ProductsViewModel()
    private var boardManager : BLTNItemManager?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(spinner)
        view.backgroundColor = .black
        spinner.tintColor = .white
        spinner.startAnimating()
        spinner.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        viewModel.setDelegate(delegate: self)
        updateValue()
        NotificationCenter.default.addObserver(self, selector: #selector(showCard), name: NSNotification.Name("showCard"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateValue), name: NSNotification.Name("updateAll"), object: nil)
    }
    @objc func reloadAll(sender : UIRefreshControl){
        view.subviews.forEach({ $0 != spinner ? $0.removeFromSuperview() : nil})
        updateValue()
    }
    @objc func updateValue(){
        DispatchQueue.main.async {
        ProductsViewModel.updateValue()
        }
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
            control.addTarget(self, action: #selector(updateValue), for: .valueChanged)
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

extension ViewController {
    @objc func showCard(notification : NSNotification){
        boardManager = {
           let item = BLTNPageItem(title: "Что то пошло не так...")
            item.image = UIImage(named: "errorImage")
            item.descriptionText = notification.object as? String ?? ""
            item.actionButtonTitle = "Попробовать подключиться снова"
            item.actionHandler = { [weak self] _ in
                self?.updateValue()
            }
            return BLTNItemManager(rootItem: item)
        }()
        boardManager!.backgroundColor = UIColor(red: 0.46, green: 0.46, blue: 0.46, alpha: 1)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.boardManager!.showBulletin(above: self)
        }
    }
}
