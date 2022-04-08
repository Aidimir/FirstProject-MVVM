//
//  bottom_sheet.swift
//  FirstUIkitProject
//
//  Created by Айдимир Магомедов on 11.03.2022.
//

import Foundation
import UIKit
import YandexMapsMobile

class BottomTable : UITableView, UITableViewDataSource,UITableViewDelegate{
    let tableView = UITableView()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        points.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let point = points[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell" , for: indexPath) as! BottomTableCell
        cell.setup(point: point)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height/5

    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let point = points[indexPath.row]
        let obj = point.pointOnMap
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "moveMap"), object: obj)
        print("didSelected")
    }
    init(frame : CGRect){
        super.init(frame: .zero, style: .insetGrouped)
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: NSNotification.Name("reloadBottomSheet"), object: nil)
        setup()
    }
    
    @objc func reload(notification : Notification){
        tableView.reloadData()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setup(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(BottomTableCell.self, forCellReuseIdentifier: "cell")
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        tableView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        tableView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        tableView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
    }
}
