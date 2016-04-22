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
  
  internal static let SuiteNameAkaibu: String = "Akaibu"
  internal var parentName: String! = "Akaibu"
  static let SUITE_NAME = "Akaibu"
  
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
        //        omvlog(name)
        let value = aDecoder.decodeObjectForKey(self.encodingKeyForPropertyWithName(name))
        self.setValue(value, forKey: name)
      }
      _class = _class?.superclass()
    }
  }
  
  func encodeWithCoder(aCoder: NSCoder) {
    //    omvlog("encodeWithCoder \(self.dynamicType)")
    
    // add properties relatives to superclass
    var _class: AnyClass? = self.classForCoder
    
    while (_class != nil && _class != NSObject.self) {
      let properties = Akaibu.getProperties(_class!)
      for (name, _) in properties {
        let value = self.valueForKey(name)
        aCoder.encodeObject(value, forKey: self.encodingKeyForPropertyWithName(name))
      }
      _class = _class?.superclass()
    }
  }
  
  private func encodingKeyForPropertyWithName(name: String) -> String {
    return name
  }
  
  private static func getProperties(_class: AnyClass) -> [String: String] {
    var count: UInt32 = 0
    let properties = class_copyPropertyList(_class, &count)
    
    var results = [String: String]()
    for i in (0..<count) {
      let property = properties[Int(i)]
      let name = NSString(UTF8String: property_getName(property)) as! String
      
      let attrs = NSString(UTF8String: property_getAttributes(property)) as! String
      
      //      let ivar = class_getInstanceVariable(_class, name)
      results[name] = attrs
    }
    
    free(properties)
    
    return results
  }
  
  private class func toStr(utf8String: UnsafePointer<Int8>) -> String! {
    return NSString(UTF8String: utf8String) as? String
  }
  
  private static func getIVars(_class: AnyClass) {
    var count: UInt32 = 0
    let ivarList = class_copyIvarList(_class, &count)
    
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
  
  
  override func isEqual(object: AnyObject?) -> Bool {
    if let obj = object as? Akaibu {
      return obj.objectId == self.objectId
    } else {
      return false
    }
  }
  
  
  // MARK: Public APIs
  
  func saveWithKey(key: String) {
    let data = NSKeyedArchiver.archivedDataWithRootObject(self)
    
    if let userDefaults = NSUserDefaults(suiteName: Akaibu.SuiteNameAkaibu) {
      userDefaults.setObject(data, forKey: key)
      userDefaults.synchronize()
    }
  }
  
  class func saveWithKey(obj: Akaibu, key: String) {
    obj.saveWithKey(key)
  }
  
  class func loadWithKey(key: String) -> Akaibu? {
    if let userDefaults = NSUserDefaults(suiteName: Akaibu.SuiteNameAkaibu) {
      
      if let obj = userDefaults.objectForKey(key) as? NSData {
        //
        //        if let data = NSKeyedUnarchiver.unarchiveObjectWithData(obj) as? Akaibu {
        //          return data
        //        }
        do {
          if let data = try NSKeyedUnarchiver.unarchiveObjectWithData(obj) as? Akaibu {
            return data
          }
        } catch (_) {
//          omvlog("Error")
          return nil
        }
      }
      
    }
    return nil
  }
  
  class func removeAll() {
    let defaults = NSUserDefaults(suiteName: Akaibu.SuiteNameAkaibu)
    
    NSUserDefaults(suiteName: Akaibu.SuiteNameAkaibu)?.dictionaryRepresentation().keys.forEach({ (key) -> () in
      defaults?.removeObjectForKey(key)
    })
  }
}