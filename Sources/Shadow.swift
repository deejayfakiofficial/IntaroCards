//
//  Shadow.swift
//  
//
//  Created by Станислав Терентьев on 21.12.2022.
//

import UIKit

extension Card {
    
    public enum Shadow {
        
        case soft
        case large
        case medium
        case small
        case custom(color: UIColor, offset: CGSize, radius: CGFloat, opacity: Float)
        
        fileprivate var opacity: Float {
            switch self {
            case .soft: return 0.08
            case .custom(_,_,_, let opacity):
                return opacity
            default: return 0.16
            }
        }
        
        fileprivate var radius: CGFloat {
            switch self {
            case .large: return 32
            case .medium, .soft: return 16
            case .small: return 2
            case .custom(_, _, let radius, _):
                return radius
            }
        }
        
        fileprivate var offset: CGSize {
            switch self {
            case .small:
                return CGSize(width: 0, height: 2)
            case .medium, .soft:
                return CGSize(width: 0, height: 8)
            case .large:
                return CGSize(width: 0, height: 16)
            case .custom(_, let offset, _, _):
                return offset
            }
        }
        
        fileprivate var color: UIColor? {
            switch self {
            case .custom(let color, _, _, _):
                return color
            default: return UIColor(red: 30/255, green: 34/255, blue: 72/255, alpha: 1)
            }
        }
        
    }
    
    public func setShadow(_ shadow: Card.Shadow) {
        self.shadowColor = shadow.color
        self.shadowOffset = shadow.offset
        self.shadowRadius = shadow.radius
        self.shadowOpacity = shadow.opacity
    }
}
