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

	private func newObject() -> ManagedCache {
		ManagedCache(entity: ManagedCache.entity(), insertInto: context)
	}

	func delete(_ object: ManagedCache) {
		context.delete(object)
	}

	func fetchRequest() -> NSFetchRequest<ManagedCache> {
		ManagedCache.fetchRequest()
	}

	func cache() throws -> ManagedCache? {
		let fetchRequest = fetchRequest()
		let result = try context.fetch(fetchRequest)
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

	func rollback() {
		context.rollback()
	}
}
