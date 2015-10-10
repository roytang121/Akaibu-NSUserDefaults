//
//  AModel.swift
//  Akaibu
//
//  Created by Roy Tang on 9/10/2015.
//  Copyright © 2015 lerryrowy. All rights reserved.
//

import Foundation

class AModel: Akaibu {
//  var name: String! = "aName"
//  var newName: String! = "a"
  
  override init() {
    super.init()
  }
  
  required init?(coder aDecoder: NSCoder) {
//    self.name = aDecoder.decodeObjectForKey("name") as? String
    super.init(coder: aDecoder)
  }
  
}

class BModel : AModel {
  var bName: String! = "bName"
  
  override init() {
    super.init()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
//    self.bName = aDecoder.decodeObjectForKey("bName") as? String
  }
}