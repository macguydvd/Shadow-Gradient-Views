//
//  GaugeCoverView.swift
//  Coded Gauges
//
//  Created by Daniel Jensen on 6/9/19.
//  Copyright © 2019 Performance Audio. All rights reserved.
//

import UIKit

@IBDesignable
class GaugeCoverView: UIView {

	@IBOutlet weak var valueLabel: UILabel!
	@IBOutlet weak var weightLabel: UILabel!

	var coverColor = UIColor.black
	
	var dotColor = UIColor(red: 23.00 / 255.0, green: 242.0 / 255.0, blue: 254.0 / 255.0, alpha: 1)
	var dotWidth: CGFloat = 2
	
	var valueFont  = UIFont.init(name: "Roboto-Thin", size: 63)
	var valueColor = UIColor(red: 23.00 / 255.0, green: 242.0 / 255.0, blue: 254.0 / 255.0, alpha: 1)

	var weightFont  = UIFont.init(name: "Ubuntu-Light", size: 21)
	var weightColor = UIColor(red: 23.00 / 255.0, green: 242.0 / 255.0, blue: 254.0 / 255.0, alpha: 1)

	var value: CGFloat = 0 {
		didSet {
			valueLabel.text = String(Int(value))
		}
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setUp()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		setUp()
	}
	
	func deg2rad(_ number: CGFloat) -> CGFloat {
		return number * .pi / 180
	}
	
	func setUp() {
		self.clipsToBounds = false
		self.backgroundColor = .clear
	}
	
	func addLabels() {
		if let viewWithTag = self.viewWithTag(555) {
			viewWithTag.removeFromSuperview()
		}
		valueLabel.frame = self.frame.inset(by: UIEdgeInsets(top: 0,
															 left: 0,
															 bottom: self.frame.height/3,
															 right: 0))
		valueLabel.text = String(Int(value))
		valueLabel.tag = 555
		valueLabel.textColor = valueColor
		valueLabel.backgroundColor = .black
		valueLabel.textAlignment = .center
		valueLabel.font = valueFont
		self.addSubview(valueLabel)
		
		if let viewWithTag = self.viewWithTag(666) {
			viewWithTag.removeFromSuperview()
		}
		weightLabel.frame = self.frame.inset(by: UIEdgeInsets(top: self.frame.height/2,
															 left: 0,
															 bottom: 0,
															 right: 0))
		weightLabel.text = "dBA"
		weightLabel.tag = 666
		weightLabel.textColor = weightColor
		weightLabel.textAlignment = .center
		weightLabel.font = weightFont
		self.addSubview(weightLabel)
	}
	
	func drawTicks(in rect: CGRect, context ctx: CGContext) {
		ctx.saveGState()
		ctx.translateBy(x: rect.midX, y: rect.midY)
		let segmentAngle = deg2rad(5)
		let segmentRadius = (rect.width / 2) - (dotWidth/2)
		
		ctx.saveGState()
		ctx.setLineWidth(dotWidth)
		dotColor.set()
		let majorEnd = segmentRadius + (dotWidth / 2)
		let majorStart = majorEnd - dotWidth
		for _ in 0 ... 72 {
			ctx.move(to: CGPoint(x: majorStart, y: 0))
			ctx.fillEllipse(in: CGRect(x: majorEnd, y: 0, width: dotWidth, height: dotWidth))
			ctx.rotate(by: segmentAngle)
		}
		ctx.restoreGState()
		
		ctx.restoreGState()
		
		ctx.saveGState()
		let lineLength: CGFloat = (rect.width / 3) * 2
		let lineY: CGFloat = rect.origin.y + ((rect.height / 3) * 2)
		dotColor.set()
		ctx.setLineWidth(dotWidth/2)
		ctx.move(to: CGPoint(x: rect.midX - lineLength / 2, y: lineY))
		ctx.addLine(to: CGPoint(x: rect.midX + lineLength / 2, y: lineY))
		ctx.drawPath(using: .stroke)
		ctx.restoreGState()
	}
	/*
	func drawBackground(in rect: CGRect, context ctx: CGContext) {
		ctx.saveGState()
		let centerX = rect.width  / 2.0
		let centerY = rect.height
		let radius  = rect.height / 2.0
		let colors: [CGFloat] = [
			17.0 / 255.0, 17.0 / 255.0, 17.0 / 255.0, 1.0,
			34.0 / 255.0, 34.0 / 255.0, 34.0 / 255.0, 1.0
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
		//drawBackground(in: rect.insetBy(dx: dotWidth, dy: dotWidth), context: ctx)
		drawTicks(in: rect.insetBy(dx: dotWidth, dy: dotWidth), context: ctx)
	}

}
