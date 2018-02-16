//
//  CategoryTableViewController.swift
//  Todoey
//
//  Created by Forrest Anderson on 2/1/18.
//  Copyright © 2018 Rouviere Media. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {
  
  let realm = try! Realm() // 1. Initialize a new access point to our Realm database
  
  var categories : Results<Category>? // 2. set up a new collection type: a collection of Results
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
      loadCategories() //3 When the app first loads, we load up all the categories that we currently own.
                        // see line 67
    }
  
  //MARK: - TableView Datasource Methods
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return categories?.count ?? 1 // 4. count the number of categories. If there aren't any return 1
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for:indexPath)
    
    cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories Added yet" // If there are any categories to display, show the messages: "No Categories Added yet"
    
    return cell
  }
  
  //MARK: - TableViewDelegate Methods
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    performSegue(withIdentifier: "goToItems", sender: self)
    
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let destinationVC = segue.destination as! ToDoListViewController
    
    if let indexPath = tableView.indexPathForSelectedRow {
      destinationVC.selectedCategory = categories?[indexPath.row]
    }
  }
  
  //MARK: - Data Manipulation Methods
  
  func save(category: Category) {
      do {
        try realm.write {
          realm.add(category)
        }
      } catch {
        print("Error saving category \(error)")
      }
      tableView.reloadData()
    }
  
  func loadCategories() {

    categories = realm.objects(Category.self)
    
    tableView.reloadData()
  }

  //MARK: - Add New Categories
  @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
    
    var textField = UITextField()
    
    let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
    
    let action = UIAlertAction(title: "Add", style: .default) { (action) in
      
      let newCategory = Category()
      newCategory.name = textField.text!
      
      self.save(category: newCategory)
    }
    
    alert.addAction(action)
    
    alert.addTextField { (field) in
      textField = field
      textField.placeholder = "Add a new category"
    }
    
    present(alert, animated: true, completion: nil)
  }
}
