//
//  GaugeNeedleView.swift
//  Coded Gauges
//
//  Created by Daniel Jensen on 6/10/19.
//  Copyright © 2019 Performance Audio. All rights reserved.
//

import UIKit

class GaugeNeedleView: UIView {

	override init(frame: CGRect) {
		super.init(frame: frame)
		setup()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		setup()
	}

	func setup() {
		self.layer.cornerRadius = self.bounds.width / 2
	}

}
