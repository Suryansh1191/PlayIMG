//
//  Image+CoreDataProperties.swift
//  PlayIMG
//
//  Created by suryansh Bisen on 24/09/22.
//
//

import Foundation
import CoreData


extension Image {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Image> {
        return NSFetchRequest<Image>(entityName: "Image")
    }

    @NSManaged public var image: Data?
    @NSManaged public var url: String?
    @NSManaged public var date: Date?

}

extension Image : Identifiable {

}
