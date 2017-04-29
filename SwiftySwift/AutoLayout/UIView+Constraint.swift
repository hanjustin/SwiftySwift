
import UIKit

public extension UIView {
    var top:                     LayoutDataConvertible { return LayoutData(item: self, attributes: [.top                                     ]) }
    var bottom:                  LayoutDataConvertible { return LayoutData(item: self, attributes: [.bottom                                  ]) }
    var leading:                 LayoutDataConvertible { return LayoutData(item: self, attributes: [.leading                                 ]) }
    var trailing:                LayoutDataConvertible { return LayoutData(item: self, attributes: [.trailing                                ]) }
    var leadingTrailing:         LayoutDataConvertible { return LayoutData(item: self, attributes: [.leading, .trailing                      ]) }
    var topBottom:               LayoutDataConvertible { return LayoutData(item: self, attributes: [.top,     .bottom                        ]) }
    var cornerTL:                LayoutDataConvertible { return LayoutData(item: self, attributes: [.top,     .left                          ]) }
    var cornerTR:                LayoutDataConvertible { return LayoutData(item: self, attributes: [.top,     .right                         ]) }
    var cornerBL:                LayoutDataConvertible { return LayoutData(item: self, attributes: [.bottom,  .left                          ]) }
    var cornerBR:                LayoutDataConvertible { return LayoutData(item: self, attributes: [.bottom,  .right                         ]) }
    var edges:                   LayoutDataConvertible { return LayoutData(item: self, attributes: [.left,     .right,    .top,  .bottom     ]) }
    var width:                   LayoutDataConvertible { return LayoutData(item: self, attributes: [.width                                   ]) }
    var height:                  LayoutDataConvertible { return LayoutData(item: self, attributes: [.height                                  ]) }
    var size:                    LayoutDataConvertible { return LayoutData(item: self, attributes: [.width,   .height                        ]) }
    var centerX:                 LayoutDataConvertible { return LayoutData(item: self, attributes: [.centerX                                 ]) }
    var centerY:                 LayoutDataConvertible { return LayoutData(item: self, attributes: [.centerY                                 ]) }
    var centerXY:                LayoutDataConvertible { return LayoutData(item: self, attributes: [.centerX, .centerY                       ]) }
    var lastBaseline:            LayoutDataConvertible { return LayoutData(item: self, attributes: [.lastBaseline                            ]) }
    var firstBaseline:           LayoutDataConvertible { return LayoutData(item: self, attributes: [.firstBaseline                           ]) }
    var leftRightMargin:         LayoutDataConvertible { return LayoutData(item: self, attributes: [.leftMargin, .rightMargin, .topMargin, .bottomMargin                ]) }
    var topMargin:               LayoutDataConvertible { return LayoutData(item: self, attributes: [.topMargin                               ]) }
    var bottomMargin:            LayoutDataConvertible { return LayoutData(item: self, attributes: [.bottomMargin                            ]) }
    var leadingMargin:           LayoutDataConvertible { return LayoutData(item: self, attributes: [.leadingMargin                           ]) }
    var trailingMargin:          LayoutDataConvertible { return LayoutData(item: self, attributes: [.trailingMargin                          ]) }
    var centerXWithinMargin:     LayoutDataConvertible { return LayoutData(item: self, attributes: [.centerXWithinMargins                    ]) }
    var centerYWithinMargin:     LayoutDataConvertible { return LayoutData(item: self, attributes: [.centerYWithinMargins                    ]) }
}

public extension UIViewController {
    var topLayoutGuideTop:       LayoutDataConvertible { return LayoutData(item: topLayoutGuide,    attributes: [.top     ]) }
    var topLayoutGuideBottom:    LayoutDataConvertible { return LayoutData(item: topLayoutGuide,    attributes: [.bottom  ]) }
    var bottomLayoutGuideTop:    LayoutDataConvertible { return LayoutData(item: bottomLayoutGuide, attributes: [.top     ]) }
    var bottomLayoutGuideBottom: LayoutDataConvertible { return LayoutData(item: bottomLayoutGuide, attributes: [.bottom  ]) }
}
