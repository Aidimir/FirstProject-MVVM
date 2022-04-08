//
//  cart_tableview.swift
//  FirstUIkitProject
//
//  Created by Айдимир Магомедов on 01.03.2022.
//

import Foundation
import UIKit
import SnapKit

class TableView : UITableViewController{
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = Header().setup(headerText: "Cart")
        return cell
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cart.count
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height/6
    }
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.setup(card: cart[indexPath.item])
        return cell
    }
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            cart.remove(at: indexPath.row)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
        NotificationCenter.default.post(name: NSNotification.Name("reloadPrice"), object: nil)
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelect(productName: cart[indexPath.row].name)
    }
    init(){
        super.init(style: .insetGrouped)
        NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "load"), object: nil)
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = .black
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc func loadList(notification: NSNotification){
        //load data her
        tableView.reloadData()
    }
    func didSelect(productName : String){
        let controller = getCurrentViewController()
        let thePage = allProducts[productName]
        controller?.present(thePage!.destinationPage, animated: true, completion: nil)
    }
}
