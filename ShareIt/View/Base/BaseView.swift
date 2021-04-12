//
//  BaseView.swift
//  ShareIt
//
//  Created by zakaru on 22/03/2021.
//

import UIKit

@IBDesignable
class BaseView: UIView {

	@IBInspectable var radius: CGFloat = 8 {
		didSet {
			layer.cornerRadius = radius
			clipsToBounds = true
		}
	}

	internal var shadowLayer: CAShapeLayer?

	private var scaleFactor: CGFloat = 0.95

	// MARK: Init methods

	override init(frame: CGRect) {
		super.init(frame: frame)

		initialize()
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)

		initialize()
	}

	internal func initialize() {

	}

	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		super.touchesBegan(touches, with: event)

		reponseTouch()
	}

	override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
		super.touchesEnded(touches, with: event)

		restoreViewState()
	}

	override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
		super.touchesCancelled(touches, with: event)

		restoreViewState()
	}

	private func reponseTouch() {
		UIView.animate(withDuration: Theme.duration,
					   delay: 0,
					   options: UIView.AnimationOptions.curveEaseIn) {
			self.transform = CGAffineTransform(scaleX: self.scaleFactor, y: self.scaleFactor)
		} completion: { _ in
//			self.transform = CGAffineTransform(scaleX: self.scaleFactor, y: self.scaleFactor)
		}

	}

	private func restoreViewState() {
		UIView.animate(withDuration: Theme.duration / 1.5,
					   delay: 0,
					   usingSpringWithDamping: 2.0,
					   initialSpringVelocity: 0.0,
					   options: [.allowAnimatedContent, .allowUserInteraction]) {
			self.transform = CGAffineTransform.identity
		}
	}

}

// MARK: - BaseView's Public methods

extension BaseView {

	/// Adding a new customized shadow layer on this view
	func addShadowLayer(background: UIColor = .white,
						shadowWidth: CGFloat = Theme.shadowSize.width,
						shadowHeight: CGFloat = Theme.shadowSize.height) {
		guard shadowLayer == nil else { return }

		let shadow = makeShadowLayer(background: background,
									 shadowWidth: shadowWidth,
									 shadowHeight: shadowHeight)
		shadowLayer = shadow
		layer.insertSublayer(shadow, at: 0)
		clipsToBounds = false
	}

	/// Removing this current shadow layer of this view
	func removeShadowLayer() {
		shadowLayer?.removeFromSuperlayer()
		shadowLayer = nil
	}

}

// MARK: - BaseImageView

@IBDesignable
class BaseImageView: UIImageView {

	@IBInspectable var radius: CGFloat = 8 {
		didSet {
			layer.cornerRadius = radius
			clipsToBounds = true
		}
	}

}
