//
//  scrollview.swift
//  FirstUIkitProject
//
//  Created by Айдимир Магомедов on 25.02.2022.
//

import Foundation
import UIKit

class CapaciousScrollView : UIViewController,UIScrollViewDelegate{
    var groups : Dictionary<String,Array<ProductCard>>
    let massiveView : UIView = UIView()
    let scrollView : UIScrollView = UIScrollView()
    let stackView : UIStackView = {
        let stack = UIStackView(frame: .zero)
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        return stack
    }()
    func setup(){
        scrollView.backgroundColor = .black
        let a = createCollections(groups: groups)
        for i in a{
            i.view.frame = view.bounds
            addChild(i)
            i.didMove(toParent: self)
            stackView.addArrangedSubview(i.view)
        }
        scrollView.isPagingEnabled = true
        massiveView.addSubview(stackView)
        attachTo(what: stackView, toWhat: massiveView,multiplyPages: 1)
        scrollView.addSubview(massiveView)
        attachTo(what: massiveView, toWhat: scrollView, multiplyPages: groups.count)
        view.addSubview(scrollView)
        attachTo(what: scrollView, toWhat: view, multiplyPages: 1)
    }
    func attachTo(what : UIView, toWhat : UIView, multiplyPages : Int){
        what.translatesAutoresizingMaskIntoConstraints = false
        what.topAnchor.constraint(equalTo: toWhat.topAnchor).isActive = true
        what.bottomAnchor.constraint(equalTo: toWhat.bottomAnchor).isActive = true
        what.leftAnchor.constraint(equalTo: toWhat.leftAnchor).isActive = true
        what.rightAnchor.constraint(equalTo: toWhat.rightAnchor).isActive = true
        what.heightAnchor.constraint(equalTo: toWhat.heightAnchor).isActive = true
        what.widthAnchor.constraint(equalTo: toWhat.widthAnchor,multiplier: CGFloat(multiplyPages)).isActive = true
    }
    init(groups : Dictionary<String,Array<ProductCard>>){
        self.groups = groups
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}
func createCollections(groups : Dictionary<String,Array<ProductCard>>)-> Array<InsideCollectionView>{
    var collections = [InsideCollectionView]()
    for (key,value) in groups.sorted{$0.0<$1.0}{
        var i = InsideCollectionView(frame: .zero, cards: value, name: key)
        collections.append(i)
        print(key,value.count)
    }
    return collections
}
