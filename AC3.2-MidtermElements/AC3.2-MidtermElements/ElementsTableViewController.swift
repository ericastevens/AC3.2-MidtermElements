//
//  ElementsTableViewController.swift
//  AC3.2-MidtermElements
//
//  Created by Erica Y Stevens on 12/8/16.
//  Copyright © 2016 Erica Stevens. All rights reserved.
//

import UIKit

class ElementsTableViewController: UITableViewController {
    var elements = [Element]()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadElements()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return elements.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ElementCell", for: indexPath) as! ElementTableViewCell
        
        let element = elements[indexPath.row]
        
        cell.elementNameLabel.text = element.name
        cell.symbolAtomicWeightLabel.text = "\(element.symbol)(\(element.number)) \(element.weight!)"
        
        let imageURLString = "https://s3.amazonaws.com/ac3.2-elements/\(element.symbol)_200.png"
        
            APIRequestManager.manager.getData(endPoint: imageURLString)  { (data: Data?) in
                if let validData = data,
                    let image = UIImage(data: validData) {
                    DispatchQueue.main.async {
                        cell.elementImageView.image = image
                        cell.setNeedsLayout()
                    }
                }
            }
        return cell
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? DetailViewController {
            if let cell = sender as? ElementTableViewCell {
                if let indexPath = tableView.indexPath(for: cell) {
                    let element = elements[indexPath.row]
                        vc.element = element
                }
            }
        }
    }
    
    func loadElements() {
        APIRequestManager.manager.getData(endPoint: "https://api.fieldbook.com/v1/58488d40b3e2ba03002df662/elements") { (data: Data?) in
            if let validData = data {
                if let json = try? JSONSerialization.jsonObject(with: validData, options: []) {
                    if let jsonArrayOfDicts = json as? [[String:Any]] {
                        self.elements = Element.parseElements(from: jsonArrayOfDicts)
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                }
            }
        }
    }

}
