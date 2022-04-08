//
//  map_bottom_button.swift
//  FirstUIkitProject
//
//  Created by Айдимир Магомедов on 16.03.2022.
//

import Foundation
import UIKit

class BottomMapButton : UIView{
    func createButton() -> UIButton{
        let imageView = UIImageView(image: UIImage(systemName: "chevron.compact.up")!)
        imageView.contentMode = .scaleAspectFit
        let button = UIButton()
        button.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerXAnchor.constraint(equalTo: button.centerXAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: button.bottomAnchor).isActive = true
        imageView.widthAnchor.constraint(equalTo: button.widthAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: button.heightAnchor).isActive = true
        return button
    }
}
