//
//  AkaibuCollection.swift
//  Akaibu
//
//  Created by Roy Tang on 5/10/2015.
//  Copyright © 2015 lerryrowy. All rights reserved.
//

import Foundation

class AkaibuCollection: Akaibu {
  var key: String!
  var documents: [Akaibu]!
  
  init(key: String) {
    super.init()
    
    self.key = key
    self.documents = []
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override func archivedKey() -> String {
//    return "\(AkaibuDB.currentIntance()!.name):\(self.key)" // object Id is not neccessary
    return AkaibuDB.currentInstance().collectionNameWithRespectToDB(self.key)
  }
  
  func save() {
    // since the objectId is neglected, there should be no difference between update: true / update: false
//    self.archive(update: false)
    self.keyForArchive = self.archivedKey()
    
    let data = NSKeyedArchiver.archivedDataWithRootObject(self)
    let userDefaults = NSUserDefaults.standardUserDefaults()
    userDefaults.setObject(data, forKey: self.keyForArchive)
    userDefaults.synchronize()
  }
  
  func find(options options: [String : NSObject]?) -> [Akaibu] {
    var results = [Akaibu]()
    
    //    let collection = AkaibuDB.currentInstance().collection(self.dynamicType)
      
    var filtered = self.documents.forEach({ (document) -> Void in
      
      if options == nil {
        results.append(document)
        return
      }
      
      for (key, targetValue) in options! {
        if let value = (document as? NSObject)?.valueForKey(key) as? NSObject {
          if targetValue != value {
            return
          }
        }
      }
      
      results.append(document)
    })
    
    return results
  }
}