//
//  Copyright © 2021 Essential Developer. All rights reserved.
//

import CoreData

public final class CoreDataFeedStore: FeedStore {
	private static let modelName = "FeedStore"
	private static let model = NSManagedObjectModel(name: modelName, in: Bundle(for: CoreDataFeedStore.self))

	private let container: NSPersistentContainer
	private let context: NSManagedObjectContext
	private let cacheStore: ManagedCacheStore
	private let feedImageStore: ManagedFeedImageStore

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
		cacheStore = ManagedCacheStore(context: context)
		feedImageStore = ManagedFeedImageStore(context: context)
	}

	public func retrieve(completion: @escaping RetrievalCompletion) {
		let cacheStore = cacheStore
		context.perform {
			do {
				if let cache = try cacheStore.cache() {
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
		let cacheStore = cacheStore
		let feedImageStore = feedImageStore
		context.perform {
			do {
				let cache = try cacheStore.existingCacheOrNewOne()
				let managedFeedImages = feed.map { feedImageStore.feedImage(from: $0) }
				cache.timestamp = timestamp
				cache.feedImages = managedFeedImages
				try cacheStore.save()
				completion(nil)
			} catch {
				completion(error)
			}
		}
	}

	public func deleteCachedFeed(completion: @escaping DeletionCompletion) {
		fatalError("Must be implemented")
	}
}

private extension ManagedFeedImage {
	var localFeedImage: LocalFeedImage {
		LocalFeedImage(id: self.id, description: self.descriptionString, location: self.location, url: self.url)
	}
}
