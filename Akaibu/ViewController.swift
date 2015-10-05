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
    
//    NSUserDefaults.standardUserDefaults().removePersistentDomainForName(NSBundle.mainBundle().bundleIdentifier!)
    
    let db = AkaibuDB.connect("debug:v1")
    
    // Do any additional setup after loading the view, typically from a nib.
//    for _ in (0...10000) {
    let model = Child()
      model.code = "abc"
      model.name = "aNameaName"
      model.childKey = "changed!"
  //    model.aArray.append(10000)
      model.parentName = "ABC"
      
      model.save()
//    }
    
//    model.save()
    
//    print(model.keyForArchive)
////    Akaibu.archive(obj: model, _class: Model.classForCoder())
//    
//    let newModel = Akaibu.unarchive(model.keyForArchive) as? Child
    
//    print(newModel?.keyForArchive)
    
//    newModel?.save()
    
    let results = db.collection("Child").find(options: ["parentName": "ABC"]) as? [Child]
    
    print(results?.count)
//    print(db.collection("Child").documents)
    
//    let collections = Akaibu.unarchive("debug:v1:Child") as? AkaibuCollection
//    print(collections?.documents)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

