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
	@NSManaged public var feedImages: NSOrderedSet?
}

// MARK: Generated accessors for feedImages
extension ManagedCache {
	@objc(insertObject:inFeedImagesAtIndex:)
	@NSManaged public func insertIntoFeedImages(_ value: ManagedFeedImage, at idx: Int)

	@objc(removeObjectFromFeedImagesAtIndex:)
	@NSManaged public func removeFromFeedImages(at idx: Int)

	@objc(insertFeedImages:atIndexes:)
	@NSManaged public func insertIntoFeedImages(_ values: [ManagedFeedImage], at indexes: NSIndexSet)

	@objc(removeFeedImagesAtIndexes:)
	@NSManaged public func removeFromFeedImages(at indexes: NSIndexSet)

	@objc(replaceObjectInFeedImagesAtIndex:withObject:)
	@NSManaged public func replaceFeedImages(at idx: Int, with value: ManagedFeedImage)

	@objc(replaceFeedImagesAtIndexes:withFeedImages:)
	@NSManaged public func replaceFeedImages(at indexes: NSIndexSet, with values: [ManagedFeedImage])

	@objc(addFeedImagesObject:)
	@NSManaged public func addToFeedImages(_ value: ManagedFeedImage)

	@objc(removeFeedImagesObject:)
	@NSManaged public func removeFromFeedImages(_ value: ManagedFeedImage)

	@objc(addFeedImages:)
	@NSManaged public func addToFeedImages(_ values: NSOrderedSet)

	@objc(removeFeedImages:)
	@NSManaged public func removeFromFeedImages(_ values: NSOrderedSet)
}

extension ManagedCache: Identifiable {}
