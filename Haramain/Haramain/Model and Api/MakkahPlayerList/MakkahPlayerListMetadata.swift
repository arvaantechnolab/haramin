//
//  MakkahPlayerListMetadata.swift
//
//  Created by naman on 19/02/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class MakkahPlayerListMetadata: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let lastUpdated = "last_updated"
    static let nextEntryId = "next_entry_id"
  }

  // MARK: Properties
  public var lastUpdated: Int?
  public var nextEntryId: Int?

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
    lastUpdated = json[SerializationKeys.lastUpdated].int
    nextEntryId = json[SerializationKeys.nextEntryId].int
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = lastUpdated { dictionary[SerializationKeys.lastUpdated] = value }
    if let value = nextEntryId { dictionary[SerializationKeys.nextEntryId] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.lastUpdated = aDecoder.decodeObject(forKey: SerializationKeys.lastUpdated) as? Int
    self.nextEntryId = aDecoder.decodeObject(forKey: SerializationKeys.nextEntryId) as? Int
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(lastUpdated, forKey: SerializationKeys.lastUpdated)
    aCoder.encode(nextEntryId, forKey: SerializationKeys.nextEntryId)
  }

}
