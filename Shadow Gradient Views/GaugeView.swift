//
//  GaugeView.swift
//  Coded Gauges
//
//  Created by Daniel Jensen on 6/9/19.
//  Copyright © 2019 Performance Audio. All rights reserved.
//

import UIKit

@IBDesignable
class GaugeView: UIView {

	var gaugeColor = UIColor.black
	
	var segmentWidth: CGFloat = 2.5
	var segmentColors = [
		UIColor(red: 0, green: 0.5, blue: 0, alpha: 1),
		UIColor(red: 0, green: 0.5, blue: 0, alpha: 1),
		UIColor(red: 0, green: 0.5, blue: 0, alpha: 1),
		UIColor(red: 0, green: 0.5, blue: 0, alpha: 1),
		UIColor(red: 0, green: 0.5, blue: 0, alpha: 1),
		UIColor(red: 0, green: 0.5, blue: 0, alpha: 1),
		UIColor(red: 0, green: 0.5, blue: 0, alpha: 1),
		UIColor(red: 0, green: 0.5, blue: 0, alpha: 1),
		UIColor(red: 0, green: 0.5, blue: 0, alpha: 1),
		UIColor(red: 0, green: 0.5, blue: 0, alpha: 1),
		UIColor(red: 0, green: 0.5, blue: 0, alpha: 1),
		UIColor(red: 0, green: 0.5, blue: 0, alpha: 1),
		UIColor(red: 0, green: 0.5, blue: 0, alpha: 1),
		UIColor(red: 0, green: 0.5, blue: 0, alpha: 1),
		UIColor(red: 0, green: 0.5, blue: 0, alpha: 1),
		UIColor(red: 0, green: 0.5, blue: 0, alpha: 1),
		UIColor(red: 0, green: 0.5, blue: 0, alpha: 1),
		UIColor(red: 0.7, green: 0, blue: 0, alpha: 1),
		UIColor(red: 0.7, green: 0, blue: 0, alpha: 1),
		UIColor(red: 0.7, green: 0, blue: 0, alpha: 1),
		UIColor(red: 0.7, green: 0, blue: 0, alpha: 1),
		UIColor(red: 0.7, green: 0, blue: 0, alpha: 1),
		UIColor(red: 0.7, green: 0, blue: 0, alpha: 1),
		UIColor(red: 0.7, green: 0, blue: 0, alpha: 1),
		UIColor(red: 0.7, green: 0, blue: 0, alpha: 1),
		UIColor(red: 0.7, green: 0, blue: 0, alpha: 1)
	]
	
	var totalAngle: CGFloat = 270.0
	var rotation: CGFloat = -135.0
	
	var majorTickColor = UIColor(red: 23.00 / 255.0, green: 242.0 / 255.0, blue: 254.0 / 255.0, alpha: 1)
	var majorTickWidth: CGFloat = 2
	var majorTickLength: CGFloat = 10
	
	var minorTickColor = UIColor(red: 23.00 / 255.0, green: 242.0 / 255.0, blue: 254.0 / 255.0, alpha: 0.5)
	var minorTickWidth: CGFloat = 1
	var minorTickLength: CGFloat = 5
	var minorTickCount = 4
		
	var needleColor = UIColor(red: 23.00 / 255.0, green: 242.0 / 255.0, blue: 254.0 / 255.0, alpha: 1)
	var needleWidth: CGFloat = 3
	let needle = GaugeNeedleView()

	var value: CGFloat = 0 {
		didSet {
			let needlePosition = value / 130.0
			let lerpFrom = rotation
			let lerpTo = rotation + totalAngle
			let needleRotation = lerpFrom + (lerpTo - lerpFrom) * needlePosition
			needle.transform = CGAffineTransform(rotationAngle: deg2rad(needleRotation))
			needle.center = CGPoint(x: bounds.midX, y: bounds.midY)
		}
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.clipsToBounds = false
		self.layer.masksToBounds = false
		self.backgroundColor = .clear
		setUp()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		self.clipsToBounds = false
		self.layer.masksToBounds = false
		self.backgroundColor = .clear
		setUp()
	}
	
	func deg2rad(_ number: CGFloat) -> CGFloat {
		return number * .pi / 180
	}
	
	func setUp() {
		self.clipsToBounds = false
		self.layer.masksToBounds = false
		self.backgroundColor = .clear
		if let viewWithTag = self.viewWithTag(177) {
			viewWithTag.removeFromSuperview()
		}
		needle.backgroundColor = needleColor
		needle.translatesAutoresizingMaskIntoConstraints = false
		needle.bounds = CGRect(x: 0, y: 0, width: needleWidth, height: (self.bounds.height / 5) * 2)
		needle.layer.anchorPoint = CGPoint(x: 0.5, y: 1)
		needle.center = CGPoint(x: bounds.midX, y: bounds.midY)
		needle.tag = 177
		addSubview(needle)
		self.setNeedsDisplay()
	}
	
	func drawLabels(in rect: CGRect, context ctx: CGContext) {
		let labelWidth : CGFloat  = 26.0
		let labelHeight : CGFloat = 12.0
		let labelHalfWidth = labelWidth / 2
		let labelHalfHeight = labelHeight / 2
		let labelAngle = totalAngle / CGFloat(segmentColors.count)

		for index in 0...segmentColors.count {
			for item in self.layer.sublayers! {
				if item.name == "\(index)" {
					item.removeFromSuperlayer()
					item.removeAllAnimations()
				}
			}
			let start = CGFloat(index) * labelAngle - rotation
			let segmentRadius = ((rect.width - majorTickLength - 7) / 2)
			let label = CATextLayer()
			label.string = "\(index * 5)"
			if (index * 5 >= 100) {
				label.alignmentMode = .left
			} else {
				label.alignmentMode = .center
			}
			label.name = "\(index)"
			label.font = UIFont.init(name: "Ubuntu-Bold", size: 12)
			label.fontSize = 12
			label.foregroundColor = UIColor.white.cgColor
			label.backgroundColor = UIColor.clear.cgColor
			label.contentsScale = UIScreen.main.scale
			label.frame = CGRect(origin: CGPoint(x: rect.midX - labelHalfWidth,
												 y: rect.midY - labelHalfHeight),
								 size: CGSize(width: labelWidth, height: labelHeight))
			label.transform = CATransform3DRotate(label.transform, deg2rad(start), 0.0, 0.0, 1.0);
			label.transform = CATransform3DTranslate(label.transform, 0, segmentRadius, 0)
			label.transform = CATransform3DTranslate(label.transform, segmentRadius, -segmentRadius, 0)
			label.transform = CATransform3DRotate(label.transform, deg2rad(-start), 0.0, 0.0, 1.0);
			self.layer.addSublayer(label)
		}
		
	}

	func drawTicks(in rect: CGRect, context ctx: CGContext) {
		ctx.saveGState()
		ctx.translateBy(x: rect.midX, y: rect.midY)
		ctx.rotate(by: deg2rad(rotation) - (.pi / 2))
		let segmentAngle = deg2rad(totalAngle / CGFloat(segmentColors.count))
		let segmentRadius = ((rect.width - segmentWidth) / 2)

		ctx.saveGState()
		ctx.setLineWidth(majorTickWidth)
		majorTickColor.set()
		let majorEnd = segmentRadius + (segmentWidth / 2) + (majorTickLength / 2)
		let majorStart = majorEnd - majorTickLength
		for _ in 0 ... segmentColors.count {
			ctx.move(to: CGPoint(x: majorStart, y: 0))
			ctx.addLine(to: CGPoint(x: majorEnd, y: 0))
			ctx.drawPath(using: .stroke)
			ctx.rotate(by: segmentAngle)
		}
		ctx.restoreGState()

		ctx.saveGState()
		ctx.setLineWidth(minorTickWidth)
		minorTickColor.set()
		let minorEnd = segmentRadius + (segmentWidth / 2) + (minorTickLength / 2)
		let minorStart = minorEnd - minorTickLength
		let minorTickSize = segmentAngle / CGFloat(minorTickCount + 1)
		for _ in 0 ..< segmentColors.count {
			ctx.rotate(by: minorTickSize)
			for _ in 0 ..< minorTickCount {
				ctx.move(to: CGPoint(x: minorStart, y: 0))
				ctx.addLine(to: CGPoint(x: minorEnd, y: 0))
				ctx.drawPath(using: .stroke)
				ctx.rotate(by: minorTickSize)
			}
		}
		ctx.restoreGState()
		
		ctx.restoreGState()
	}
	
	func drawSegments(in rect: CGRect, context ctx: CGContext) {
		ctx.saveGState()
		ctx.translateBy(x: rect.midX, y: rect.midY)
		ctx.rotate(by: deg2rad(rotation) - (.pi / 2))
		ctx.setLineWidth(segmentWidth)
		let segmentAngle = deg2rad(totalAngle / CGFloat(segmentColors.count))
		let segmentRadius = ((rect.width - segmentWidth) / 2) + 1.25
		for (index, segment) in segmentColors.enumerated() {
			let start = CGFloat(index) * segmentAngle
			segment.set()
			ctx.addArc(center: .zero, radius: segmentRadius, startAngle: start, endAngle: start + segmentAngle, clockwise: false)
			ctx.drawPath(using: .stroke)
		}
		ctx.restoreGState()
	}
	/*
	func drawBackground(in rect: CGRect, context ctx: CGContext) {
		ctx.saveGState()
		gaugeColor.set()
		ctx.fillEllipse(in: rect)
		let centerX = rect.width  / 2.0
		let centerY = rect.height / 2.0
		let radius  = rect.height / 2.0
		let colors: [CGFloat] = [
			34.0 / 255.0, 34.0 / 255.0, 34.0 / 255.0, 1.0,
			17.0 / 255.0, 17.0 / 255.0, 17.0 / 255.0, 1.0
		]
		let colorSpace = CGColorSpaceCreateDeviceRGB()
		let gradient: CGGradient = CGGradient(colorSpace: colorSpace,
											  colorComponents: colors,
											  locations: nil,
											  count: 2)!
		ctx.addEllipse(in: rect)
		ctx.clip()
		let gradientStart: CGPoint = CGPoint(x: centerX, y: centerY - radius);
		let gradientEnd: CGPoint   = CGPoint(x: centerX, y: centerY + radius);
		ctx.drawLinearGradient(gradient, start: gradientStart, end: gradientEnd, options: .drawsBeforeStartLocation)
		ctx.restoreGState()
	}
	*/
	override func draw(_ rect: CGRect) {
		guard let ctx = UIGraphicsGetCurrentContext() else { return }
		let inset = majorTickLength / 2
		//drawBackground(in: rect.insetBy(dx: inset, dy: inset), context: ctx)
		drawSegments(in: rect.insetBy(dx: inset, dy: inset), context: ctx)
		drawTicks(in: rect.insetBy(dx: inset, dy: inset), context: ctx)
		drawLabels(in: rect.insetBy(dx: inset, dy: inset), context: ctx)
		needle.center = CGPoint(x: bounds.midX, y: bounds.midY)
	}

}
