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

@objc(ManagedFeedImage)
public class ManagedFeedImage: NSManagedObject {
	@nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedFeedImage> {
		return NSFetchRequest<ManagedFeedImage>(entityName: "ManagedFeedImage")
	}

	@NSManaged public var id: UUID
	@NSManaged public var descriptionString: String?
	@NSManaged public var location: String?
	@NSManaged public var url: URL
}

extension ManagedFeedImage: Identifiable {}
