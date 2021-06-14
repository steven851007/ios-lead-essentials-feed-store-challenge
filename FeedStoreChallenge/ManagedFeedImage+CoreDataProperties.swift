//
//  ManagedFeedImage+CoreDataProperties.swift
//  FeedStoreChallenge
//
//  Created by Istvan Private on 14.06.21.
//  Copyright © 2021 Essential Developer. All rights reserved.
//
//

import Foundation
import CoreData

class ManagedFeedImageStore {
	private let context: NSManagedObjectContext

	init(context: NSManagedObjectContext) {
		self.context = context
	}

	func newObject() -> ManagedFeedImage {
		ManagedFeedImage(entity: ManagedFeedImage.entity(), insertInto: context)
	}

	func feedImage(from feed: LocalFeedImage) -> ManagedFeedImage {
		let managedFeedImage = newObject()
		managedFeedImage.id = feed.id
		managedFeedImage.descriptionString = feed.description
		managedFeedImage.location = feed.location
		managedFeedImage.url = feed.url
		return managedFeedImage
	}

	func fetchRequest() -> NSFetchRequest<ManagedFeedImage> {
		ManagedFeedImage.fetchRequest()
	}
}

@objc(ManagedFeedImage)
public class ManagedFeedImage: NSManagedObject {
	@nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedFeedImage> {
		return NSFetchRequest<ManagedFeedImage>(entityName: "ManagedFeedImage")
	}

	@NSManaged public var id: UUID
	@NSManaged public var descriptionString: String?
	@NSManaged public var location: String?
	@NSManaged public var url: URL
	@NSManaged public var cache: ManagedCache?
}

extension ManagedFeedImage: Identifiable {}
