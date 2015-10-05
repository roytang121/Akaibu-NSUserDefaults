//
//  AkaibuDatabase.swift
//  Akaibu
//
//  Created by Roy Tang on 5/10/2015.
//  Copyright © 2015 lerryrowy. All rights reserved.
//

import Foundation

class AkaibuDB {
  var name: String!
  
  private static var mInstance: AkaibuDB!
  
  private init() {
    name = "debug-db"
  }
  
  private init(named: String) {
    name = named
  }
  
  func collection(withName: String) -> AkaibuCollection {
//    print(self.collectionNameWithRespectToDB(withName))
    if let collection = Akaibu.unarchive(self.collectionNameWithRespectToDB(withName)) as? AkaibuCollection {
      return collection
    } else {
      return AkaibuCollection(key: withName)
    }
  }
  
  static func connect(name: String) -> AkaibuDB {
    if mInstance == nil {
      mInstance = AkaibuDB(named: name)
    }
    
    return mInstance
  }
  
  func collectionNameWithRespectToDB(name: String) -> String {
    return "\(self.name):\(name)"
  }
  
  static func currentInstance() -> AkaibuDB! {
    return AkaibuDB.mInstance
  }
}
