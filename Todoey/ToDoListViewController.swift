//
//  ViewController.swift
//  Todoey
//
//  Created by Forrest Anderson on 1/29/18.
//  Copyright © 2018 Rouviere Media. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
  
  let itemArray = ["Get Job", "Travel to Japan", "Pay off debt"]

  override func viewDidLoad() {
    super.viewDidLoad()
    
  }

  //MARK - TableView Datasource
 
  /* this is not needed if you only have one section!
  override func numberOfSections(in tableView: UITableView) -> Int {
    return itemArry.count
  }
 */
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return itemArray.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for:indexPath)
    cell.textLabel?.text = itemArray[indexPath.row]
    
    return cell
  }

  //MARK - TableView Delegate Methods
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    // print(indexPath.row) // prints the row index 0, 1, 2, ...
    print(itemArray[indexPath.row]) // prints the name of the array item
    
    if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    } else {
      tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    
    // At this point the cells remain gray when you click on them. To highlight briefly when you click them and then return to white requires this:
    
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
  
  
  
  


}

