//
//  ItemCell.swift
//  ShareIt
//
//  Created by zakaru on 24/03/2021.
//

import UIKit

class ItemCell: UITableViewCell {

	@IBOutlet weak var mainView: BaseView!
	
	@IBOutlet weak var userImageView: BaseImageView!
	@IBOutlet weak var usernameLabel: UILabel!
	@IBOutlet weak var postInfoLabel: UILabel!
	
	@IBOutlet weak var itemDetailTextView: UITextView!
	@IBOutlet weak var imageContainerView: UIView!

	func loadImages(_ images: [UIImage]) {
		let _ = imageContainerView.subviews.map{ $0.removeFromSuperview() }

		let imgView = ImageContainerView(frame: CGRect(x: 0, y: 0,
													   width: imageContainerView.frame.width,
													   height: imageContainerView.frame.height),
										 images: images)

		imageContainerView.addSubViewAndMatchedBounds(imgView)
	}

}
