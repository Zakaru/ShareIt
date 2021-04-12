//
//  Observer.swift
//  ShareIt
//
//  Created by zakaru on 23/03/2021.
//

import Foundation

class ObservedValue<T> {

//	typealias CompletionHandler = ((T) -> Void)
//
//	var value : T {
//		didSet {
//			DispatchQueue.main.async {
//				self.notify()
//			}
//		}
//	}
//
//	private var observers = [String: CompletionHandler]()
//
//	deinit {
//		observers.removeAll()
//	}
//
//	init(_ value: T) {
//		self.value = value
//	}
//
//	public func addObserver(_ observer: NSObject,
//							completionHandler: @escaping CompletionHandler) {
//		observers[observer.description] = completionHandler
//	}
//
//	public func addObserverAndNotify(_ observer: NSObject,
//									 completionHandler: @escaping CompletionHandler) {
//		addObserver(observer, completionHandler: completionHandler)
//		notify()
//	}
//
//	/// If the ObservedValue is used in a Singleton.
//	/// Must call this when the observer object is destroyed
//	public func removeObserver(_ observer: NSObject) {
//		observers.removeValue(forKey: observer.description)
//	}
//
//	private func notify() {
//		observers.forEach({ $0.value(value) })
//	}
	
}
