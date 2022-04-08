//
//  ViewController.swift
//  FirstProject-MVVM
//
//  Created by Айдимир Магомедов on 08.04.2022.
//

import UIKit
import SnapKit
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let iew = UIView()
        iew.backgroundColor = .blue
        view.addSubview(iew)
        iew.snp.makeConstraints { make in
            make.left.right.top.bottom.width.height.equalToSuperview()
        }
        // Do any additional setup after loading the view.
    }


}

