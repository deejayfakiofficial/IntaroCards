//
//  CALayer+ApplyShadow.swift
//  
//
//  Created by Станислав Терентьев on 21.12.2022.
//

import UIKit

public extension CALayer {

    func applyCardShadow(_ shadow: Card.Shadow) {
        self.shadowColor = shadow.color?.cgColor
        self.shadowOffset = shadow.offset
        self.shadowOpacity = shadow.opacity
        self.shadowRadius = shadow.radius
    }

}
