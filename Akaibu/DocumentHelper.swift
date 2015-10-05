//
//  DocumentHelper.swift
//  SpeakUp
//
//  Created by Roy Tang on 6/9/15.
//  Copyright (c) 2015 Sensbeat Limited. All rights reserved.
//

import Foundation

class DocumentHelper {
  
  static private let DEFAULT_DIR_NAME = "Akaibu"
  
  class func documentDirectory() -> NSURL! {
    let fileManager = NSFileManager.defaultManager()
    
    let urls = fileManager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
    
    if let documentDirectory: NSURL = urls.first {
      return documentDirectory
    } else {
      return nil
    }
  }
  
  class func mkdir(named named: String!) -> NSError? {
    if let d = documentDirectory() {
      let url = d.URLByAppendingPathComponent(named, isDirectory: true)
      
      var error: NSError?
      
      do {
        try NSFileManager.defaultManager().createDirectoryAtURL(url, withIntermediateDirectories: false, attributes: nil)
      } catch let error1 as NSError {
        error = error1
      }
      
      return error
    } else {
      return NSError(domain: "DocumentHelper:mkdir:fail", code: 0, userInfo: nil)
    }
  }
  
  // get directory by name
  // create empty directory if given dir does not exist
  class func cd(named named: String!) -> NSURL! {
    if let d = documentDirectory() {
      let fm = NSFileManager.defaultManager()
      
      let url = d.URLByAppendingPathComponent(named, isDirectory: true)
      if fm.fileExistsAtPath(url.path!) {
        return url
      } else {
        let error = mkdir(named: named)
        if error == nil {
          return url
        } else {
          return nil
        }
      }
    } else {
      return nil
    }
  }
  
  class func defaultDataDirectory() -> NSURL! {
    return cd(named: DocumentHelper.DEFAULT_DIR_NAME)
  }
}
