//
//  ManagedFeedImageStore.swift
//  FeedStoreChallenge
//
//  Created by Istvan Private on 14.06.21.
//  Copyright © 2021 Essential Developer. All rights reserved.
//

import Foundation
import CoreData

class ManagedFeedImageStore {
	private let context: NSManagedObjectContext

	init(context: NSManagedObjectContext) {
		self.context = context
	}

	func feedImage(from feed: LocalFeedImage) -> ManagedFeedImage {
		let managedFeedImage = newObject()
		managedFeedImage.id = feed.id
		managedFeedImage.descriptionString = feed.description
		managedFeedImage.location = feed.location
		managedFeedImage.url = feed.url
		return managedFeedImage
	}

	private func newObject() -> ManagedFeedImage {
		ManagedFeedImage(entity: ManagedFeedImage.entity(), insertInto: context)
	}
}
