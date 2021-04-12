//
//  BaseCollectionViewCell.swift
//  ShareIt
//
//  Created by zakaru on 22/03/2021.
//

import UIKit

class HeadlineCell: UICollectionViewCell {

	@IBOutlet weak var imageView: BaseImageView!

	override func awakeFromNib() {
		super.awakeFromNib()

		imageView.radius = 8.0
    }

}
