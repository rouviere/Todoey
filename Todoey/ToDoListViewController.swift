//
//  ViewController.swift
//  Todoey
//
//  Created by Forrest Anderson on 1/29/18.
//  Copyright © 2018 Rouviere Media. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
  
  var itemArray = ["Get Job", "Travel to Japan", "Pay off debt"]

 
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
  
  
  //MARK - Add New Items
  
  @IBAction func AddButtonPressed(_ sender: UIBarButtonItem) {
    
    var textField = UITextField() // local variable - available only within AddButtonPressed. This is created to hold the value of the newly created task
    
    let alert = UIAlertController(title: "Add New To Do Item", message: "", preferredStyle: .alert)
    
    let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
      
      self.itemArray.append(textField.text!) // this appends the new value to the itemArray
      
      self.tableView.reloadData() // this refreshes the table after the new items is added to the array!
      
    }
    
    // This adds a field to the alert popup where you can add a new To Do Item.
    alert.addTextField { (alertTextField) in
      alertTextField.placeholder = "Create new item"
      textField = alertTextField // Here we add the value that is entered in the field to the var
      // print(alertTextField.text)
    }
    
    // Add alert action item
    alert.addAction(action)
    
    present(alert, animated: true, completion: nil)
  }


}

