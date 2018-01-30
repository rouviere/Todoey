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
  let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // print(dataFilePath)
    
    loadItems()
  }

  //MARK - TableView Datasource
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return itemArray.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for:indexPath)
    
    let item = itemArray[indexPath.row]
    
    cell.textLabel?.text = item.title
    
    cell.accessoryType = item.done ? .checkmark : .none  // replaces the following:
    
    return cell
  }

  //MARK - TableView Delegate Methods
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
  
    print(itemArray[indexPath.row]) // prints the name of the array item
    
    itemArray[indexPath.row].done = !itemArray[indexPath.row].done  // the ! signifies the opposite or not
    
    saveItems()
    
    tableView.deselectRow(at: indexPath, animated: true) // At this point the cells remain gray when you click on them.
  }
  
  
  //MARK - Add New Items
  
  @IBAction func AddButtonPressed(_ sender: UIBarButtonItem) {
    
    var textField = UITextField() // local variable - available only within AddButtonPressed. This is created to hold the value of the newly created task
    
    let alert = UIAlertController(title: "Add New To Do Item", message: "", preferredStyle: .alert)
    
    let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
      
      let newItem = Item()
      newItem.title = textField.text!
      
      self.itemArray.append(newItem) // this appends the new value to the itemArray
      
      self.saveItems()
      
    }
    
    alert.addTextField { (alertTextField) in
      alertTextField.placeholder = "Create new item"
      textField = alertTextField // Here we add the value that is entered in the field to the var
    }
    
    alert.addAction(action) // Add alert action item
    present(alert, animated: true, completion: nil)
  }
  
  //MAARK - Model Manipulation Methods
  
  func saveItems() {
    
    let encoder = PropertyListEncoder() // create a new encoder document
    
    do {
      let data = try encoder.encode(itemArray)
      try data.write(to: dataFilePath!) // requires self because you are accessing a global value
    } catch {
      print("Error encoding item array, \(error)")
    }
    self.tableView.reloadData() // this refreshes the table after the new items is added to the array!
  }
  
  func loadItems() {
    if let data = try? Data(contentsOf: dataFilePath!) {
      let decoder = PropertyListDecoder()
      do {
      itemArray = try decoder.decode([Item].self, from: data)
      } catch {
        print("Error decoding item array, \(error)")
      }
    }
  }


}

