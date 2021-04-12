//
//  NSObject_ext.swift
//  ShareIt
//
//  Created by zakaru on 22/03/2021.
//

import UIKit

extension Bundle {

	var displayName: String? {
		return object(forInfoDictionaryKey: "CFBundleDisplayName") as? String
	}

}

extension NSObject {

	static var name: String {
		return String(describing: self)
	}

	var name: String {
		return String(describing: self)
	}

	func log(_ msg: String) {
		Log.d(tag: name, msg: msg)
	}
	
}
