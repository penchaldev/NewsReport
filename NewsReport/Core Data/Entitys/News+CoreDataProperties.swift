//
//  News+CoreDataProperties.swift
//  NewsReport
//
//  Created by Vijay on 15/08/20.
//  Copyright © 2020 senix.com. All rights reserved.
//
//

import Foundation
import CoreData


extension News {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<News> {
        return NSFetchRequest<News>(entityName: "News")
    }

    @NSManaged public var title: String?
    @NSManaged public var articleDescription: String?
    @NSManaged public var urlToImage: String?

}
