//
//  MakkahPlayerListBaseClass.swift
//
//  Created by naman on 19/02/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class MakkahPlayerListBaseClass: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let metadata = "metadata"
    static let livestreams = "livestreams"
    static let entries = "entries"
    static let updates = "updates"
  }

  // MARK: Properties
  public var metadata: MakkahPlayerListMetadata?
  public var livestreams: [Any]?
  public var entries: [MakkahPlayerListEntries]?
  public var updates: [Any]?

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
    metadata = MakkahPlayerListMetadata(json: json[SerializationKeys.metadata])
    if let items = json[SerializationKeys.livestreams].array { livestreams = items.map { $0.object} }
    if let items = json[SerializationKeys.entries].array { entries = items.map { MakkahPlayerListEntries(json: $0) } }
    if let items = json[SerializationKeys.updates].array { updates = items.map { $0.object} }
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = metadata { dictionary[SerializationKeys.metadata] = value.dictionaryRepresentation() }
    if let value = livestreams { dictionary[SerializationKeys.livestreams] = value }
    if let value = entries { dictionary[SerializationKeys.entries] = value.map { $0.dictionaryRepresentation() } }
    if let value = updates { dictionary[SerializationKeys.updates] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.metadata = aDecoder.decodeObject(forKey: SerializationKeys.metadata) as? MakkahPlayerListMetadata
    self.livestreams = aDecoder.decodeObject(forKey: SerializationKeys.livestreams) as? [Any]
    self.entries = aDecoder.decodeObject(forKey: SerializationKeys.entries) as? [MakkahPlayerListEntries]
    self.updates = aDecoder.decodeObject(forKey: SerializationKeys.updates) as? [Any]
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(metadata, forKey: SerializationKeys.metadata)
    aCoder.encode(livestreams, forKey: SerializationKeys.livestreams)
    aCoder.encode(entries, forKey: SerializationKeys.entries)
    aCoder.encode(updates, forKey: SerializationKeys.updates)
  }

}
