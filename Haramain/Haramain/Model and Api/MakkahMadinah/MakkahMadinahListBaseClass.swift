//
//  MakkahMadinahListBaseClass.swift
//
//  Created by naman on 18/02/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class MakkahMadinahListBaseClass: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let shortNameAr = "short_name_ar"
    static let name = "name"
    static let id = "id"
    static let shortName = "short_name"
    static let nameAr = "name_ar"
    static let locationId = "location_id"
  }

  // MARK: Properties
  public var shortNameAr: String?
  public var name: String?
  public var id: Int?
  public var shortName: String?
  public var nameAr: String?
  public var locationId: Int?

  // MARK: SwiftyJSON Initializers
  /// Initiates the instance based on the object.
  ///
  /// - parameter object: The object of either Dictionary or Array kind that was passed.
  /// - returns: An initialized instance of the class.
  public convenience init(object: Any) {
    self.init(json: JSON(object))
  }

  /// Initiates the instance based on the JSON that was passed.
  ///
  /// - parameter json: JSON object from SwiftyJSON.
  public required init(json: JSON) {
    shortNameAr = json[SerializationKeys.shortNameAr].string
    name = json[SerializationKeys.name].string
    id = json[SerializationKeys.id].int
    shortName = json[SerializationKeys.shortName].string
    nameAr = json[SerializationKeys.nameAr].string
    locationId = json[SerializationKeys.locationId].int
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = shortNameAr { dictionary[SerializationKeys.shortNameAr] = value }
    if let value = name { dictionary[SerializationKeys.name] = value }
    if let value = id { dictionary[SerializationKeys.id] = value }
    if let value = shortName { dictionary[SerializationKeys.shortName] = value }
    if let value = nameAr { dictionary[SerializationKeys.nameAr] = value }
    if let value = locationId { dictionary[SerializationKeys.locationId] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.shortNameAr = aDecoder.decodeObject(forKey: SerializationKeys.shortNameAr) as? String
    self.name = aDecoder.decodeObject(forKey: SerializationKeys.name) as? String
    self.id = aDecoder.decodeObject(forKey: SerializationKeys.id) as? Int
    self.shortName = aDecoder.decodeObject(forKey: SerializationKeys.shortName) as? String
    self.nameAr = aDecoder.decodeObject(forKey: SerializationKeys.nameAr) as? String
    self.locationId = aDecoder.decodeObject(forKey: SerializationKeys.locationId) as? Int
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(shortNameAr, forKey: SerializationKeys.shortNameAr)
    aCoder.encode(name, forKey: SerializationKeys.name)
    aCoder.encode(id, forKey: SerializationKeys.id)
    aCoder.encode(shortName, forKey: SerializationKeys.shortName)
    aCoder.encode(nameAr, forKey: SerializationKeys.nameAr)
    aCoder.encode(locationId, forKey: SerializationKeys.locationId)
  }

}
