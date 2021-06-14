//
//  Copyright © 2021 Essential Developer. All rights reserved.
//

import CoreData

public final class CoreDataFeedStore: FeedStore {
	private static let modelName = "FeedStore"
	private static let model = NSManagedObjectModel(name: modelName, in: Bundle(for: CoreDataFeedStore.self))

	private let container: NSPersistentContainer
	private let context: NSManagedObjectContext

	struct ModelNotFound: Error {
		let modelName: String
	}

	public init(storeURL: URL) throws {
		guard let model = CoreDataFeedStore.model else {
			throw ModelNotFound(modelName: CoreDataFeedStore.modelName)
		}

		container = try NSPersistentContainer.load(
			name: CoreDataFeedStore.modelName,
			model: model,
			url: storeURL
		)
		context = container.newBackgroundContext()
	}

	public func retrieve(completion: @escaping RetrievalCompletion) {
		let context = context
		context.perform {
			let fetchRequest: NSFetchRequest<ManagedCache> = ManagedCache.fetchRequest()
			do {
				let caches = try context.fetch(fetchRequest)
				if let cache = caches.first {
					let localFeedImages = cache.feedImages.map { $0.localFeedImage }
					completion(.found(feed: localFeedImages, timestamp: cache.timestamp))
				} else {
					completion(.empty)
				}
			} catch {
				completion(.failure(error))
			}
		}
	}

	public func insert(_ feed: [LocalFeedImage], timestamp: Date, completion: @escaping InsertionCompletion) {
		let context = context
		context.perform {
			let fetchRequest: NSFetchRequest<ManagedCache> = ManagedCache.fetchRequest()
			let cache: ManagedCache
			if let fetchedCache = try? context.fetch(fetchRequest).first {
				cache = fetchedCache
				cache.feedImages = []
			} else {
				cache = ManagedCache(entity: ManagedCache.entity(), insertInto: context)
			}
			let managedFeedImages = Self.createManagedFeedImage(from: feed, insertInto: context)
			cache.timestamp = timestamp
			cache.insertIntoFeedImagesOrderedSet(managedFeedImages, at: NSIndexSet(indexesIn: NSRange(location: 0, length: feed.count)))
			completion(nil)
		}
	}

	public func deleteCachedFeed(completion: @escaping DeletionCompletion) {
		fatalError("Must be implemented")
	}

	private static func createManagedFeedImage(from feed: [LocalFeedImage], insertInto context: NSManagedObjectContext) -> [ManagedFeedImage] {
		feed.map {
			let managedFeedImage = ManagedFeedImage(context: context)
			managedFeedImage.id = $0.id
			managedFeedImage.descriptionString = $0.description
			managedFeedImage.location = $0.location
			managedFeedImage.url = $0.url
			return managedFeedImage
		}
	}
}

private extension ManagedFeedImage {
	var localFeedImage: LocalFeedImage {
		LocalFeedImage(id: self.id, description: self.descriptionString, location: self.location, url: self.url)
	}
}
