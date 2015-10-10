//
//  Child.swift
//  Akaibu
//
//  Created by Roy Tang on 4/10/2015.
//  Copyright © 2015 lerryrowy. All rights reserved.
//

import Foundation

class Child: Model {
  var childKey = "wowItWorks!"
  
  override func encodeWithCoder(aCoder: NSCoder) {
    super.encodeWithCoder(aCoder)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override init() {
    super.init()
  }
  
  override func getCollection() -> String {
    return "Child"
  }
}
