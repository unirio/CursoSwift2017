//
//  Secao+CoreDataProperties.swift
//  listamercado
//
//  Created by Marcio Barros on 02/02/17.
//  Copyright © 2017 br.unirio.ios. All rights reserved.
//

import Foundation
import CoreData


extension Secao {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Secao> {
        return NSFetchRequest<Secao>(entityName: "Secao");
    }

    @NSManaged public var nome: String?
    @NSManaged public var items: NSSet?

}

// MARK: Generated accessors for items
extension Secao {

    @objc(addItemsObject:)
    @NSManaged public func addToItems(_ value: Item)

    @objc(removeItemsObject:)
    @NSManaged public func removeFromItems(_ value: Item)

    @objc(addItems:)
    @NSManaged public func addToItems(_ values: NSSet)

    @objc(removeItems:)
    @NSManaged public func removeFromItems(_ values: NSSet)

}
