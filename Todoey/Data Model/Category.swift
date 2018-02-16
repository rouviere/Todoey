//
//  Category.swift
//  Todoey
//
//  Created by Forrest Anderson on 2/8/18.
//  Copyright © 2018 Rouviere Media. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
  @objc dynamic var name: String = ""
  let items = List<Item>() // This defines the forward relationship to the Item array data
}
