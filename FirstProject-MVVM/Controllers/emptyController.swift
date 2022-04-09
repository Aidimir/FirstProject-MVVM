//
//  emptyController.swift
//  FirstProject-MVVM
//
//  Created by Айдимир Магомедов on 09.04.2022.
//

import Foundation
import UIKit
import SnapKit

class EmptyController : UIViewController{
    private let label : UILabel = {
       let label = UILabel()
        label.text = "Товар отсутствует"
        label.font = .boldSystemFont(ofSize: 60)
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
