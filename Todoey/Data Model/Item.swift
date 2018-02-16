//
//  Item.swift
//  Todoey
//
//  Created by Forrest Anderson on 2/8/18.
//  Copyright © 2018 Rouviere Media. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
  @objc dynamic var title: String = ""
  @objc dynamic var done: Bool = false
  @objc dynamic var dateCreated: Date?
  var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
