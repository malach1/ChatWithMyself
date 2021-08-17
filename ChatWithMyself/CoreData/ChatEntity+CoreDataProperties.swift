//
//  ChatEntity+CoreDataProperties.swift
//  ChatWithMyself
//
//  Created by Malachi Hul on 2021/08/17.
//
//

import Foundation
import CoreData


extension ChatEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ChatEntity> {
        return NSFetchRequest<ChatEntity>(entityName: "ChatEntity")
    }

    @NSManaged public var message: String?
    @NSManaged public var sender: Bool
    @NSManaged public var username: String?

}

extension ChatEntity : Identifiable {

}
