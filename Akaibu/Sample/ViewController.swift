//
//  ViewController.swift
//  Akaibu
//
//  Created by Roy Tang on 4/10/2015.
//  Copyright © 2015 lerryrowy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    
//    let model = Child()
//    model.code = "aCode"
//    model.parentName = "aParent"
    
    let loaded = Akaibu.loadWithKey("model-1") as? Child
    
    print(loaded?.dictionaryWithValuesForKeys(["code", "parentName", "name"]))
    let ud = NSUserDefaults.standardUserDefaults()
    
    
//    let b = BModel()
//    b.saveWithKey("amodel")
//    b.bName = "bbbbb"
//    
//    ud.setObject(NSKeyedArchiver.archivedDataWithRootObject(b), forKey: "amodel")
//    
//    ud.synchronize()
    
    let a  = (NSKeyedUnarchiver.unarchiveObjectWithData(ud.objectForKey("amodel") as! NSData) as! BModel)
    
    print(a)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

