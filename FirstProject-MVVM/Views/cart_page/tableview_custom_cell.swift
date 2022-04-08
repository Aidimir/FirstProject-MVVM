//
//  tableview_custom_cell.swift
//  FirstUIkitProject
//
//  Created by Айдимир Магомедов on 01.03.2022.
//

import Foundation
import UIKit
import SnapKit

class TableViewCell : UITableViewCell{
    let hstack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.backgroundColor = .black
        return stack
    }()
    let vstack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = stack.frame.height/10
        stack.distribution = .fillEqually
        return stack
    }()
    var imgView : UIImageView = {
        let imgView = UIImageView(image : UIImage())
        imgView.contentMode = .scaleAspectFit
        imgView.tintColor = .white
        return imgView
    }()
    let nameView : UILabel = {
        let nameView = UILabel()
        nameView.font = .boldSystemFont(ofSize: 30)
        nameView.adjustsFontSizeToFitWidth = true
        nameView.textColor = .white
        return nameView
    }()
    let discriptionView : UILabel = {
        let nameView = UILabel()
        nameView.font = .boldSystemFont(ofSize: 25)
        nameView.textColor = .white
        return nameView
    }()
    let priceView : UILabel = {
        let nameView = UILabel()
        nameView.adjustsFontSizeToFitWidth = true
        nameView.font = .boldSystemFont(ofSize: 30)
        nameView.textColor = .white
        return nameView
    }()
    func setup(card : ProductCard){
        imgView.image = card.image
        imgView.backgroundColor = UIColor(red: 0.33, green: 0.33, blue: 0.33, alpha: 0.25)
        nameView.text = card.name
        discriptionView.text = card.shortDescription
        priceView.text = String(card.price) + " RUB"
        hstack.addArrangedSubview(imgView)
        imgView.snp.makeConstraints { make in
            make.left.top.bottom.height.equalTo(hstack)
            make.width.equalTo(hstack).multipliedBy(0.32)
        }
        hstack.addArrangedSubview(vstack)
        vstack.snp.makeConstraints { make in
            make.centerY.height.equalTo(hstack)
            make.left.equalTo(imgView.snp.right)
            make.width.equalTo(hstack).multipliedBy(0.48)
        }
        vstack.addArrangedSubview(nameView)
        vstack.addArrangedSubview(discriptionView)
        hstack.addArrangedSubview(priceView)
        priceView.snp.makeConstraints { make in
            make.right.equalTo(hstack.snp.right)
            make.centerY.equalTo(vstack)
            make.width.equalTo(hstack).multipliedBy(0.2)
            make.height.equalTo(hstack)
        }
        addSubview(hstack)
        hstack.frame = contentView.bounds
    }

}
