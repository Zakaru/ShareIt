//
//  UIImageExt.swift
//  ShareIt
//
//  Created by zakaru on 31/03/2021.
//

import UIKit

extension BaseImageView {

	static func aspectFillImageViewFor(_ image: UIImage,
									   cornerRadius: CGFloat = 0) -> BaseImageView {
		let imageView = BaseImageView(image: image)
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode = .scaleAspectFill
		imageView.radius = cornerRadius

		return imageView
	}

	func applyBlurEffect(_ alpha: CGFloat = 1.0) {
		let blurEffect = UIBlurEffect(style: .dark)
		let blurEffectView = UIVisualEffectView(effect: blurEffect)
		blurEffectView.frame = bounds
		blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		blurEffectView.alpha = alpha
		addSubview(blurEffectView)
	}

}
