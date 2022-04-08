//
//  bottom_tableView_cell.swift
//  FirstUIkitProject
//
//  Created by Айдимир Магомедов on 11.03.2022.
//

import Foundation
import UIKit
import YandexMapsMobile

class BottomTableCell : UITableViewCell{
    func setup(point : Point){
        let vStack : UIStackView = {
            let stack = UIStackView()
            stack.distribution = .fillEqually
            stack.axis = .vertical
            return stack
        }()
        let nameView = UILabel()
        nameView.text = point.name
        nameView.font = .boldSystemFont(ofSize: 30)
        let descriptionView = UILabel()
        descriptionView.text = point.description
        descriptionView.font = .boldSystemFont(ofSize: 20)
        let workTimeView = UILabel()
        workTimeView.text = point.worktime
        workTimeView.font = .boldSystemFont(ofSize: 25)
        vStack.addArrangedSubview(nameView)
        vStack.addArrangedSubview(workTimeView)
        vStack.addArrangedSubview(descriptionView)
        addSubview(vStack)
        vStack.frame = contentView.bounds
    }
}
