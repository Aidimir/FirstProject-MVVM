//
//  product_card.swift
//  FirstUIkitProject
//
//  Created by Айдимир Магомедов on 22.01.2022.
//

import Foundation
import UIKit
import SwiftUI

class ProductCard : UIView{
    var screenWidth = UIScreen.main.bounds.width
    var screenHeight = UIScreen.main.bounds.height
    var name : String
    var image : UIImage
    var shortDescription : String
    var destinationPage : UIViewController
    var price : Int
    var view = UIView()
    init(name : String, image : UIImage, shortdescription : String,frame : CGRect, destinationPage : UIViewController , price : Int){
        self.name = name
        self.image = image
        self.shortDescription = shortdescription
        self.destinationPage = destinationPage
        self.price = price
        super.init(frame: .zero)
        setup(image: image, name: name, shortDescription: shortDescription, destinationPage: destinationPage , price : price)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setup(image : UIImage, name : String, shortDescription : String, destinationPage : UIViewController , price : Int){
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        imageView.backgroundColor = UIColor(red: 0.33, green: 0.33, blue: 0.33, alpha: 0.25)
        imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true
        let nameView = UILabel()
        nameView.text = name
        nameView.font = UIFont.boldSystemFont(ofSize: 30)
        nameView.adjustsFontSizeToFitWidth = true
        nameView.textColor = .white
        let priceView : UILabel = {
            let priceView = UILabel()
            priceView.text = "\(price) RUB"
            priceView.textColor = .white
            priceView.adjustsFontSizeToFitWidth = true
            priceView.font = .boldSystemFont(ofSize: 35)
            return priceView
        }()
        let descriptionView = UILabel()
        descriptionView.text = shortDescription
        descriptionView.font = UIFont.systemFont(ofSize: 25)
        descriptionView.textColor = .white
        let stack = UIStackView()
        stack.spacing = 5
        stack.axis = .vertical
        stack.distribution = .fillEqually
        let stack1 = UIStackView(arrangedSubviews: [priceView,nameView,descriptionView])
        stack1.axis = .vertical
        stack1.spacing = .zero
        stack1.distribution = .fillProportionally
        stack.addArrangedSubview(imageView)
        stack.addArrangedSubview(stack1)
        addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stack.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        stack.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        stack.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        let button = createButton(destinationPage: destinationPage)
        addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.topAnchor.constraint(equalTo: stack.topAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: stack.bottomAnchor).isActive = true
        button.leftAnchor.constraint(equalTo: stack.leftAnchor).isActive = true
        button.rightAnchor.constraint(equalTo: stack.rightAnchor).isActive = true
        
    }
    func createButton(destinationPage : UIViewController)-> UIButton{
        let button = UIButton()
        button.addTarget(self, action: #selector(onTap) , for: .touchUpInside)
        return button
    }
    @objc func onTap(){
        let controller = getCurrentViewController()
        controller?.present(destinationPage, animated: true, completion: nil)
    }
    func attachTo(what : UIView, toWhat : UIView , multiplier : Double){
        what.translatesAutoresizingMaskIntoConstraints = false
        what.leftAnchor.constraint(equalTo: toWhat.leftAnchor).isActive = true
        what.topAnchor.constraint(equalTo: toWhat.bottomAnchor).isActive = true
        what.widthAnchor.constraint(equalTo: toWhat.widthAnchor).isActive = true
        what.heightAnchor.constraint(equalTo: heightAnchor, multiplier: multiplier).isActive = true
    }
}

extension UIView
{
    func copyView<T: UIView>() -> T {
        return NSKeyedUnarchiver.unarchiveObject(with: NSKeyedArchiver.archivedData(withRootObject: self)) as! T
    }
}

func getCurrentViewController() -> UIViewController? {
    
    if let rootController = UIApplication.shared.keyWindow?.rootViewController {
        var currentController: UIViewController! = rootController
        while( currentController.presentedViewController != nil ) {
            currentController = currentController.presentedViewController
        }
        return currentController
    }
    return nil
    
}
