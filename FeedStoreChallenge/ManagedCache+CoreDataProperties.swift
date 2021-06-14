//
//  ManagedCache+CoreDataProperties.swift
//  FeedStoreChallenge
//
//  Created by Istvan Private on 14.06.21.
//  Copyright © 2021 Essential Developer. All rights reserved.
//
//

import Foundation
import CoreData

@objc(ManagedCache)
public class ManagedCache: NSManagedObject {
	@nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedCache> {
		return NSFetchRequest<ManagedCache>(entityName: "ManagedCache")
	}

	@NSManaged public var timestamp: Date?
	@NSManaged private var feedImagesOrderedSet: NSOrderedSet?

	public var feedImages: [ManagedFeedImage] {
		feedImagesOrderedSet?.array as? [ManagedFeedImage] ?? []
	}
}

extension ManagedCache {
	@objc(insertObject:inFeedImagesOrderedSetAtIndex:)
	@NSManaged public func insertIntoFeedImagesOrderedSet(_ value: ManagedFeedImage, at idx: Int)

	@objc(removeObjectFromFeedImagesOrderedSetAtIndex:)
	@NSManaged public func removeFromFeedImagesOrderedSet(at idx: Int)

	@objc(insertFeedImagesOrderedSet:atIndexes:)
	@NSManaged public func insertIntoFeedImagesOrderedSet(_ values: [ManagedFeedImage], at indexes: NSIndexSet)

	@objc(removeFeedImagesOrderedSetAtIndexes:)
	@NSManaged public func removeFromFeedImagesOrderedSet(at indexes: NSIndexSet)

	@objc(replaceObjectInFeedImagesOrderedSetAtIndex:withObject:)
	@NSManaged public func replaceFeedImagesOrderedSet(at idx: Int, with value: ManagedFeedImage)

	@objc(replaceFeedImagesOrderedSetAtIndexes:withFeedImagesOrderedSet:)
	@NSManaged public func replaceFeedImagesOrderedSet(at indexes: NSIndexSet, with values: [ManagedFeedImage])

	@objc(addFeedImagesOrderedSetObject:)
	@NSManaged public func addToFeedImagesOrderedSet(_ value: ManagedFeedImage)

	@objc(removeFeedImagesOrderedSetObject:)
	@NSManaged public func removeFromFeedImagesOrderedSet(_ value: ManagedFeedImage)

	@objc(addFeedImagesOrderedSet:)
	@NSManaged public func addToFeedImagesOrderedSet(_ values: NSOrderedSet)

	@objc(removeFeedImagesOrderedSet:)
	@NSManaged public func removeFromFeedImagesOrderedSet(_ values: NSOrderedSet)
}

extension ManagedCache: Identifiable {}
