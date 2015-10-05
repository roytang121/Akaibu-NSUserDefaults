//
//  Model.swift
//  Akaibu
//
//  Created by Roy Tang on 4/10/2015.
//  Copyright © 2015 lerryrowy. All rights reserved.
//

import Foundation
import UIKit

class Model: Akaibu {
  var code: String!
  var name: String!
  var aArray: [Int] = [1,2,3,4,5]
  weak var aWeakRef: UIView!
  var aClosure: ((attr1: String) -> Void)?
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override func encodeWithCoder(aCoder: NSCoder) {
    super.encodeWithCoder(aCoder)
  }
  
  override init() {
    super.init()
  }
  
  override func getCollection() -> String {
    return "Model"
  }
}