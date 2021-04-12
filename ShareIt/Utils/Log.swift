//
//  Logger.swift
//  ShareIt
//
//  Created by zakaru on 22/03/2021.
//

import Foundation

struct Log {

	enum LogLevel: Int {
		case Debug = 1
		case Info
		case Error
	}

	static let logLevel = LogLevel.Debug

	static func d(tag: String, msg: String) {
		guard Env.isDebug else {
			return
		}

		guard logLevel == LogLevel.Debug else {
			return
		}

		print("[\(tag)] \(msg)")
	}
	
}
