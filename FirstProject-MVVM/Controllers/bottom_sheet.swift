//
//  bottom_sheet.swift
//  FirstUIkitProject
//
//  Created by Айдимир Магомедов on 15.03.2022.
//

import Foundation
import UIKit

class BottomSheet : UIViewController{
    override func viewDidLoad() {
        var a = BottomTable(frame: .zero)
        view.addSubview(a)
        a.translatesAutoresizingMaskIntoConstraints = false
        a.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        a.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        a.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        a.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
}
