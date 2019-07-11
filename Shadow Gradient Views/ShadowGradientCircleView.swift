//
//  ShadowGradientRectView.swift
//  Shadow Gradient Views
//
//  Created by Daniel Jensen on 6/23/19.
//  Copyright © 2019 Performance Audio. All rights reserved.
//

import UIKit

@IBDesignable
class ShadowGradientCircleView: UIView {
	
	var innerView: UIView = UIView()
	
	@IBInspectable var topColor: UIColor = .black {
		didSet {
			setNeedsDisplay()
		}
	}
	@IBInspectable var bottomColor: UIColor = .white {
		didSet {
			setNeedsDisplay()
		}
	}
	@IBInspectable var shadowColor: UIColor = .black {
		didSet {
			setNeedsDisplay()
		}
	}
	@IBInspectable var shadowOpacity: Float = 1.0 {
		didSet {
			setNeedsDisplay()
		}
	}
	@IBInspectable var shadowOffset: CGSize = .zero {
		didSet {
			setNeedsDisplay()
		}
	}
	@IBInspectable var shadowRadius: CGFloat = 10.0 {
		didSet {
			setNeedsDisplay()
		}
	}
	override var bounds: CGRect {
		didSet {
			setNeedsDisplay()
		}
	}

	override init(frame: CGRect) {
		super.init(frame: frame)
		addSubview(innerView)
		setNeedsDisplay()
	}
	
	required init(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)!
		addSubview(innerView)
		setNeedsDisplay()
	}

	func drawShadow() {
		innerView.bounds = bounds
		innerView.frame.origin = CGPoint(x: 0, y: 0)
		innerView.clipsToBounds = true
		innerView.layer.masksToBounds = true
		innerView.layer.cornerRadius = bounds.width / 2
		setGradientBackground(colorTop: topColor, colorBottom: bottomColor)
		
		clipsToBounds = true
		layer.masksToBounds = false
		layer.cornerRadius = bounds.width / 2
		layer.shadowColor = shadowColor.cgColor
		layer.shadowOpacity = shadowOpacity
		layer.shadowOffset = shadowOffset
		layer.shadowRadius = shadowRadius
		layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: bounds.width / 2).cgPath
		layer.shouldRasterize = false
	}
	
	func setGradientBackground(colorTop: UIColor, colorBottom: UIColor) {
		let gradientLayer = CAGradientLayer()
		gradientLayer.colors = [colorBottom.cgColor, colorTop.cgColor]
		gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
		gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
		gradientLayer.locations = [0, 1]
		gradientLayer.frame = bounds
		
		innerView.layer.insertSublayer(gradientLayer, at: 0)
	}

	// Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
		drawShadow()
    }

}
