//
//  ShadowView.swift
//  ShareIt
//
//  Created by zakaru on 25/03/2021.
//

import UIKit

class ShadowView: BaseView {

	override var bounds: CGRect {
		didSet {
			setupShadow()
		}
	}

	private func setupShadow() {
		layer.cornerRadius = Theme.radius
		layer.shadowOffset = CGSize(width: 0, height: 1)
		layer.shadowRadius = 4
		layer.shadowOpacity = 0.2
		layer.shadowPath = UIBezierPath(roundedRect: bounds,
										byRoundingCorners: .allCorners,
										cornerRadii: CGSize(width: 8, height: 8)).cgPath
		layer.shouldRasterize = true
		layer.rasterizationScale = UIScreen.main.scale
	}

}
