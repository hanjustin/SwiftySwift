
![Swift Version](https://img.shields.io/badge/Swift-3.0-red)

# SwiftySwift

# Requirements

### Swift 3

# Description

Simplifies using Auto Layout and handling JSON data.

# Installation

```
pod 'JLSwiftySwift'
```

# Examples

### AutoLayout Syntax Sugar DSL:

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


### JSON

```swift

struct Person: JSONConvertible {
    var name: String
    var age: Int

    init(json: JSON) throws {
        let parser = JSONParser(json: json)
        self.name = try parser.get("name")
        self.age = try parser.get("age")
    }
}

enum ArticleSource: String, RawValueInitializable {
    case yahoo
    case cnn
}

class Article: JSONConvertible {
    let title: String
    let body: String?
    let author: Person
    let source: ArticleSource

    required init(json: JSON) throws {
        let parser = JSONParser(json: json)
        self.title = try parser.get("title")
        self.body = try parser.get("body")
        self.author = try parser.get("author")
        self.source = try parser.get("source")
    }
}

let json: [String : Any] = ["title" : "Title", "body" : "Hello world", "source" : "cnn", "author" : ["name" : "Justin", "age" : 99]]
let article = try? Article(json: json)
print(article?.title)               // Prints "Title"
print(article?.body)                // Prints "Hello world"
print(article?.source)              // Prints "ArticleSource.cnn"
let dict = article?.toJSON()        // Will output same the same json that was used to initialize article
```

