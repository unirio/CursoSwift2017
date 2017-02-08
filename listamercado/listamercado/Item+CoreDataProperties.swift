//
//  Item+CoreDataProperties.swift
//  listamercado
//
//  Created by Marcio Barros on 02/02/17.
//  Copyright © 2017 br.unirio.ios. All rights reserved.
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item");
    }

    @NSManaged public var comprado: NSNumber?
    @NSManaged public var nome: String?
    @NSManaged public var quantidade: NSNumber?
    @NSManaged public var secao: Secao?

}
