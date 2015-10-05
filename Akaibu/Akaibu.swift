//
//  Akaibu.swift
//  Akaibu
//
//  Created by Roy Tang on 4/10/2015.
//  Copyright © 2015 lerryrowy. All rights reserved.
//

import Foundation
 protocol AkaibuProtocol {
  func getCollection() -> String
}

class Akaibu: NSObject, NSCoding, AkaibuProtocol {
  
  var parentName: String! = "Parent"
  var keyForArchive: String!
  var objectId: String!
  
  override init() {
    super.init()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init()
    
    var _class: AnyClass? = self.classForCoder
    while (_class != nil && _class != NSObject.self) {
      let properties = Akaibu.getProperties(_class!)
      for (name, _) in properties {
        let value = aDecoder.decodeObjectForKey(self.keyWithName(name))
        self.setValue(value, forKey: name)
      }
      _class = _class?.superclass()
    }
  }
  
  func encodeWithCoder(aCoder: NSCoder) {
    print("encodeWithCoder \(self.dynamicType)")
    
//    print(properties)
    
    
    // add properties relatives to superclass
    var _class: AnyClass? = self.classForCoder
    
    while (_class != nil && _class != NSObject.self) {
      let properties = Akaibu.getProperties(_class!)
      for (name, _) in properties {
        let value = self.valueForKey(name)
        aCoder.encodeObject(value, forKey: self.keyWithName(name))
      }
      _class = _class?.superclass()
    }
  }
  
  func keyWithName(name: String) -> String {
    return "\(name)"
  }
  
  func archivedKey() -> String {
    return "\(AkaibuDB.currentInstance()!.name):\(self.getCollection()):\(self.objectId)"
//    return "\(self.dynamicType)"
  }
  
  func archive(update update: Bool) {
    if self.objectId == nil || !update {
      objectId = NSUUID().UUIDString
    }
    
    // call archivedKey after objectId has been set
    keyForArchive = archivedKey()
    
    let data = NSKeyedArchiver.archivedDataWithRootObject(self)
    let userDefaults = NSUserDefaults.standardUserDefaults()
    userDefaults.setObject(data, forKey: self.keyForArchive)
    userDefaults.synchronize()
  }
  
  class func unarchive(key: String) -> AnyObject? {
    let userDefaults = NSUserDefaults.standardUserDefaults()

    if let obj = userDefaults.objectForKey(key) as? NSData {
      if let data = NSKeyedUnarchiver.unarchiveObjectWithData(obj) {
        return data
      }
    }
    
    return nil
  }
  
  static func getProperties(_class: AnyClass) -> [String: String] {
    var count: UInt32 = 0
    var properties = class_copyPropertyList(_class, &count)

    var results = [String: String]()
    for i in (0..<count) {
      let property = properties[Int(i)]
      let name = NSString(UTF8String: property_getName(property)) as! String
      
      let attrs = NSString(UTF8String: property_getAttributes(property)) as! String
      
//      let ivar = class_getInstanceVariable(_class, name)
      results[name] = attrs
    }

    free(properties)
//    print(results)
    return results
  }
  
  private class func toStr(utf8String: UnsafePointer<Int8>) -> String! {
    return NSString(UTF8String: utf8String) as? String
  }
  
  static func getIVars(_class: AnyClass) {
    var count: UInt32 = 0
    var ivarList = class_copyIvarList(_class, &count)
    
    var results = [String]()
    for i in (0..<count) {
      let property = ivarList[Int(i)]
      let name = NSString(UTF8String: ivar_getName(property)) as! String
      results.append(name)
    }
    
    free(ivarList)
  }
  
  func getCollection() -> String {
    return "\(self.dynamicType)"
  }
  
  // CRUD
  func save() {
    
    if self.objectId == nil {
      self.archive(update: false)
      
      // append to collection
      let collection = AkaibuDB.currentInstance().collection(self.getCollection())
      collection.documents.append(self)
      collection.save()
      return
      
    } else {
    
      // notify collection changes
//      let collection = AkaibuDB.currentIntance().collection(self.getCollection())
      
      // actually it's not even needed to check the existence of documents
      
//      if let index = collection.documents.indexOf(self.objectId) {
//        self.archive(update: true)
//      }
      
      self.archive(update: true)
      
    }
  }
  
//  func find(options: [String: AnyObject]) -> [Akaibu] {
//    let collection = AkaibuDB.currentInstance().collection(self.getCollection())
//    for documents in collection.documents {
//      return [self]
//    }
//  }
  
  private static func find<T>(_class: T, options: [String : NSObject]?) -> [Akaibu] {
    var results = [Akaibu]()
    
//    let collection = AkaibuDB.currentInstance().collection(self.dynamicType)
    if let obj = _class as? Akaibu.Type {
      let classType = obj.classForCoder()
      
      let collection = AkaibuDB.currentInstance().collection("\(classType)")
      var filtered = collection.documents.forEach({ (document) -> Void in
        
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
      
    }
    
    
    return results
  }
  
  
  override func isEqual(object: AnyObject?) -> Bool {
    if let obj = object as? Akaibu {
      return obj.objectId == self.objectId
    } else {
      return false
    }
  }
  // utils
}