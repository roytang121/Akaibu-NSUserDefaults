# Akaibu

### What is it ?

 * **Archive** any class in just **ONE-LINE** of code.
 * **Automatically** map class's properties under the hood.
 * Drop in replacement of NSObject
 * Swifty \<3

### Installation
Drag n drop the `Akaibu.swift` into your project directory. Enjoy ~

```swift
// By extending Akaibu, it inherits from NSObject and NSCoding automatically

class Model: Akaibu {
    //.....
}
```

### tl;dr
That's all you need to know
```swift
model.saveWithKey(key) // archive to NSUserDefaults
// or
Akaibu.saveWithKey(model, key) // archive to NSUserDefaults


let model = Akaibu.loadWithKey(key) as? Model // load from NSUserDefaults
```

### Clear saved objects
```swift
Akaibu.removeAll()
```
### Why Akaibu ?
* Easy to use and save tons of time
* You don't want CoreData
* You are sick of `encodeWithCoder:` and `initWithCoder:`


### About Akaibu:

* Akaibu is inspired by the japanese word **「アーカイブ」** , which means **archive**. 