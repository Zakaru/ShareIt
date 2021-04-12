//
//  UIView_Ext.swift
//  ShareIt
//
//  Created by zakaru on 23/03/2021.
//

import UIKit

extension UIView {

	/// Adding a sub view to this view and matched the view's bounds
	func addSubViewAndMatchedBounds(_ subView: UIView) {
		subView.translatesAutoresizingMaskIntoConstraints = false

		addSubview(subView)
		addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[subView]|",
													  options: .alignAllCenterX,
													  metrics: nil,
													  views: ["subView": subView]))
		addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[subView]|",
													  options: .alignAllCenterY,
													  metrics: nil,
													  views: ["subView": subView]))
	}

	/// Adding shadow layer to this view itself,
	/// return the newly added shadow layer
	func makeShadowLayer(background: UIColor,
						 shadowRadius: CGFloat = Theme.radius,
						 shadowColor: UIColor = Theme.shadowColor,
						 shadowOpacity: Float = 1.0,
						 cornerRadius: CGFloat = Theme.radius,
						 shadowWidth: CGFloat,
						 shadowHeight: CGFloat) -> CAShapeLayer {
		let shadowLayer = CAShapeLayer()
		shadowLayer.fillColor = background.cgColor
		shadowLayer.shadowColor = shadowColor.cgColor
		shadowLayer.shadowOffset = CGSize(width: shadowWidth, height: shadowHeight)
		shadowLayer.shadowOpacity = shadowOpacity
		shadowLayer.shadowRadius = shadowRadius
		shadowLayer.cornerRadius = cornerRadius
		shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
		shadowLayer.shadowPath = shadowLayer.path

		return shadowLayer
	}

	static func getSubviewsOf<T : UIView>(view: UIView) -> [T] {
		var subviews = [T]()

		for subview in view.subviews {
			subviews += getSubviewsOf(view: subview) as [T]

			if let subview = subview as? T {
				subviews.append(subview)
			}
		}

		return subviews
	}

}
