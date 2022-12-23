//
//  Card.swift
//  
//
//  Created by Станислав Терентьев on 21.12.2022.
//

import UIKit

open class Card: UIView, UIGestureRecognizerDelegate {

    public typealias TapHandler = () -> Void

    open var animation: Animation?

    open var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }

    open var shadowColor: UIColor? {
        get {
            if let shadowColor = layer.shadowColor {
                return UIColor(cgColor: shadowColor)
            }
            return nil
        }
        set {
            layer.shadowColor = newValue?.cgColor
        }
    }
    
    open var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    open var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    open var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            containerView.layer.cornerRadius = newValue
        }
    }

    public let containerView = UIView()
    
    public var tapHandler: TapHandler?
    public var tapBeginHandler: TapHandler?
    public var forwardTouchesToSuperview: Bool = true

    private var isTouched: Bool = false
    private let recognizer = UIGestureRecognizer()
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configure()
    }
    
    private func configure() {
        layer.masksToBounds = false
        if #available(iOS 13.0, *) {
            layer.cornerCurve = .continuous
            containerView.layer.cornerCurve = .continuous
        }
        clipsToBounds = false
        isExclusiveTouch = true
        isUserInteractionEnabled = true
        configureRecognizer()
        configureContainer()
        moveSubviews()
    }

    private func configureRecognizer() {
        recognizer.delaysTouchesBegan = false
        recognizer.delegate = self
        recognizer.cancelsTouchesInView = false
        addGestureRecognizer(recognizer)
    }

    private func configureContainer() {
        containerView.clipsToBounds = true
        containerView.backgroundColor = .clear
        containerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(self.containerView)

        NSLayoutConstraint.activate([
            .init(item: self.containerView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0),
            .init(item: self.containerView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0),
            .init(item: self.containerView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0),
            .init(item: self.containerView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0)
        ])
    }

    private func moveSubviews() {
        subviews
            .filter({ $0 != containerView })
            .forEach(containerView.addSubview)
    }
    
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        isTouched = true
        tapBeginHandler?()
        animation?.animationBlock(self, false)
        if forwardTouchesToSuperview {
            super.touchesBegan(touches, with: event)
        }
    }

    open override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        if let touch = touches.first, !containerView.frame.contains(touch.location(in: containerView)) {
            resetAnimation(handler: nil)
        }
    }

    override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        resetAnimation(handler: self.tapHandler)
        super.touchesEnded(touches, with: event)
    }

    override open func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        resetAnimation(handler: nil)
        super.touchesCancelled(touches, with: event)
    }

    private func resetAnimation(handler: Card.TapHandler?) {

        defer {
            isTouched = false
        }

        guard isTouched else { return }

        guard let animation = animation else {
            handler?()
            return
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05, execute: {
            handler?()
        })
        animation.animationBlock(self, true)
    }
}
