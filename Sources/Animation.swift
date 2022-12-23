//
//  Animation.swift
//  
//
//  Created by Станислав Терентьев on 21.12.2022.
//

import UIKit

extension Card {
    
    public class Animation {

        public typealias AnimationClosure = ((_ card: Card, _ isReverced: Bool) -> Void)

        internal var animationBlock: AnimationClosure
        
        public static var highlight: Card.Animation { return .fade(to: 0.7) }

        fileprivate init(_ animationBlock: @escaping AnimationClosure) {
            self.animationBlock = animationBlock
        }
        
        fileprivate static func fade(to alpha: CGFloat, duration: TimeInterval = 0.15) -> Card.Animation {
            return Card.Animation({ (card, isReverced) in
                UIView.animate(withDuration: duration, delay: isReverced ? 0.05 : 0, options: [.beginFromCurrentState], animations: {
                    card.alpha =  isReverced ? 1 : alpha
                })
            })
        }
    }
}
