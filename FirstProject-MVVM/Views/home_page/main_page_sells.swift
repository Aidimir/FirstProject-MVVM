//
//  main_page_sells.swift
//  FirstUIkitProject
//
//  Created by Айдимир Магомедов on 07.02.2022.
//

import Foundation
import UIKit

class MainScrollSells : UIScrollView{
    var sellsArray : Array<UIImageView>
    init(sellsArray : Array<UIImageView>){
        self.sellsArray = sellsArray
        super.init(frame: .zero)
        createScroll(content: sellsArray)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func createScroll(content : Array<UIImageView>){
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = true
        scrollView.backgroundColor = UIColor(red: 0.33, green: 0.33, blue: 0.33, alpha: 1)
        let view = UIView()
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        for i in content{
            i.tintColor = .white
            i.contentMode = .scaleAspectFit
            stackView.addArrangedSubview(i)
        }
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        stackView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        scrollView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.leftAnchor.constraint(equalTo: scrollView.leftAnchor).isActive = true
        view.rightAnchor.constraint(equalTo: scrollView.rightAnchor).isActive = true
        view.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        view.widthAnchor.constraint(equalTo: scrollView.widthAnchor , multiplier: CGFloat(content.count)).isActive = true
        view.heightAnchor.constraint(equalTo: scrollView.heightAnchor).isActive = true
        func setup(){
            scrollView.translatesAutoresizingMaskIntoConstraints = false
            scrollView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
            scrollView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
            scrollView.topAnchor.constraint(equalTo: topAnchor).isActive = true
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
            scrollView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
            scrollView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        }
        addSubview(scrollView)
        setup()
    }
}
