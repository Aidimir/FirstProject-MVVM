//
//  cart_controller.swift
//  FirstUIkitProject
//
//  Created by Айдимир Магомедов on 01.03.2022.
//

import Foundation
import UIKit
import StoreKit
import SnapKit

class CartController : UIViewController {
    var test = [SKProduct]()
    var tableView = TableView()
    var dict : [String:[ProductCard]]
    var label : UILabel = {
        var label = UILabel()
        label.font = .boldSystemFont(ofSize: 40)
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    var button = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
        label.font = .boldSystemFont(ofSize: 30)
        label.adjustsFontSizeToFitWidth = true
        SKPaymentQueue.default().add(self)
        fetchProducts()
        setupTableView()
        let data = UserDefaults.standard.array(forKey: "cart") as? [String] ?? []
        allProducts = getAllProudctInOneDict(dict: ProductConstructor.presentData(products: ProductsViewModel.productsArray.value!))
        var allValues = [String]()
        for (key,value) in allProducts{
            allValues.append(value.name)
        }
        for i in data{
            if allValues.contains(i){
                cart.append(allProducts[i]!)
            }
        }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
        button = createButton()
        if cart.isEmpty{
            button.isHidden = true
        }
        else{
            label.text = "К оплате: \(getPriceForAll(productsInCart: cart)) RUB"
            button.isHidden = false
        }
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        button.addSubview(label)
        label.snp.makeConstraints { make in
            make.left.right.top.bottom.width.height.equalTo(button)
        }
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.snp.bottomMargin)
            make.width.equalToSuperview().multipliedBy(0.95)
            make.height.equalToSuperview().multipliedBy(0.1)
        }
        NotificationCenter.default.addObserver(self, selector: #selector(reloadPriceText), name: NSNotification.Name("reloadPrice"), object: nil)
        title = "Cart"
        addBinding()
    }
    @objc func reloadPriceText(notification : NSNotification){
        label.text = "К оплате: \(getPriceForAll(productsInCart: cart)) RUB"
        if getPriceForAll(productsInCart: cart) == 0{
            button.isHidden = true
        }
        else{
            button.isHidden = false
        }
    }
    func createButton() -> UIView{
        let buttonView = UIView()
        let button : UIButton = {
            let button = UIButton()
            button.addTarget(self, action: #selector(onTap), for: .touchUpInside)
            return button
        }()
        buttonView.layer.cornerRadius = 20
        buttonView.layer.masksToBounds = true
        buttonView.backgroundColor = UIColor(red: 0.33, green: 0.33, blue: 0.33, alpha: 0.25)
        buttonView.addSubview(button)
        button.snp.makeConstraints { make in
            make.left.right.top.bottom.width.height.equalTo(buttonView)
        }
        return buttonView
    }
    @objc func onTap(){
        print("You did tap the PAY button")
        let payment = SKPayment(product: test[0])
        SKPaymentQueue.default().add(payment)
    }
    init(dict : [String:[ProductCard]]){
        self.dict = dict
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
func getPriceForAll(productsInCart: Array<ProductCard>) -> Int{
    var summ = 0
    for i in productsInCart{
        summ += i.price
    }
    return summ
}


extension CartController : SKPaymentTransactionObserver, SKProductsRequestDelegate{
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        // none ?
    }
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        print(response.products)
        DispatchQueue.main.async {
            self.test = response.products
        }
    }
    func fetchProducts(){
        let request = SKProductsRequest(productIdentifiers: ["com.bandle.test"])
        request.delegate = self
        request.start()
    }
    func addBinding(){
        ProductsViewModel.productsArray.bind { array in
            DispatchQueue.main.async {
                allProducts = getAllProudctInOneDict(dict: ProductConstructor.presentData(products: array!))
                self.reloadCart()
            }
        }
    }
}

extension CartController{
    func setupTableView(){
        tableView.removeFromParent()
        tableView = TableView()
        addChild(tableView)
        tableView.didMove(toParent: self)
        view.backgroundColor = .black
        view.addSubview(tableView.view)
        tableView.view.snp.makeConstraints { make in
            make.left.right.top.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.8)
        }
    }
    func reloadCart(){
        var allValues = [String]()
        for (key,value) in allProducts{
            allValues.append(value.name)
        }
        let data = UserDefaults.standard.array(forKey: "cart") as? [String] ?? []
        cart = [ProductCard]()
        for i in data{
            if allValues.contains(i){
                cart.append(allProducts[i]!)
            }
        }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
        NotificationCenter.default.post(name: NSNotification.Name("reloadPrice"), object: nil)
    }
}
