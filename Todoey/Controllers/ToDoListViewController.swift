//
//  ViewController.swift
//  Todoey
//
//  Created by Forrest Anderson on 1/29/18.
//  Copyright © 2018 Rouviere Media. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
  
  var itemArray = [Item]()
  
  let defaults = UserDefaults.standard

 
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let newItem = Item()
    newItem.title = "Get a Job"
    itemArray.append(newItem)
    
    let newItem2 = Item()
    newItem2.title = "Go to Japan"
    itemArray.append(newItem2)
    
    let newItem3 = Item()
    newItem3.title = "Pay off Debts"
    itemArray.append(newItem3)
    
    if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
      itemArray = items
    }
    
  }

  //MARK - TableView Datasource
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return itemArray.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for:indexPath)
    
    let item = itemArray[indexPath.row]
    
    cell.textLabel?.text = item.title
    
    // Ternary operator ==>
    // value = condition ? valueIfTrue : valueIfFalse
    
    cell.accessoryType = item.done ? .checkmark : .none  // replaces the following:
    
//    if item.done == true {
//      cell.accessoryType = .checkmark
//    } else {
//      cell.accessoryType = .none
//    }
    
    return cell
  }

  //MARK - TableView Delegate Methods
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    // print(indexPath.row) // prints the row index 0, 1, 2, ...
    print(itemArray[indexPath.row]) // prints the name of the array item
    
    // set the object value to done or not done - then in numberOfRowsInSection, set the corresponding checkmark values
    
    itemArray[indexPath.row].done = !itemArray[indexPath.row].done  // the ! signifies the opposite or not
    
//    This is the wordy version of the above
//    if itemArray[indexPath.row].done == false {
//      itemArray[indexPath.row].done = true
//    } else {
//      itemArray[indexPath.row].done = false
//    }
    
    tableView.reloadData() // you have to do this to display the checkmark changes.
    
    // At this point the cells remain gray when you click on them. To highlight briefly when you click them and then return to white requires this:
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
  
  //MARK - Add New Items
  
  @IBAction func AddButtonPressed(_ sender: UIBarButtonItem) {
    
    var textField = UITextField() // local variable - available only within AddButtonPressed. This is created to hold the value of the newly created task
    
    let alert = UIAlertController(title: "Add New To Do Item", message: "", preferredStyle: .alert)
    
    let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
      
      let newItem = Item()
      newItem.title = textField.text!
      
      self.itemArray.append(newItem) // this appends the new value to the itemArray
      
      self.defaults.set(self.itemArray, forKey: "TodoListArray") // add item to user defaults
      
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

