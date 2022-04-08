//
//  tableView_header.swift
//  FirstUIkitProject
//
//  Created by Айдимир Магомедов on 04.03.2022.
//

import Foundation
import UIKit

class Header : UITableViewHeaderFooterView{
    var headerName : UILabel = {
        let headerName = UILabel()
        headerName.font = .boldSystemFont(ofSize: 40)
        headerName.textColor = .white
        return headerName
    }()
    func setup(headerText : String) -> UIView{
        headerName.text = headerText
        headerName.frame = contentView.bounds
        return headerName
    }
}
