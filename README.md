
# SwiftySwift

AutoLayout Syntax Sugar DSL:

Converts this:

```swift
let constraint = NSLayoutConstraint(
            item:        view1,
            attribute:  .leading,
            relatedBy:  .equal,
            toItem:      view2,
            attribute:  .leading,
            multiplier:  1.0,
            constant:   8.0
        )
constraint.isActive = true
```

to this one line:

```swift
view1.leading |=| view2.leading + 8
```

More examples:

```swift
// Add labels to view
view |+| [
  topLabel,
  bottomLabel
]

view.leading |=| topLabel.leading ! 999     // Constraint at priority 999
view.trailing |=| topLabel.trailing
view.top + 8 |=| topLabel.top               // topLabel's top is 8 spacing below view's top

// Add three constraints in one line
[view.leading, view.trailing, view.bottom] |=| [bottomLabel.leading, bottomLabel.trailing, bottomLabel.bottom]

```


===============

JSON

```swift

struct Person: JSONSerializable {
    var name: String
    var age: Int
}

let me = Person(name: "Justin", age: 99)
let dict = me.toJSON()                // dict will have value of ["name" : "Justin", "age" : 99]

```

```swift

class Article {
    let title: String
    let body: String?
    
    required init(json: JSON) throws {
        let parser = JSONParser(json: json)
        self.title = try parser.get("title")
        self.body = try parser.get("body")
    }
}

let json = ["title" : "Title", "body" : "Hello world"]
let article = try? Article(json: json)
print(article?.title)               // Prints "Title"
print(article?.body)                // Prints "Hello world"
```

