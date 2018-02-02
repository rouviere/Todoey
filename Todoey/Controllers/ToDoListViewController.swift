//
//  ViewController.swift
//  Todoey
//
//  Created by Forrest Anderson on 1/29/18.
//  Copyright © 2018 Rouviere Media. All rights reserved.
//

import UIKit
import CoreData

class ToDoListViewController: UITableViewController {
  
  var itemArray = [Item]()
  
  var selectedCategory : Category? {
    didSet{
      loadItems()
    }
  }
  
  // This is how you connect to the AppDelegate to pull in the persistentContainer, etc.
  let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Find the path to where the app is so we can view the sqlite db
    print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
    
   // loadItems() // see didSet above
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
    
   // context.delet(itemArray[indexPath.row]) // step 1 - removes it from the context
   // itemArray.remove(at: indexPath.row) // step 2 - removes an item from the tableview
    
    
    itemArray[indexPath.row].done = !itemArray[indexPath.row].done  // the ! signifies the opposite or not
    
    saveItems()
    
    tableView.deselectRow(at: indexPath, animated: true) // At this point the cells remain gray when you click on them.
  }
  
  
  //MARK - Add New Items
  
  @IBAction func AddButtonPressed(_ sender: UIBarButtonItem) {
    
    var textField = UITextField() // local variable - available only within AddButtonPressed. This is created to hold the value of the newly created task
    
    let alert = UIAlertController(title: "Add New To Do Item", message: "", preferredStyle: .alert)
    
    let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
      // What will happen once the user clicks the Add Item button on our UIAlert
      
      
      // Here we create new NSManagedObjects - essentiall a row for each Entity and its Attributes
      let newItem = Item(context: self.context)
      newItem.title = textField.text!
      newItem.done = false
      newItem.parentCategory = self.selectedCategory
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
    
    do {
      try context.save() // Attempts to commmit changes to the persistentStore (database)
    } catch {
      print("Error saving context \(error)")
    }
    self.tableView.reloadData()
  }
  
  
  func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest(), predicate: NSPredicate? = nil) {
    
    let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
    
    if let additionalPredicate = predicate {request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, additionalPredicate])
    } else {
      request.predicate = categoryPredicate
    }

    do {
     itemArray = try context.fetch(request)
    } catch {
      print("Error fetching data from context \(error)")
    }
    
    tableView.reloadData()
  }
}


//MARK - Searchbar
extension ToDoListViewController: UISearchBarDelegate {
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    
    let request : NSFetchRequest<Item> = Item.fetchRequest()  // Load items with a new request
    
    let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!) // Then modify it with a search
    
    request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)] // Then with sort order
    
    loadItems(with: request, predicate: predicate) // Then we pass that request into our load items method
    
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






