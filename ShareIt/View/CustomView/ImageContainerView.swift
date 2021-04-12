//
//  ImageContainerView.swift
//  ShareIt
//
//  Created by zakaru on 29/03/2021.
//

import UIKit

protocol ImageContainerViewDelegate: AnyObject {

	func layoutParentViewIfNeeded()

}

class ImageContainerView: BaseView {

	weak var delegate: ImageContainerViewDelegate?

	private struct ViewConstant {
		static let maxImageLength = 4
		static let dividerWidth: CGFloat = 8
		static let defaultSpace: CGFloat = 2
	}

	private let images: [UIImage]

	override init(frame: CGRect) {
		self.images = [UIImage]()

		super.init(frame: frame)

		initialize()
	}

	required init?(coder: NSCoder) {
		self.images = [UIImage]()

		super.init(coder: coder)

		initialize()
	}

	init(frame: CGRect, images: [UIImage]) {
		self.images = images

		super.init(frame: frame)

		initialize()
	}

	override func initialize() {
		// remove all subviews in this view
		let _ = subviews.map{ $0.removeFromSuperview() }

		guard let firstImg = images.first else { return }

		radius = Theme.radius

		translatesAutoresizingMaskIntoConstraints = false

		let imgCount = images.count
		let expandable = imgCount > ViewConstant.maxImageLength

		switch imgCount {
		case 1:
			layoutFullImage(firstImg)

		case 2:
			layoutTwoImages(images)

		case 3:
			layoutThreeImages(images)

		default:
			layoutFourImages(images, expandable: expandable)
		}

		delegate?.layoutParentViewIfNeeded()
	}

	private func layoutFullImage(_ image: UIImage) {
		let imgView = BaseImageView.aspectFillImageViewFor(image)
		imgView.radius = Theme.radius

		let heightConstraint = NSLayoutConstraint(item: imgView,
												  attribute: .height,
												  relatedBy: .equal,
												  toItem: nil,
												  attribute: .height,
												  multiplier: 1.0,
												  constant: frame.width)
		imgView.addConstraint(heightConstraint)

		addSubViewAndMatchedBounds(imgView)
	}

	private func layoutTwoImages(_ images: [UIImage]) {
		let stackView = UIStackView(frame: CGRect.zero)
		stackView.axis = .horizontal
		stackView.distribution = .fillEqually
		stackView.spacing = ViewConstant.defaultSpace

		addSubViewAndMatchedBounds(stackView)

		let firstImgView = BaseImageView.aspectFillImageViewFor(images[0])
		let secondImgView = BaseImageView.aspectFillImageViewFor(images[1])

		stackView.addArrangedSubview(firstImgView)
		stackView.addArrangedSubview(secondImgView)

		let scaledH = (frame.width - ViewConstant.defaultSpace) / 2

		let heightConstraint = NSLayoutConstraint(item: stackView,
												  attribute: .height,
												  relatedBy: .equal,
												  toItem: nil,
												  attribute: .height,
												  multiplier: 1.0,
												  constant: scaledH)
		stackView.addConstraint(heightConstraint)
	}

	private func layoutThreeImages(_ images: [UIImage]) {
		let stackView = UIStackView(frame: CGRect.zero)
		stackView.axis = .vertical
		stackView.distribution = .equalSpacing
		stackView.spacing = ViewConstant.defaultSpace

		let hStackView = UIStackView(frame: CGRect.zero)
		hStackView.axis = .horizontal
		hStackView.distribution = .fillEqually
		hStackView.spacing = ViewConstant.defaultSpace

		let minSize = (frame.width - ViewConstant.defaultSpace) / 2

		hStackView.addConstraint(NSLayoutConstraint(item: hStackView,
													attribute: .height,
													relatedBy: .equal,
													toItem: .none,
													attribute: .height,
													multiplier: 1.0,
													constant: minSize))

		addSubViewAndMatchedBounds(stackView)

		let firstImgView = BaseImageView.aspectFillImageViewFor(images[0])
		let secondImgView = BaseImageView.aspectFillImageViewFor(images[1])
		let thirdImgView = BaseImageView.aspectFillImageViewFor(images[2])

		stackView.addArrangedSubview(firstImgView)
		stackView.addArrangedSubview(hStackView)
		hStackView.addArrangedSubview(secondImgView)
		hStackView.addArrangedSubview(thirdImgView)

		let contentHeight = frame.width + ViewConstant.defaultSpace + minSize

		let heightConstraint = NSLayoutConstraint(item: stackView,
												  attribute: .height,
												  relatedBy: .equal,
												  toItem: nil,
												  attribute: .height,
												  multiplier: 1.0,
												  constant: contentHeight)

		stackView.addConstraint(heightConstraint)
	}

	private func layoutFourImages(_ images: [UIImage], expandable: Bool) {
		let stackView = UIStackView(frame: CGRect.zero)
		stackView.axis = .vertical
		stackView.distribution = .equalSpacing
		stackView.spacing = ViewConstant.defaultSpace

		let hStackView = UIStackView(frame: CGRect.zero)
		hStackView.axis = .horizontal
		hStackView.distribution = .fillEqually
		hStackView.spacing = ViewConstant.defaultSpace

		let minSize = (frame.width - ViewConstant.defaultSpace * 2) / 3

		hStackView.addConstraint(NSLayoutConstraint(item: hStackView,
													attribute: .height,
													relatedBy: .equal,
													toItem: .none,
													attribute: .height,
													multiplier: 1.0,
													constant: minSize))

		addSubViewAndMatchedBounds(stackView)

		let firstImgView = BaseImageView.aspectFillImageViewFor(images[0])
		let secondImgView = BaseImageView.aspectFillImageViewFor(images[1])
		let thirdImgView = BaseImageView.aspectFillImageViewFor(images[2])
		let fourImageView = BaseImageView.aspectFillImageViewFor(images[3])

		let lastImgViewContainer = UIView(frame: .zero)
		lastImgViewContainer.addSubViewAndMatchedBounds(fourImageView)

		if expandable {
			fourImageView.applyBlurEffect(0.69)

			let plusCount = images.count - ViewConstant.maxImageLength
			let plusView = getPlusView(count: plusCount, height: 50)
			lastImgViewContainer.addSubview(plusView)
			lastImgViewContainer.addConstraints(
				NSLayoutConstraint.constraints(withVisualFormat: "H:|[plusView]|",
											   options: .alignAllCenterX,
											   metrics: nil,
											   views: ["plusView": plusView]))
			lastImgViewContainer.addConstraint(
				NSLayoutConstraint(item: lastImgViewContainer,
								   attribute: .centerY,
								   relatedBy: .equal,
								   toItem: plusView,
								   attribute: .centerY,
								   multiplier: 1.0, constant: 0))
		}

		stackView.addArrangedSubview(firstImgView)
		stackView.addArrangedSubview(hStackView)
		hStackView.addArrangedSubview(secondImgView)
		hStackView.addArrangedSubview(thirdImgView)
		hStackView.addArrangedSubview(lastImgViewContainer)

		let contentHeight = frame.width + ViewConstant.defaultSpace + minSize

		let heightConstraint = NSLayoutConstraint(item: stackView,
												  attribute: .height,
												  relatedBy: .equal,
												  toItem: nil,
												  attribute: .height,
												  multiplier: 1.0,
												  constant: contentHeight)

		stackView.addConstraint(heightConstraint)
	}

	private func getPlusView(count: Int, height: CGFloat = 50) -> UIView {
		let container = UIStackView(frame: .zero)
		container.translatesAutoresizingMaskIntoConstraints = false
		container.spacing = 0
		container.alignment = .center
		container.distribution = .fillEqually

		let plusLabel = UILabel(frame: .zero)
		plusLabel.text = "+"
		plusLabel.font = UIFont.appFontOfSize(40)
		plusLabel.textAlignment = .right
		plusLabel.textColor = UIColor.white.withAlphaComponent(0.9)

		let textLabel = UILabel(frame: .zero)
		textLabel.text = String(count)
		textLabel.font = UIFont.appFontOfSize(45)
		textLabel.textAlignment = .left
		textLabel.textColor = UIColor.white.withAlphaComponent(0.9)

		container.addArrangedSubview(plusLabel)
		container.addArrangedSubview(textLabel)

		container.addConstraint(NSLayoutConstraint(item: container,
												   attribute: .height,
												   relatedBy: .equal,
												   toItem: nil,
												   attribute: .height,
												   multiplier: 1.0,
												   constant: height))
		return container
	}

}
