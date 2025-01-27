//
//  ManagedCacheStore.swift
//  FeedStoreChallenge
//
//  Created by Istvan Private on 14.06.21.
//  Copyright © 2021 Essential Developer. All rights reserved.
//

import Foundation
import CoreData

class ManagedCacheStore {
	private let context: NSManagedObjectContext

	init(context: NSManagedObjectContext) {
		self.context = context
	}

	func cache() throws -> ManagedCache? {
		let newFetchRequest = fetchRequest()
		let result = try context.fetch(newFetchRequest)
		return result.first
	}

	func existingCacheOrNewOne() throws -> ManagedCache {
		return try cache() ?? newObject()
	}

	func save() throws {
		if context.hasChanges {
			try context.save()
		}
	}

	func delete(_ object: ManagedCache) {
		context.delete(object)
	}

	func rollback() {
		context.rollback()
	}
}

private extension ManagedCacheStore {
	func fetchRequest() -> NSFetchRequest<ManagedCache> {
		ManagedCache.fetchRequest()
	}

	func newObject() -> ManagedCache {
		ManagedCache(entity: ManagedCache.entity(), insertInto: context)
	}
}
