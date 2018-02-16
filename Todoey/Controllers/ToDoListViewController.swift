//
//  ViewController.swift
//  Todoey
//
//  Created by Forrest Anderson on 1/29/18.
//  Copyright © 2018 Rouviere Media. All rights reserved.
//

import UIKit
import RealmSwift

class ToDoListViewController: UITableViewController {
  
  var todoItems: Results<Item>?
  let realm = try! Realm()
  
  var selectedCategory : Category? {
    didSet{
    loadItems()
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Find the path to where the app is so we can view the sqlite db
    print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
    
   // loadItems() // see didSet above
  }

  //MARK - TableView Datasource
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return todoItems?.count ?? 1
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for:indexPath)
    
    if let item = todoItems?[indexPath.row] {
    
    cell.textLabel?.text = item.title
    
    cell.accessoryType = item.done ? .checkmark : .none  // replaces the following:
    
    } else {
      cell.textLabel?.text = "No Items Added"
    }
      
    return cell
  }

  //MARK - TableView Delegate Methods
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    if let item = todoItems?[indexPath.row] {
      do {
      try realm.write {
        
       //  realm.delete(item) // deletes items directly.
       item.done = !item.done
      }
      } catch {
        print("Error saving done status, \(error)")
      }
    }
    
    tableView.reloadData()

    tableView.deselectRow(at: indexPath, animated: true) // At this point the cells remain gray when you click on them.
  }
  
  
  //MARK - Add New Items
  
  @IBAction func AddButtonPressed(_ sender: UIBarButtonItem) {
    
    var textField = UITextField() // local variable - available only within AddButtonPressed. This is created to hold the value of the newly created task
    
    let alert = UIAlertController(title: "Add New To Do Item", message: "", preferredStyle: .alert)
    
    let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
      
      if let currentCategory = self.selectedCategory {
        do {
        try self.realm.write {
          let newItem = Item()
          newItem.title = textField.text!
          newItem.dateCreated = Date()
          currentCategory.items.append(newItem)
          }
        }catch {
            print("Error saving new items")
          }
      }
      
      self.tableView.reloadData()
      
    }
    
    alert.addTextField { (alertTextField) in
      alertTextField.placeholder = "Create new item"
      textField = alertTextField // Here we add the value that is entered in the field to the var
    }
    
    alert.addAction(action) // Add alert action item
    present(alert, animated: true, completion: nil)
  }
  
  //MAARK - Model Manipulation Methods
  
  func loadItems() {
    
    todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)

    tableView.reloadData()
  }
}


//MARK - Searchbar
extension ToDoListViewController: UISearchBarDelegate {

  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    
    todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
    
    tableView.reloadData() 
  }

  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    if searchBar.text?.count == 0 {
      loadItems()

      DispatchQueue.main.async {  // makes it possible to dismiss the keyboard while the app is running
        searchBar.resignFirstResponder()
      }

    }
  }
}

