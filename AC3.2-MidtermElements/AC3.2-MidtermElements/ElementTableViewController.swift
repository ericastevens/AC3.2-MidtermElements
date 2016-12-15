//
//  ElementTableViewController.swift
//  AC3.2-MidtermElements
//
//  Created by Jason Gresh on 12/7/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class ElementTableViewController: UITableViewController {
    var elements = [Element]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "NibTableViewCell", bundle: nil), forCellReuseIdentifier: "NibCell")
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50

        self.title = "The Elements"
        
        getData()
    }
    
    func getData() {
        APIRequestManager.manager.getData(endPoint: "https://api.fieldbook.com/v1/58488d40b3e2ba03002df662/elements") { data in
            if let validData = data {
                if let jsonData = try? JSONSerialization.jsonObject(with: validData, options:[]),
                    let elements = jsonData as? [[String:Any]] {
                    
                    self.elements = Element.getElements(from: elements)
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.elements.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NibCell", for: indexPath) as! NibTableViewCell

        let element = self.elements[indexPath.row]
        cell.titleLabel.text = element.name
        cell.subtitleLabel.text = "\(element.symbol)(\(element.number)) \(element.weight)"
        cell.elementimageView.image = nil
        
        APIRequestManager.manager.getData(endPoint: "https://s3.amazonaws.com/ac3.2-elements/\(element.symbol)_200.png") { data in
            if let validData = data,
                let image = UIImage(data: validData) {
                
                DispatchQueue.main.async {
                    cell.elementimageView.image = image
                    cell.setNeedsLayout()
                }
            }
        }

        return cell
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ElementViewController") as! ElementViewController
        
        controller.element = elements[indexPath.row]
        
        self.navigationController?.pushViewController(controller, animated: true) //shows view
    }
//    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "ElementSegue" {
//            if let evc = segue.destination as? ElementViewController {
//                if let cell = sender as? NibTableViewCell {
//                    if let ip = tableView.indexPath(for: cell) {
//                        evc.element = elements[ip.row]
//                    }
//                }
//            }
//        }
//    }

}
