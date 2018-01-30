//
//  Item.swift
//  Todoey
//
//  Created by Forrest Anderson on 1/29/18.
//  Copyright © 2018 Rouviere Media. All rights reserved.
//

import Foundation

class Item: Codable {   // by adding Encodable the Item class can be encoded into a Plist file or JSON
  var title: String = ""
  var done: Bool = false
}
