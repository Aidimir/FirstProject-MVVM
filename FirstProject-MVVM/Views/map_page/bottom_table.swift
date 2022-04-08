//
//  bottom_table.swift
//  FirstUIkitProject
//
//  Created by Айдимир Магомедов on 13.03.2022.
//

import Foundation
import UIKit

class BottomTable : UITableView , UITableViewDelegate, UITableViewDataSource{
    let tableView : UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        points.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! BottomTableCell
        cell.setup(point: points[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return frame.height/5
    }
    init(frame : CGRect){
        super.init(frame: .zero, style: .grouped)
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: NSNotification.Name("reloadBottomSheet"), object: nil)
        setup()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NotificationCenter.default.post(name: NSNotification.Name("moveMap"), object: points[indexPath.row].pointOnMap)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc func reload(notification : NSNotification){
        tableView.reloadData()
    }
    func setup(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(BottomTableCell.self, forCellReuseIdentifier: "cell")
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([tableView.centerXAnchor.constraint(equalTo: centerXAnchor),
                                     tableView.centerYAnchor.constraint(equalTo: centerYAnchor),
                                     tableView.heightAnchor.constraint(equalTo: heightAnchor),
                                     tableView.widthAnchor.constraint(equalTo: widthAnchor)])
    }
}
