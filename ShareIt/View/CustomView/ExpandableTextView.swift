//
//  ExpandableTextView.swift
//  ShareIt
//
//  Created by zakaru on 26/03/2021.
//

import UIKit

class ExpandableTextView: UITextView {

	override func awakeFromNib() {
		super.awakeFromNib()

		let currentTextContainer = textContainer
		
		textContainer.maximumNumberOfLines = 4
		textContainer.lineBreakMode = .byTruncatingTail
	}
}
