//
//  UITextView.swift
//  ShareIt
//
//  Created by zakaru on 26/03/2021.
//

import UIKit

extension UITextView {

	// Massive credit to Dave Delong for his extensive help with this solution.
	/// Returns whether or not the `UITextView` is displaying truncated text. This includes text
	/// that is visually truncated with an ellipsis (...), and text that is simply cut off through
	/// word wrapping.
	///
	/// - Important:
	/// This only works properly when the `NSLineBreakMode` is set to `.byTruncatingTail` or `.byWordWrapping`.
	///
	/// - Remark:
	/// Calculation enumerates over all line fragments that the textview's LayoutManger generates
	/// and checks for the presence of the truncation glyph. If the textview's `NSLineBreakMode` is
	/// not set to `.byTruncatingTail` this calculation will be based on whether the textview's
	/// character content extends beyond its view frame.
	var isTextTruncated: Bool {
		var isTruncating = false

		// The `truncatedGlyphRange(...) method will tell us if text has been truncated
		// based on the line break mode of the text container
		layoutManager.enumerateLineFragments(forGlyphRange: NSRange(location: 0, length: Int.max)) { _, _, _, glyphRange, stop in
			let truncatedRange = self.layoutManager.truncatedGlyphRange(inLineFragmentForGlyphAt: glyphRange.lowerBound)
			if truncatedRange.location != NSNotFound {
				isTruncating = true
				stop.pointee = true
			}
		}

		// It's possible that the text is truncated not because of the line break mode,
		// but because the text is outside the drawable bounds
		if isTruncating == false {
			let glyphRange = layoutManager.glyphRange(for: textContainer)
			let characterRange = layoutManager.characterRange(forGlyphRange: glyphRange, actualGlyphRange: nil)

			isTruncating = characterRange.upperBound < text.utf16.count
		}

		return isTruncating
	}
	
}
