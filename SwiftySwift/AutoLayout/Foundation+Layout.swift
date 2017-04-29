
import UIKit

extension Array where Element: UIView {
    var top:                   [LayoutDataConvertible] { return map { $0.top                    } }
    var bottom:                [LayoutDataConvertible] { return map { $0.bottom                 } }
    var leading:               [LayoutDataConvertible] { return map { $0.leading                } }
    var trailing:              [LayoutDataConvertible] { return map { $0.trailing               } }
    var leadingTrailing:       [LayoutDataConvertible] { return map { $0.leadingTrailing        } }
    var topBottom:             [LayoutDataConvertible] { return map { $0.topBottom              } }
    var cornerTL:              [LayoutDataConvertible] { return map { $0.cornerTL               } }
    var cornerTR:              [LayoutDataConvertible] { return map { $0.cornerTR               } }
    var cornerBL:              [LayoutDataConvertible] { return map { $0.cornerBL               } }
    var cornerBR:              [LayoutDataConvertible] { return map { $0.cornerBR               } }
    var edges:                 [LayoutDataConvertible] { return map { $0.edges                  } }
    var width:                 [LayoutDataConvertible] { return map { $0.width                  } }
    var height:                [LayoutDataConvertible] { return map { $0.height                 } }
    var size:                  [LayoutDataConvertible] { return map { $0.size                   } }
    var centerX:               [LayoutDataConvertible] { return map { $0.centerX                } }
    var centerY:               [LayoutDataConvertible] { return map { $0.centerY                } }
    var centerXY:              [LayoutDataConvertible] { return map { $0.centerXY               } }
    var firstBaseline:         [LayoutDataConvertible] { return map { $0.firstBaseline          } }
    var topMargin:             [LayoutDataConvertible] { return map { $0.topMargin              } }
    var bottomMargin:          [LayoutDataConvertible] { return map { $0.bottomMargin           } }
    var leadingMargin:         [LayoutDataConvertible] { return map { $0.leadingMargin          } }
    var trailingMargin:        [LayoutDataConvertible] { return map { $0.trailingMargin         } }
    var centerXWithinMargin:   [LayoutDataConvertible] { return map { $0.centerXWithinMargin    } }
    var centerYWithinMargin:   [LayoutDataConvertible] { return map { $0.centerYWithinMargin    } }
}
