//
//  productCardsPage.swift
//  FirstUIkitProject
//
//  Created by Айдимир Магомедов on 02.02.2022.
//
import Foundation
import UIKit
import SwiftUI


class ProductsPageController : UIViewController {
    var dict: Dictionary<String, Array<ProductCard>>
    
    let spinner = UIActivityIndicatorView()
    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.startAnimating()
        view.backgroundColor = .white
        view.addSubview(spinner)
        setup(scrollView: spinner, view: view)
        title = "Products"
        var scrollView = CapaciousScrollView(groups: dict)
        addChild(scrollView)
        scrollView.didMove(toParent: self)
        self.view.addSubview(scrollView.view)
        self.setup(scrollView: scrollView.view,view: self.view)
        allProducts = getAllProudctInOneDict(dict: dict)
        self.spinner.stopAnimating()
        self.spinner.removeFromSuperview()
    }
    func setup(scrollView : UIView , view : UIView ){
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    init(dict: Dictionary<String, Array<ProductCard>>){
        self.dict = dict
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
